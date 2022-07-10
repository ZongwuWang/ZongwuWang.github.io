---
title: Analysis of gem5 O3CPU Compute Instructions
password: www
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
date: 2022-03-02 09:34:57
tags:
- gem5
- Simulator
categories: 计算机体系架构
---

# Analysis of gem5 O3CPU Compute Instructions

计算指令比较简单，由于它们不访问内存，因此不需要与 LSQ 交互。下面包括一个高级调用链（仅重要函数），并描述了每个函数的功能。

```c
Rename::tick()->Rename::RenameInsts()
IEW::tick()->IEW::dispatchInsts()
IEW::tick()->InstructionQueue::scheduleReadyInsts()
IEW::tick()->IEW::executeInsts()
IEW::tick()->IEW::writebackInsts()
Commit::tick()->Commit::commitInsts()->Commit::commitHead()
```

- Rename: 重命名寄存器，指令被推送到IEW阶段。它检查IQ/LSQ是否可以保存新指令
- Dispatch: 将重命名的指令插入IQ和LSQ
- Schedule: IQ管理就绪列表中的就绪指令（操作数就绪），并将它们调度到可用的FU。FU的延迟在这里设置，当FU完成时，指令被发送到Execute
- Writeback: 这里调用了InstructionQueue:：wakeDependents（）。相关指令将添加到准备就绪列表中，以进行调度
- 一旦指令到达ROB的头部，它将被提交并从ROB中释放

以上是[gem5官方文档](https://www.gem5.org/documentation/general_docs/cpu_models/O3CPU)的介绍，接下来实际探索源码。

```c{.line-numbers}
void
Rename::renameInsts(ThreadID tid)
{
    // Instructions can be either in the skid buffer or the queue of
    // instructions coming from decode, depending on the status.
    int insts_available = renameStatus[tid] == Unblocking ?
        skidBuffer[tid].size() : insts[tid].size();

    // Check the decode queue to see if instructions are available.
    // If there are no available instructions to rename, then do nothing.
    if (insts_available == 0) {
        DPRINTF(Rename, "[tid:%i] Nothing to do, breaking out early.\n",
                tid);
        // Should I change status to idle?
        ++stats.idleCycles;
        return;
    } else if (renameStatus[tid] == Unblocking) {
        ++stats.unblockCycles;
    } else if (renameStatus[tid] == Running) {
        ++stats.runCycles;
    }

    // Will have to do a different calculation for the number of free
    // entries.
    int free_rob_entries = calcFreeROBEntries(tid);
    int free_iq_entries  = calcFreeIQEntries(tid);
    int min_free_entries = free_rob_entries;

    FullSource source = ROB;

    if (free_iq_entries < min_free_entries) {
        min_free_entries = free_iq_entries;
        source = IQ;
    }

    // Check if there's any space left.
    if (min_free_entries <= 0) {
        DPRINTF(Rename,
                "[tid:%i] Blocking due to no free ROB/IQ/ entries.\n"
                "ROB has %i free entries.\n"
                "IQ has %i free entries.\n",
                tid, free_rob_entries, free_iq_entries);

        blockThisCycle = true;

        block(tid);

        incrFullStat(source);

        return;
    } else if (min_free_entries < insts_available) {
        DPRINTF(Rename,
                "[tid:%i] "
                "Will have to block this cycle. "
                "%i insts available, "
                "but only %i insts can be renamed due to ROB/IQ/LSQ limits.\n",
                tid, insts_available, min_free_entries);

        insts_available = min_free_entries;

        blockThisCycle = true;

        incrFullStat(source);
    }

    InstQueue &insts_to_rename = renameStatus[tid] == Unblocking ?
        skidBuffer[tid] : insts[tid];

    DPRINTF(Rename,
            "[tid:%i] "
            "%i available instructions to send iew.\n",
            tid, insts_available);

    DPRINTF(Rename,
            "[tid:%i] "
            "%i insts pipelining from Rename | "
            "%i insts dispatched to IQ last cycle.\n",
            tid, instsInProgress[tid], fromIEW->iewInfo[tid].dispatched);

    // Handle serializing the next instruction if necessary.
    if (serializeOnNextInst[tid]) {
        if (emptyROB[tid] && instsInProgress[tid] == 0) {
            // ROB already empty; no need to serialize.
            serializeOnNextInst[tid] = false;
        } else if (!insts_to_rename.empty()) {
            insts_to_rename.front()->setSerializeBefore();
        }
    }

    int renamed_insts = 0;

    while (insts_available > 0 &&  toIEWIndex < renameWidth) {
        DPRINTF(Rename, "[tid:%i] Sending instructions to IEW.\n", tid);

        assert(!insts_to_rename.empty());

        DynInstPtr inst = insts_to_rename.front();

        //For all kind of instructions, check ROB and IQ first For load
        //instruction, check LQ size and take into account the inflight loads
        //For store instruction, check SQ size and take into account the
        //inflight stores

        if (inst->isLoad()) {
            if (calcFreeLQEntries(tid) <= 0) {
                DPRINTF(Rename, "[tid:%i] Cannot rename due to no free LQ\n",
                        tid);
                source = LQ;
                incrFullStat(source);
                break;
            }
        }

        if (inst->isStore() || inst->isAtomic()) {
            if (calcFreeSQEntries(tid) <= 0) {
                DPRINTF(Rename, "[tid:%i] Cannot rename due to no free SQ\n",
                        tid);
                source = SQ;
                incrFullStat(source);
                break;
            }
        }

        insts_to_rename.pop_front();

        if (renameStatus[tid] == Unblocking) {
            DPRINTF(Rename,
                    "[tid:%i] "
                    "Removing [sn:%llu] PC:%s from rename skidBuffer\n",
                    tid, inst->seqNum, inst->pcState());
        }

        if (inst->isSquashed()) {
            DPRINTF(Rename,
                    "[tid:%i] "
                    "instruction %i with PC %s is squashed, skipping.\n",
                    tid, inst->seqNum, inst->pcState());

            ++stats.squashedInsts;

            // Decrement how many instructions are available.
            --insts_available;

            continue;
        }

        DPRINTF(Rename,
                "[tid:%i] "
                "Processing instruction [sn:%llu] with PC %s.\n",
                tid, inst->seqNum, inst->pcState());

        // Check here to make sure there are enough destination registers
        // to rename to.  Otherwise block.
        if (!renameMap[tid]->canRename(inst->numIntDestRegs(),
                                       inst->numFPDestRegs(),
                                       inst->numVecDestRegs(),
                                       inst->numVecElemDestRegs(),
                                       inst->numVecPredDestRegs(),
                                       inst->numCCDestRegs())) {
            DPRINTF(Rename,
                    "Blocking due to "
                    " lack of free physical registers to rename to.\n");
            blockThisCycle = true;
            insts_to_rename.push_front(inst);
            ++stats.fullRegistersEvents;

            break;
        }

        // Handle serializeAfter/serializeBefore instructions.
        // serializeAfter marks the next instruction as serializeBefore.
        // serializeBefore makes the instruction wait in rename until the ROB
        // is empty.

        // In this model, IPR accesses are serialize before
        // instructions, and store conditionals are serialize after
        // instructions.  This is mainly due to lack of support for
        // out-of-order operations of either of those classes of
        // instructions.
        if (inst->isSerializeBefore() && !inst->isSerializeHandled()) {
            DPRINTF(Rename, "Serialize before instruction encountered.\n");

            if (!inst->isTempSerializeBefore()) {
                stats.serializing++;
                inst->setSerializeHandled();
            } else {
                stats.tempSerializing++;
            }

            // Change status over to SerializeStall so that other stages know
            // what this is blocked on.
            renameStatus[tid] = SerializeStall;

            serializeInst[tid] = inst;

            blockThisCycle = true;

            break;
        } else if ((inst->isStoreConditional() || inst->isSerializeAfter()) &&
                   !inst->isSerializeHandled()) {
            DPRINTF(Rename, "Serialize after instruction encountered.\n");

            stats.serializing++;

            inst->setSerializeHandled();

            serializeAfter(insts_to_rename, tid);
        }

        renameSrcRegs(inst, inst->threadNumber);

        renameDestRegs(inst, inst->threadNumber);

        if (inst->isAtomic() || inst->isStore()) {
            storesInProgress[tid]++;
        } else if (inst->isLoad()) {
            loadsInProgress[tid]++;
        }

        ++renamed_insts;
        // Notify potential listeners that source and destination registers for
        // this instruction have been renamed.
        ppRename->notify(inst);

        // Put instruction in rename queue.
        toIEW->insts[toIEWIndex] = inst;
        ++(toIEW->size);

        // Increment which instruction we're on.
        ++toIEWIndex;

        // Decrement how many instructions are available.
        --insts_available;
    }

    instsInProgress[tid] += renamed_insts;
    stats.renamedInsts += renamed_insts;

    // If we wrote to the time buffer, record this.
    if (toIEWIndex) {
        wroteToTimeBuffer = true;
    }

    // Check if there's any instructions left that haven't yet been renamed.
    // If so then block.
    if (insts_available) {
        blockThisCycle = true;
    }

    if (blockThisCycle) {
        block(tid);
        toDecode->renameUnblock[tid] = false;
    }
}
```