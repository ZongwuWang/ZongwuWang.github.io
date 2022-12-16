---
title: The most complete list of -XX options for Java JVM
categories:
  - 编程开发
password: www
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
date: 2022-12-05 16:39:56
tags:
- Java
- JDK
- JVM
---

网上找到一篇JVM -XX参数大全，转载过来，如果要看某个Java版本支持哪些XX参数，可以执行如下命令：
java -XX:+UnlockDiagnosticVMOptions -XX:+PrintFlagsFinal -version

- **product** flags are always settable / visible
- develop flags are settable / visible only during development and are constant in the PRODUCT version
- **notproduct** flags are settable / visible only during development and are not declared in the PRODUCT version
- **diagnostic** options not meant for VM tuning or for product modes. They are to be used for VM quality assurance or field diagnosis of VM bugs. They are hidden so that users will not be encouraged to try them as if they were VM ordinary execution options. However, they are available in the product version of the VM. Under instruction from support engineers, VM customers can turn them on to collect diagnostic information about VM problems. To use a VM diagnostic option, you must first specify +UnlockDiagnosticVMOptions. (This master switch also affects the behavior of -Xprintflags.)
- **manageable** flags are writeable external product flags. They are dynamically writeable through the JDK management interface (com.sun.management.HotSpotDiagnosticMXBean API) and also through JConsole. These flags are external exported interface (see CCC). The list of manageable flags can be queried programmatically through the management interface.
- **experimental** experimental options which become available just after XX:+UnlockExperimentalVMOptions flag is set.
- **product_rw** flags are writeable internal product flags. They are like “manageable” flags but for internal/private use. The list of product_rw flags are internal/private flags which may be changed/removed in a future release. It can be set through the management interface to get/set value when the name of flag is supplied.
- **product_pd**
- **develop_pd**

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-elk0{background-color:#FFF;color:#58A;text-align:left;vertical-align:middle}
.tg .tg-5ws4{background-color:#FFF;color:#333;font-weight:bold;text-align:center;vertical-align:middle}
.tg .tg-17st{background-color:#FFF;border-color:inherit;color:#333;font-weight:bold;text-align:center;vertical-align:middle}
.tg .tg-vp9j{background-color:#E0E0E0;color:#0563C1;text-align:left;text-decoration:underline;vertical-align:top}
.tg .tg-7fd7{background-color:#FFF;color:#333;text-align:left;vertical-align:middle}
.tg .tg-wogo{background-color:#FFF;color:#0563C1;text-align:left;text-decoration:underline;vertical-align:top}
</style>
<table class="tg">
<thead>
  <tr>
    <th class="tg-17st">Name</th>
    <th class="tg-5ws4">Description</th>
    <th class="tg-5ws4">Default</th>
    <th class="tg-5ws4">Type</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-vp9j" colspan="4"><a href="https://stas-blogspot.blogspot.com/2011/07/most-complete-list-of-xx-options-for.html">product</a></td>
  </tr>
  <tr>
    <td class="tg-elk0">UseMembar</td>
    <td class="tg-7fd7">(Unstable)&nbsp;&nbsp;&nbsp;Issues membars on thread state transitions</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UnlockCommercialFeatures</td>
    <td class="tg-7fd7">Enables&nbsp;&nbsp;&nbsp;Oracle Java SE users to control when licensed features are allowed to run.&nbsp;&nbsp;&nbsp;Since Java SE 7 Update 4.</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintCommandLineFlags</td>
    <td class="tg-7fd7">Prints&nbsp;&nbsp;&nbsp;flags that appeared on the command line</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseGCLogFileRotation</td>
    <td class="tg-7fd7">Prevent&nbsp;&nbsp;&nbsp;large gclog file for long running app. Requires -Xloggc:&lt;filename&gt;.&nbsp;&nbsp;&nbsp;Since Java7.</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">NumberOfGCLogFiles</td>
    <td class="tg-7fd7">Number&nbsp;&nbsp;&nbsp;of gclog files in rotation. Default: 0, no rotation. Only valid with&nbsp;&nbsp;&nbsp;UseGCLogFileRotation. Since Java7.</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">GCLogFileSize</td>
    <td class="tg-7fd7">GC&nbsp;&nbsp;&nbsp;log file size, Default: 0 bytes, no rotation. Only valid with&nbsp;&nbsp;&nbsp;UseGCLogFileRotation. Since Java7.</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">JavaMonitorsInStackTrace</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;info. about Java monitor locks when the stacks are dumped</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">LargePageSizeInBytes</td>
    <td class="tg-7fd7">Large&nbsp;&nbsp;&nbsp;page size (0 to let VM choose the page size</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">LargePageHeapSizeThreshold</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;large pages if max heap is at least this big</td>
    <td class="tg-7fd7">128*M</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">ForceTimeHighResolution</td>
    <td class="tg-7fd7">Using&nbsp;&nbsp;&nbsp;high time resolution(For Win32 only)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintVMQWaitTime</td>
    <td class="tg-7fd7">Prints&nbsp;&nbsp;&nbsp;out the waiting time in VM operation queue</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintJNIResolving</td>
    <td class="tg-7fd7">Used&nbsp;&nbsp;&nbsp;to implement -v:jni</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseInlineCaches</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;Inline Caches for virtual calls</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseCompilerSafepoints</td>
    <td class="tg-7fd7">Stop&nbsp;&nbsp;&nbsp;at safepoints in compiled code</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseSplitVerifier</td>
    <td class="tg-7fd7">use&nbsp;&nbsp;&nbsp;split verifier with StackMapTable attributes</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">FailOverToOldVerifier</td>
    <td class="tg-7fd7">fail&nbsp;&nbsp;&nbsp;over to old verifier when split verifier fails</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">SuspendRetryCount</td>
    <td class="tg-7fd7">Maximum&nbsp;&nbsp;&nbsp;retry count for an external suspend request</td>
    <td class="tg-7fd7">50</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">SuspendRetryDelay</td>
    <td class="tg-7fd7">Milliseconds&nbsp;&nbsp;&nbsp;to delay per retry (* current_retry_count)</td>
    <td class="tg-7fd7">5</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseSuspendResumeThreadLists</td>
    <td class="tg-7fd7">Enable&nbsp;&nbsp;&nbsp;SuspendThreadList and ResumeThreadList</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">MaxFDLimit</td>
    <td class="tg-7fd7">Bump&nbsp;&nbsp;&nbsp;the number of file descriptors to max in solaris.</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">BytecodeVerificationRemote</td>
    <td class="tg-7fd7">Enables&nbsp;&nbsp;&nbsp;the Java bytecode verifier for remote classes</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">BytecodeVerificationLocal</td>
    <td class="tg-7fd7">Enables&nbsp;&nbsp;&nbsp;the Java bytecode verifier for local classes</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintGCApplicationConcurrentTime</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;the time the application has been running</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintGCApplicationStoppedTime</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;the time the application has been stopped</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ShowMessageBoxOnError</td>
    <td class="tg-7fd7">Keep&nbsp;&nbsp;&nbsp;process alive on VM fatal error</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">SuppressFatalErrorMessage</td>
    <td class="tg-7fd7">Do&nbsp;&nbsp;&nbsp;NO Fatal Error report [Avoid deadlock]</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">OnError</td>
    <td class="tg-7fd7">Run&nbsp;&nbsp;&nbsp;user-defined commands on fatal error; see VMError.cpp for examples</td>
    <td class="tg-7fd7">""</td>
    <td class="tg-7fd7">ccstr</td>
  </tr>
  <tr>
    <td class="tg-elk0">OnOutOfMemoryError</td>
    <td class="tg-7fd7">Run&nbsp;&nbsp;&nbsp;user-defined commands on first java.lang.OutOfMemoryError</td>
    <td class="tg-7fd7">""</td>
    <td class="tg-7fd7">ccstr</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintCompilation</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;compilations</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">StackTraceInThrowable</td>
    <td class="tg-7fd7">Collect&nbsp;&nbsp;&nbsp;backtrace in throwable when exception happens</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">OmitStackTraceInFastThrow</td>
    <td class="tg-7fd7">Omit&nbsp;&nbsp;&nbsp;backtraces for some 'hot' exceptions in optimized code</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ProfilerPrintByteCodeStatistics</td>
    <td class="tg-7fd7">Prints&nbsp;&nbsp;&nbsp;byte code statictics when dumping profiler output</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ProfilerRecordPC</td>
    <td class="tg-7fd7">Collects&nbsp;&nbsp;&nbsp;tick for each 16 byte interval of compiled code</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseNUMA</td>
    <td class="tg-wogo"><a href="https://blogs.oracle.com/jonthecollector/entry/help_for_the_numa_weary">Enables&nbsp;&nbsp;&nbsp;NUMA support. See details here</a></td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ProfileVM</td>
    <td class="tg-7fd7">Profiles&nbsp;&nbsp;&nbsp;ticks that fall within VM (either in the VM Thread or VM code called through&nbsp;&nbsp;&nbsp;stubs)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ProfileIntervals</td>
    <td class="tg-7fd7">Prints&nbsp;&nbsp;&nbsp;profiles for each interval (see ProfileIntervalsTicks)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">RegisterFinalizersAtInit</td>
    <td class="tg-7fd7">Register&nbsp;&nbsp;&nbsp;finalizable objects at end of Object. or after allocation.</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ClassUnloading</td>
    <td class="tg-7fd7">Do&nbsp;&nbsp;&nbsp;unloading of classes</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ConvertYieldToSleep</td>
    <td class="tg-7fd7">Converts&nbsp;&nbsp;&nbsp;yield to a sleep of MinSleepInterval to simulate Win32 behavior (SOLARIS&nbsp;&nbsp;&nbsp;only)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseBoundThreads</td>
    <td class="tg-7fd7">Bind&nbsp;&nbsp;&nbsp;user level threads to kernel threads (for SOLARIS only)</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseLWPSynchronization</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;LWP-based instead of libthread-based synchronization (SPARC only)</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">SyncKnobs</td>
    <td class="tg-7fd7">(Unstable)&nbsp;&nbsp;&nbsp;Various monitor synchronization tunables</td>
    <td class="tg-7fd7">""</td>
    <td class="tg-7fd7">ccstr</td>
  </tr>
  <tr>
    <td class="tg-elk0">EmitSync</td>
    <td class="tg-7fd7">(Unsafe,Unstable)&nbsp;&nbsp;&nbsp;Controls emission of inline sync fast-path code</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">AlwaysInflate</td>
    <td class="tg-7fd7">(Unstable)&nbsp;&nbsp;&nbsp;Force inflation</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">Atomics</td>
    <td class="tg-7fd7">(Unsafe,Unstable)&nbsp;&nbsp;&nbsp;Diagnostic - Controls emission of atomics</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">EmitLFence</td>
    <td class="tg-7fd7">(Unsafe,Unstable)&nbsp;&nbsp;&nbsp;Experimental</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">AppendRatio</td>
    <td class="tg-7fd7">(Unstable)&nbsp;&nbsp;&nbsp;Monitor queue fairness" ) product(intx, SyncFlags, 0,(Unsafe,Unstable)&nbsp;&nbsp;&nbsp;Experimental Sync flags" ) product(intx, SyncVerbose, 0,(Unstable)"&nbsp;&nbsp;&nbsp;) product(intx, ClearFPUAtPark, 0,(Unsafe,Unstable)" ) product(intx,&nbsp;&nbsp;&nbsp;hashCode, 0, (Unstable) select hashCode generation algorithm" )&nbsp;&nbsp;&nbsp;product(intx, WorkAroundNPTLTimedWaitHang, 1, (Unstable,&nbsp;&nbsp;&nbsp;Linux-specific)" avoid NPTL-FUTEX hang pthread_cond_timedwait" )&nbsp;&nbsp;&nbsp;product(bool, FilterSpuriousWakeups , true, Prevent spurious or premature&nbsp;&nbsp;&nbsp;wakeups from object.wait" (Solaris only)</td>
    <td class="tg-7fd7">11</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">AdjustConcurrency</td>
    <td class="tg-7fd7">call&nbsp;&nbsp;&nbsp;thr_setconcurrency at thread create time to avoid LWP starvation on MP&nbsp;&nbsp;&nbsp;systems (For Solaris Only)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ReduceSignalUsage</td>
    <td class="tg-7fd7">Reduce&nbsp;&nbsp;&nbsp;the use of OS signals in Java and/or the VM</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">AllowUserSignalHandlers</td>
    <td class="tg-7fd7">Do&nbsp;&nbsp;&nbsp;not complain if the application installs signal handlers (Solaris &amp; Linux&nbsp;&nbsp;&nbsp;only)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseSignalChaining</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;signal-chaining to invoke signal handlers installed by the application&nbsp;&nbsp;&nbsp;(Solaris &amp; Linux only)</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseAltSigs</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;alternate signals instead of SIGUSR1 &amp; SIGUSR2 for VM internal signals.&nbsp;&nbsp;&nbsp;(Solaris only)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseSpinning</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;spinning in monitor inflation and before entry</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PreSpinYield</td>
    <td class="tg-7fd7">Yield&nbsp;&nbsp;&nbsp;before inner spinning loop</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PostSpinYield</td>
    <td class="tg-7fd7">Yield&nbsp;&nbsp;&nbsp;after inner spinning loop</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UsePopCountInstruction</td>
    <td class="tg-7fd7">Where&nbsp;&nbsp;&nbsp;possible replaces call to Integer.bitCount() with assembly instruction, i.e.&nbsp;&nbsp;&nbsp;POCCNT on Intel, POPC on Sparc, etc</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">AllowJNIEnvProxy</td>
    <td class="tg-7fd7">Allow&nbsp;&nbsp;&nbsp;JNIEnv proxies for jdbx</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">JNIDetachReleasesMonitors</td>
    <td class="tg-7fd7">JNI&nbsp;&nbsp;&nbsp;DetachCurrentThread releases monitors owned by thread</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">RestoreMXCSROnJNICalls</td>
    <td class="tg-7fd7">Restore&nbsp;&nbsp;&nbsp;MXCSR when returning from JNI calls</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CheckJNICalls</td>
    <td class="tg-7fd7">Verify&nbsp;&nbsp;&nbsp;all arguments to JNI calls</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseFastJNIAccessors</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;optimized versions of GetField</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">EagerXrunInit</td>
    <td class="tg-7fd7">Eagerly&nbsp;&nbsp;&nbsp;initialize -Xrun libraries; allows startup profiling, but not all -Xrun&nbsp;&nbsp;&nbsp;libraries may support the state of the VM at this time</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PreserveAllAnnotations</td>
    <td class="tg-7fd7">Preserve&nbsp;&nbsp;&nbsp;RuntimeInvisibleAnnotations as well as RuntimeVisibleAnnotations</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">LazyBootClassLoader</td>
    <td class="tg-7fd7">Enable/disable&nbsp;&nbsp;&nbsp;lazy opening of boot class path entries</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseBiasedLocking</td>
    <td class="tg-7fd7">Enable&nbsp;&nbsp;&nbsp;biased locking in JVM</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">BiasedLockingStartupDelay</td>
    <td class="tg-7fd7">Number&nbsp;&nbsp;&nbsp;of milliseconds to wait before enabling biased locking</td>
    <td class="tg-7fd7">4000</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">BiasedLockingBulkRebiasThreshold</td>
    <td class="tg-7fd7">Threshold&nbsp;&nbsp;&nbsp;of number of revocations per type to try to rebias all objects in the heap of&nbsp;&nbsp;&nbsp;that type</td>
    <td class="tg-7fd7">20</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">BiasedLockingBulkRevokeThreshold</td>
    <td class="tg-7fd7">Threshold&nbsp;&nbsp;&nbsp;of number of revocations per type to permanently revoke biases of all objects&nbsp;&nbsp;&nbsp;in the heap of that type</td>
    <td class="tg-7fd7">40</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">BiasedLockingDecayTime</td>
    <td class="tg-7fd7">Decay&nbsp;&nbsp;&nbsp;time (in milliseconds) to re-enable bulk rebiasing of a type after previous&nbsp;&nbsp;&nbsp;bulk rebias</td>
    <td class="tg-7fd7">25000</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceJVMTI</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;flags for JVMTI functions and events</td>
    <td class="tg-7fd7">""</td>
    <td class="tg-7fd7">ccstr</td>
  </tr>
  <tr>
    <td class="tg-elk0">StressLdcRewrite</td>
    <td class="tg-7fd7">Force&nbsp;&nbsp;&nbsp;ldc -&gt; ldc_w rewrite during RedefineClasses</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceRedefineClasses</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;level for JVMTI RedefineClasses</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyMergedCPBytecodes</td>
    <td class="tg-7fd7">Verify&nbsp;&nbsp;&nbsp;bytecodes after RedefineClasses constant pool merging</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">HPILibPath</td>
    <td class="tg-7fd7">Specify&nbsp;&nbsp;&nbsp;alternate path to HPI library</td>
    <td class="tg-7fd7">""</td>
    <td class="tg-7fd7">ccstr</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceClassResolution</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;all constant pool resolutions (for debugging)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceBiasedLocking</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;biased locking in JVM</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceMonitorInflation</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;monitor inflation in JVM</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">Use486InstrsOnly</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;80486 Compliant instruction subset</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseSerialGC</td>
    <td class="tg-7fd7">Tells&nbsp;&nbsp;&nbsp;whether the VM should use serial garbage collector</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseParallelGC</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;parallel garbage collection for scavenges. (Introduced in 1.4.1)</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseParallelOldGC</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;parallel garbage collection for the full collections. Enabling this option&nbsp;&nbsp;&nbsp;automatically sets -XX:+UseParallelGC. (Introduced in 5.0 update 6)</td>
    <td class="tg-7fd7">'false'&nbsp;&nbsp;&nbsp;before Java 7 update 4 and 'true' after that version</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseParallelOldGCCompacting</td>
    <td class="tg-7fd7">In&nbsp;&nbsp;&nbsp;the Parallel Old garbage collector use parallel compaction</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseParallelDensePrefixUpdate</td>
    <td class="tg-7fd7">In&nbsp;&nbsp;&nbsp;the Parallel Old garbage collector use parallel dense" prefix update</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">HeapMaximumCompactionInterval</td>
    <td class="tg-7fd7">How&nbsp;&nbsp;&nbsp;often should we maximally compact the heap (not allowing any dead space)</td>
    <td class="tg-7fd7">20</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">HeapFirstMaximumCompactionCount</td>
    <td class="tg-7fd7">The&nbsp;&nbsp;&nbsp;collection count for the first maximum compaction</td>
    <td class="tg-7fd7">3</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseMaximumCompactionOnSystemGC</td>
    <td class="tg-7fd7">In&nbsp;&nbsp;&nbsp;the Parallel Old garbage collector maximum compaction for a system GC</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ParallelOldDeadWoodLimiterMean</td>
    <td class="tg-7fd7">The&nbsp;&nbsp;&nbsp;mean used by the par compact dead wood" limiter (a number between&nbsp;&nbsp;&nbsp;0-100).</td>
    <td class="tg-7fd7">50</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">ParallelOldDeadWoodLimiterStdDev</td>
    <td class="tg-7fd7">The&nbsp;&nbsp;&nbsp;standard deviation used by the par compact dead wood" limiter (a number&nbsp;&nbsp;&nbsp;between 0-100).</td>
    <td class="tg-7fd7">80</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseParallelOldGCDensePrefix</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;a dense prefix with the Parallel Old garbage collector</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ParallelGCThreads</td>
    <td class="tg-7fd7">Number&nbsp;&nbsp;&nbsp;of parallel threads parallel gc will use</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">ParallelCMSThreads</td>
    <td class="tg-7fd7">Max&nbsp;&nbsp;&nbsp;number of threads CMS will use for concurrent work</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">YoungPLABSize</td>
    <td class="tg-7fd7">Size&nbsp;&nbsp;&nbsp;of young gen promotion labs (in HeapWords)</td>
    <td class="tg-7fd7">4096</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">OldPLABSize</td>
    <td class="tg-wogo"><a href="http://aragozin.blogspot.com/2011/10/java-cg-hotspots-cms-and-heap.html">Size&nbsp;&nbsp;&nbsp;of old gen promotion labs (in HeapWords).  See good explanation&nbsp;&nbsp;&nbsp;about that parameter here.</a></td>
    <td class="tg-7fd7">1024</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">GCTaskTimeStampEntries</td>
    <td class="tg-7fd7">Number&nbsp;&nbsp;&nbsp;of time stamp entries per gc worker thread</td>
    <td class="tg-7fd7">200</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">AlwaysTenure</td>
    <td class="tg-7fd7">Always&nbsp;&nbsp;&nbsp;tenure objects in eden. (ParallelGC only)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">NeverTenure</td>
    <td class="tg-7fd7">Never&nbsp;&nbsp;&nbsp;tenure objects in eden, May tenure on overflow" (ParallelGC only)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ScavengeBeforeFullGC</td>
    <td class="tg-7fd7">Scavenge&nbsp;&nbsp;&nbsp;youngest generation before each full GC," used with UseParallelGC</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseCompressedOops</td>
    <td class="tg-wogo"><a href="https://wikis.oracle.com/display/HotSpotInternals/CompressedOops">Enables&nbsp;&nbsp;&nbsp;object-reference compression capabilities via the Compressed References. Have&nbsp;&nbsp;&nbsp;sense just on 64bit JVM. See more details here.</a></td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseConcMarkSweepGC</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;Concurrent Mark-Sweep GC in the old generation</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ExplicitGCInvokesConcurrent</td>
    <td class="tg-7fd7">A&nbsp;&nbsp;&nbsp;System.gc() request invokes a concurrent collection;" (effective only&nbsp;&nbsp;&nbsp;when UseConcMarkSweepGC)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseCMSBestFit</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;CMS best fit allocation strategy</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseCMSCollectionPassing</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;passing of collection from background to foreground</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseParNewGC</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;parallel threads in the new generation.</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ParallelGCVerbose</td>
    <td class="tg-7fd7">Verbose&nbsp;&nbsp;&nbsp;output for parallel GC.</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ParallelGCBufferWastePct</td>
    <td class="tg-7fd7">wasted&nbsp;&nbsp;&nbsp;fraction of parallel allocation buffer.</td>
    <td class="tg-7fd7">10</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">ParallelGCRetainPLAB</td>
    <td class="tg-7fd7">Retain&nbsp;&nbsp;&nbsp;parallel allocation buffers across scavenges.</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TargetPLABWastePct</td>
    <td class="tg-7fd7">target&nbsp;&nbsp;&nbsp;wasted space in last buffer as pct of overall allocation</td>
    <td class="tg-7fd7">10</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">PLABWeight</td>
    <td class="tg-7fd7">Percentage&nbsp;&nbsp;&nbsp;(0-100) used to weight the current sample when" computing exponentially&nbsp;&nbsp;&nbsp;decaying average for ResizePLAB.</td>
    <td class="tg-7fd7">75</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">ResizePLAB</td>
    <td class="tg-7fd7">Dynamically&nbsp;&nbsp;&nbsp;resize (survivor space) promotion labs</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintPLAB</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;(survivor space) promotion labs sizing decisions</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ParGCArrayScanChunk</td>
    <td class="tg-7fd7">Scan&nbsp;&nbsp;&nbsp;a subset and push remainder, if array is bigger than this</td>
    <td class="tg-7fd7">50</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">ParGCDesiredObjsFromOverflowList</td>
    <td class="tg-7fd7">The&nbsp;&nbsp;&nbsp;desired number of objects to claim from the overflow list</td>
    <td class="tg-7fd7">20</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSParPromoteBlocksToClaim</td>
    <td class="tg-7fd7">Number&nbsp;&nbsp;&nbsp;of blocks to attempt to claim when refilling CMS LAB for parallel GC.</td>
    <td class="tg-7fd7">50</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">AlwaysPreTouch</td>
    <td class="tg-7fd7">It&nbsp;&nbsp;&nbsp;forces all freshly committed pages to be pre-touched.</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSUseOldDefaults</td>
    <td class="tg-7fd7">A&nbsp;&nbsp;&nbsp;flag temporarily introduced to allow reverting to some older" default&nbsp;&nbsp;&nbsp;settings; older as of 6.0</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSYoungGenPerWorker</td>
    <td class="tg-7fd7">The&nbsp;&nbsp;&nbsp;amount of young gen chosen by default per GC worker thread available</td>
    <td class="tg-7fd7">16*M</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSIncrementalMode</td>
    <td class="tg-7fd7">Whether&nbsp;&nbsp;&nbsp;CMS GC should operate in \"incremental\" mode</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSIncrementalDutyCycle</td>
    <td class="tg-7fd7">CMS&nbsp;&nbsp;&nbsp;incremental mode duty cycle (a percentage, 0-100). If"&nbsp;&nbsp;&nbsp;CMSIncrementalPacing is enabled, then this is just the initial" value</td>
    <td class="tg-7fd7">10</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSIncrementalPacing</td>
    <td class="tg-7fd7">Whether&nbsp;&nbsp;&nbsp;the CMS incremental mode duty cycle should be automatically adjusted</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSIncrementalDutyCycleMin</td>
    <td class="tg-7fd7">Lower&nbsp;&nbsp;&nbsp;bound on the duty cycle when CMSIncrementalPacing is" enabled (a&nbsp;&nbsp;&nbsp;percentage, 0-100).</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSIncrementalSafetyFactor</td>
    <td class="tg-7fd7">Percentage&nbsp;&nbsp;&nbsp;(0-100) used to add conservatism when computing the" duty cycle.</td>
    <td class="tg-7fd7">10</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSIncrementalOffset</td>
    <td class="tg-7fd7">Percentage&nbsp;&nbsp;&nbsp;(0-100) by which the CMS incremental mode duty cycle" is shifted to the&nbsp;&nbsp;&nbsp;right within the period between young GCs</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSExpAvgFactor</td>
    <td class="tg-7fd7">Percentage&nbsp;&nbsp;&nbsp;(0-100) used to weight the current sample when" computing exponential&nbsp;&nbsp;&nbsp;averages for CMS statistics.</td>
    <td class="tg-7fd7">25</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMS_FLSWeight</td>
    <td class="tg-7fd7">Percentage&nbsp;&nbsp;&nbsp;(0-100) used to weight the current sample when" computing exponentially&nbsp;&nbsp;&nbsp;decating averages for CMS FLS statistics.</td>
    <td class="tg-7fd7">50</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMS_FLSPadding</td>
    <td class="tg-7fd7">The&nbsp;&nbsp;&nbsp;multiple of deviation from mean to use for buffering" against volatility&nbsp;&nbsp;&nbsp;in free list demand.</td>
    <td class="tg-7fd7">2</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">FLSCoalescePolicy</td>
    <td class="tg-7fd7">CMS:&nbsp;&nbsp;&nbsp;Aggression level for coalescing, increasing from 0 to 4</td>
    <td class="tg-7fd7">2</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMS_SweepWeight</td>
    <td class="tg-7fd7">Percentage&nbsp;&nbsp;&nbsp;(0-100) used to weight the current sample when" computing exponentially&nbsp;&nbsp;&nbsp;decaying average for inter-sweep duration.</td>
    <td class="tg-7fd7">50</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMS_SweepPadding</td>
    <td class="tg-7fd7">The&nbsp;&nbsp;&nbsp;multiple of deviation from mean to use for buffering" against volatility&nbsp;&nbsp;&nbsp;in inter-sweep duration.</td>
    <td class="tg-7fd7">2</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMS_SweepTimerThresholdMillis</td>
    <td class="tg-7fd7">Skip&nbsp;&nbsp;&nbsp;block flux-rate sampling for an epoch unless inter-sweep duration exceeds&nbsp;&nbsp;&nbsp;this threhold in milliseconds</td>
    <td class="tg-7fd7">10</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSClassUnloadingEnabled</td>
    <td class="tg-7fd7">Whether&nbsp;&nbsp;&nbsp;class unloading enabled when using CMS GC</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSCompactWhenClearAllSoftRefs</td>
    <td class="tg-7fd7">Compact&nbsp;&nbsp;&nbsp;when asked to collect CMS gen with clear_all_soft_refs</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseCMSCompactAtFullCollection</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;mark sweep compact at full collections</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSFullGCsBeforeCompaction</td>
    <td class="tg-7fd7">Number&nbsp;&nbsp;&nbsp;of CMS full collection done before compaction if &gt; 0</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSIndexedFreeListReplenish</td>
    <td class="tg-7fd7">Replenish&nbsp;&nbsp;&nbsp;and indexed free list with this number of chunks</td>
    <td class="tg-7fd7">4</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSLoopWarn</td>
    <td class="tg-7fd7">Warn&nbsp;&nbsp;&nbsp;in case of excessive CMS looping</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSMarkStackSize</td>
    <td class="tg-7fd7">Size&nbsp;&nbsp;&nbsp;of CMS marking stack</td>
    <td class="tg-7fd7">32*K</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSMarkStackSizeMax</td>
    <td class="tg-7fd7">Max&nbsp;&nbsp;&nbsp;size of CMS marking stack</td>
    <td class="tg-7fd7">4*M</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSMaxAbortablePrecleanLoops</td>
    <td class="tg-7fd7">(Temporary,&nbsp;&nbsp;&nbsp;subject to experimentation)" Maximum number of abortable preclean&nbsp;&nbsp;&nbsp;iterations, if &gt; 0</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSMaxAbortablePrecleanTime</td>
    <td class="tg-7fd7">(Temporary,&nbsp;&nbsp;&nbsp;subject to experimentation)" Maximum time in abortable preclean in ms</td>
    <td class="tg-7fd7">5000</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSAbortablePrecleanMinWorkPerIteration</td>
    <td class="tg-7fd7">(Temporary,&nbsp;&nbsp;&nbsp;subject to experimentation)" Nominal minimum work per abortable preclean&nbsp;&nbsp;&nbsp;iteration</td>
    <td class="tg-7fd7">100</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSAbortablePrecleanWaitMillis</td>
    <td class="tg-7fd7">(Temporary,&nbsp;&nbsp;&nbsp;subject to experimentation)" Time that we sleep between iterations when&nbsp;&nbsp;&nbsp;not given" enough work per iteration</td>
    <td class="tg-7fd7">100</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSRescanMultiple</td>
    <td class="tg-7fd7">Size&nbsp;&nbsp;&nbsp;(in cards) of CMS parallel rescan task</td>
    <td class="tg-7fd7">32</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSConcMarkMultiple</td>
    <td class="tg-7fd7">Size&nbsp;&nbsp;&nbsp;(in cards) of CMS concurrent MT marking task</td>
    <td class="tg-7fd7">32</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSRevisitStackSize</td>
    <td class="tg-7fd7">Size&nbsp;&nbsp;&nbsp;of CMS KlassKlass revisit stack</td>
    <td class="tg-7fd7">1*M</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSAbortSemantics</td>
    <td class="tg-7fd7">Whether&nbsp;&nbsp;&nbsp;abort-on-overflow semantics is implemented</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSParallelRemarkEnabled</td>
    <td class="tg-7fd7">Whether&nbsp;&nbsp;&nbsp;parallel remark enabled (only if ParNewGC)</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSParallelSurvivorRemarkEnabled</td>
    <td class="tg-7fd7">Whether&nbsp;&nbsp;&nbsp;parallel remark of survivor space" enabled (effective only if&nbsp;&nbsp;&nbsp;CMSParallelRemarkEnabled)</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSPLABRecordAlways</td>
    <td class="tg-7fd7">Whether&nbsp;&nbsp;&nbsp;to always record survivor space PLAB bdries" (effective only if&nbsp;&nbsp;&nbsp;CMSParallelSurvivorRemarkEnabled)</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSConcurrentMTEnabled</td>
    <td class="tg-7fd7">Whether&nbsp;&nbsp;&nbsp;multi-threaded concurrent work enabled (if ParNewGC)</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSPermGenPrecleaningEnabled</td>
    <td class="tg-7fd7">Whether&nbsp;&nbsp;&nbsp;concurrent precleaning enabled in perm gen" (effective only when&nbsp;&nbsp;&nbsp;CMSPrecleaningEnabled is true)</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSPermGenSweepingEnabled</td>
    <td class="tg-7fd7">Whether&nbsp;&nbsp;&nbsp;sweeping of perm gen is enabled</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSPrecleaningEnabled</td>
    <td class="tg-7fd7">Whether&nbsp;&nbsp;&nbsp;concurrent precleaning enabled</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSPrecleanIter</td>
    <td class="tg-7fd7">Maximum&nbsp;&nbsp;&nbsp;number of precleaning iteration passes</td>
    <td class="tg-7fd7">3</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSPrecleanNumerator</td>
    <td class="tg-7fd7">CMSPrecleanNumerator:CMSPrecleanDenominator&nbsp;&nbsp;&nbsp;yields convergence" ratio</td>
    <td class="tg-7fd7">2</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSPrecleanDenominator</td>
    <td class="tg-7fd7">CMSPrecleanNumerator:CMSPrecleanDenominator&nbsp;&nbsp;&nbsp;yields convergence" ratio</td>
    <td class="tg-7fd7">3</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSPrecleanRefLists1</td>
    <td class="tg-7fd7">Preclean&nbsp;&nbsp;&nbsp;ref lists during (initial) preclean phase</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSPrecleanRefLists2</td>
    <td class="tg-7fd7">Preclean&nbsp;&nbsp;&nbsp;ref lists during abortable preclean phase</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSPrecleanSurvivors1</td>
    <td class="tg-7fd7">Preclean&nbsp;&nbsp;&nbsp;survivors during (initial) preclean phase</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSPrecleanSurvivors2</td>
    <td class="tg-7fd7">Preclean&nbsp;&nbsp;&nbsp;survivors during abortable preclean phase</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSPrecleanThreshold</td>
    <td class="tg-7fd7">Don't&nbsp;&nbsp;&nbsp;re-iterate if #dirty cards less than this</td>
    <td class="tg-7fd7">1000</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSCleanOnEnter</td>
    <td class="tg-7fd7">Clean-on-enter&nbsp;&nbsp;&nbsp;optimization for reducing number of dirty cards</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSRemarkVerifyVariant</td>
    <td class="tg-7fd7">Choose&nbsp;&nbsp;&nbsp;variant (1,2) of verification following remark</td>
    <td class="tg-7fd7">1</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSScheduleRemarkEdenSizeThreshold</td>
    <td class="tg-7fd7">If&nbsp;&nbsp;&nbsp;Eden used is below this value, don't try to schedule remark</td>
    <td class="tg-7fd7">2*M</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSScheduleRemarkEdenPenetration</td>
    <td class="tg-7fd7">The&nbsp;&nbsp;&nbsp;Eden occupancy % at which to try and schedule remark pause</td>
    <td class="tg-7fd7">50</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSScheduleRemarkSamplingRatio</td>
    <td class="tg-7fd7">Start&nbsp;&nbsp;&nbsp;sampling Eden top at least before yg occupancy reaches" 1/ of the&nbsp;&nbsp;&nbsp;size at which we plan to schedule remark</td>
    <td class="tg-7fd7">5</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSSamplingGrain</td>
    <td class="tg-7fd7">The&nbsp;&nbsp;&nbsp;minimum distance between eden samples for CMS (see above)</td>
    <td class="tg-7fd7">16*K</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSScavengeBeforeRemark</td>
    <td class="tg-7fd7">Attempt&nbsp;&nbsp;&nbsp;scavenge before the CMS remark step</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSWorkQueueDrainThreshold</td>
    <td class="tg-7fd7">Don't&nbsp;&nbsp;&nbsp;drain below this size per parallel worker/thief</td>
    <td class="tg-7fd7">10</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSWaitDuration</td>
    <td class="tg-7fd7">Time&nbsp;&nbsp;&nbsp;in milliseconds that CMS thread waits for young GC</td>
    <td class="tg-7fd7">2000</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSYield</td>
    <td class="tg-7fd7">Yield&nbsp;&nbsp;&nbsp;between steps of concurrent mark &amp; sweep</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSBitMapYieldQuantum</td>
    <td class="tg-7fd7">Bitmap&nbsp;&nbsp;&nbsp;operations should process at most this many bits" between yields</td>
    <td class="tg-7fd7">10*M</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">BlockOffsetArrayUseUnallocatedBlock</td>
    <td class="tg-7fd7">Maintain&nbsp;&nbsp;&nbsp;_unallocated_block in BlockOffsetArray" (currently applicable only to&nbsp;&nbsp;&nbsp;CMS collector)</td>
    <td class="tg-7fd7">trueInDebug</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">RefDiscoveryPolicy</td>
    <td class="tg-7fd7">Whether&nbsp;&nbsp;&nbsp;reference-based(0) or referent-based(1)</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">ParallelRefProcEnabled</td>
    <td class="tg-7fd7">Enable&nbsp;&nbsp;&nbsp;parallel reference processing whenever possible</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSTriggerRatio</td>
    <td class="tg-7fd7">Percentage&nbsp;&nbsp;&nbsp;of MinHeapFreeRatio in CMS generation that is allocated before a CMS&nbsp;&nbsp;&nbsp;collection cycle commences</td>
    <td class="tg-7fd7">80</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSBootstrapOccupancy</td>
    <td class="tg-7fd7">Percentage&nbsp;&nbsp;&nbsp;CMS generation occupancy at which to initiate CMS collection for&nbsp;&nbsp;&nbsp;bootstrapping collection stats</td>
    <td class="tg-7fd7">50</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSInitiatingOccupancyFraction</td>
    <td class="tg-wogo"><a href="http://aragozin.blogspot.com/2011/10/java-cg-hotspots-cms-and-heap.html">Percentage&nbsp;&nbsp;&nbsp;CMS generation occupancy to start a CMS collection cycle (A negative value&nbsp;&nbsp;&nbsp;means that CMSTirggerRatio is used). See good explanation about that&nbsp;&nbsp;&nbsp;parameter here.</a></td>
    <td class="tg-7fd7">-1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseCMSInitiatingOccupancyOnly</td>
    <td class="tg-wogo"><a href="http://aragozin.blogspot.com/2011/10/java-cg-hotspots-cms-and-heap.html">Only&nbsp;&nbsp;&nbsp;use occupancy as a crierion for starting a CMS collection.  See&nbsp;&nbsp;&nbsp;good explanation about that parameter here.</a></td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">HandlePromotionFailure</td>
    <td class="tg-7fd7">The&nbsp;&nbsp;&nbsp;youngest generation collection does not require" a guarantee of full&nbsp;&nbsp;&nbsp;promotion of all live objects.</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PreserveMarkStackSize</td>
    <td class="tg-7fd7">Size&nbsp;&nbsp;&nbsp;for stack used in promotion failure handling</td>
    <td class="tg-7fd7">40</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">ZeroTLAB</td>
    <td class="tg-wogo"><a href="https://stas-blogspot.blogspot.com/2011/07/most-complete-list-of-xx-options-for.html#TLAB">Zero&nbsp;&nbsp;&nbsp;out the newly created TLAB</a></td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintTLAB</td>
    <td class="tg-wogo"><a href="https://stas-blogspot.blogspot.com/2011/07/most-complete-list-of-xx-options-for.html#TLAB">Print&nbsp;&nbsp;&nbsp;various TLAB related information</a></td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TLABStats</td>
    <td class="tg-wogo"><a href="https://stas-blogspot.blogspot.com/2011/07/most-complete-list-of-xx-options-for.html#TLAB">Print&nbsp;&nbsp;&nbsp;various TLAB related information</a></td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">AlwaysActAsServerClassMachine</td>
    <td class="tg-7fd7">Always&nbsp;&nbsp;&nbsp;act like a server-class machine</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">DefaultMaxRAM</td>
    <td class="tg-7fd7">Maximum&nbsp;&nbsp;&nbsp;real memory size for setting server class heap size</td>
    <td class="tg-7fd7">G</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">DefaultMaxRAMFraction</td>
    <td class="tg-7fd7">Fraction&nbsp;&nbsp;&nbsp;(1/n) of real memory used for server class max heap</td>
    <td class="tg-7fd7">4</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">DefaultInitialRAMFraction</td>
    <td class="tg-7fd7">Fraction&nbsp;&nbsp;&nbsp;(1/n) of real memory used for server class initial heap</td>
    <td class="tg-7fd7">64</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseAutoGCSelectPolicy</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;automatic collection selection policy</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">AutoGCSelectPauseMillis</td>
    <td class="tg-7fd7">Automatic&nbsp;&nbsp;&nbsp;GC selection pause threshhold in ms</td>
    <td class="tg-7fd7">5000</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseAdaptiveSizePolicy</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;adaptive generation sizing policies</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UsePSAdaptiveSurvivorSizePolicy</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;adaptive survivor sizing policies</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseAdaptiveGenerationSizePolicyAtMinorCollection</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;adaptive young-old sizing policies at minor collections</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseAdaptiveGenerationSizePolicyAtMajorCollection</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;adaptive young-old sizing policies at major collections</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseAdaptiveSizePolicyWithSystemGC</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;statistics from System.GC for adaptive size policy</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseAdaptiveGCBoundary</td>
    <td class="tg-7fd7">Allow&nbsp;&nbsp;&nbsp;young-old boundary to move</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">AdaptiveSizeThroughPutPolicy</td>
    <td class="tg-7fd7">Policy&nbsp;&nbsp;&nbsp;for changeing generation size for throughput goals</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">AdaptiveSizePausePolicy</td>
    <td class="tg-7fd7">Policy&nbsp;&nbsp;&nbsp;for changing generation size for pause goals</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">AdaptiveSizePolicyInitializingSteps</td>
    <td class="tg-7fd7">Number&nbsp;&nbsp;&nbsp;of steps where heuristics is used before data is used</td>
    <td class="tg-7fd7">20</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">AdaptiveSizePolicyOutputInterval</td>
    <td class="tg-7fd7">Collecton&nbsp;&nbsp;&nbsp;interval for printing information, zero =&gt; never</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseAdaptiveSizePolicyFootprintGoal</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;adaptive minimum footprint as a goal</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">AdaptiveSizePolicyWeight</td>
    <td class="tg-7fd7">Weight&nbsp;&nbsp;&nbsp;given to exponential resizing, between 0 and 100</td>
    <td class="tg-7fd7">10</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">AdaptiveTimeWeight</td>
    <td class="tg-7fd7">Weight&nbsp;&nbsp;&nbsp;given to time in adaptive policy, between 0 and 100</td>
    <td class="tg-7fd7">25</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">PausePadding</td>
    <td class="tg-7fd7">How&nbsp;&nbsp;&nbsp;much buffer to keep for pause time</td>
    <td class="tg-7fd7">1</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">PromotedPadding</td>
    <td class="tg-7fd7">How&nbsp;&nbsp;&nbsp;much buffer to keep for promotion failure</td>
    <td class="tg-7fd7">3</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">SurvivorPadding</td>
    <td class="tg-7fd7">How&nbsp;&nbsp;&nbsp;much buffer to keep for survivor overflow</td>
    <td class="tg-7fd7">3</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">AdaptivePermSizeWeight</td>
    <td class="tg-7fd7">Weight&nbsp;&nbsp;&nbsp;for perm gen exponential resizing, between 0 and 100</td>
    <td class="tg-7fd7">20</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">PermGenPadding</td>
    <td class="tg-7fd7">How&nbsp;&nbsp;&nbsp;much buffer to keep for perm gen sizing</td>
    <td class="tg-7fd7">3</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">ThresholdTolerance</td>
    <td class="tg-7fd7">Allowed&nbsp;&nbsp;&nbsp;collection cost difference between generations</td>
    <td class="tg-7fd7">10</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">AdaptiveSizePolicyCollectionCostMargin</td>
    <td class="tg-7fd7">If&nbsp;&nbsp;&nbsp;collection costs are within margin, reduce both by full delta</td>
    <td class="tg-7fd7">50</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">YoungGenerationSizeIncrement</td>
    <td class="tg-7fd7">Adaptive&nbsp;&nbsp;&nbsp;size percentage change in young generation</td>
    <td class="tg-7fd7">20</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">YoungGenerationSizeSupplement</td>
    <td class="tg-7fd7">Supplement&nbsp;&nbsp;&nbsp;to YoungedGenerationSizeIncrement used at startup</td>
    <td class="tg-7fd7">80</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">YoungGenerationSizeSupplementDecay</td>
    <td class="tg-7fd7">Decay&nbsp;&nbsp;&nbsp;factor to YoungedGenerationSizeSupplement</td>
    <td class="tg-7fd7">8</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">TenuredGenerationSizeIncrement</td>
    <td class="tg-7fd7">Adaptive&nbsp;&nbsp;&nbsp;size percentage change in tenured generation</td>
    <td class="tg-7fd7">20</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">TenuredGenerationSizeSupplement</td>
    <td class="tg-7fd7">Supplement&nbsp;&nbsp;&nbsp;to TenuredGenerationSizeIncrement used at startup</td>
    <td class="tg-7fd7">80</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">TenuredGenerationSizeSupplementDecay</td>
    <td class="tg-7fd7">Decay&nbsp;&nbsp;&nbsp;factor to TenuredGenerationSizeIncrement</td>
    <td class="tg-7fd7">2</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MaxGCPauseMillis</td>
    <td class="tg-7fd7">Adaptive&nbsp;&nbsp;&nbsp;size policy maximum GC pause time goal in msec</td>
    <td class="tg-7fd7">max_uintx</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MaxGCMinorPauseMillis</td>
    <td class="tg-7fd7">Adaptive&nbsp;&nbsp;&nbsp;size policy maximum GC minor pause time goal in msec</td>
    <td class="tg-7fd7">max_uintx</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">GCTimeRatio</td>
    <td class="tg-7fd7">Adaptive&nbsp;&nbsp;&nbsp;size policy application time to GC time ratio</td>
    <td class="tg-7fd7">99</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">AdaptiveSizeDecrementScaleFactor</td>
    <td class="tg-7fd7">Adaptive&nbsp;&nbsp;&nbsp;size scale down factor for shrinking</td>
    <td class="tg-7fd7">4</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseAdaptiveSizeDecayMajorGCCost</td>
    <td class="tg-7fd7">Adaptive&nbsp;&nbsp;&nbsp;size decays the major cost for long major intervals</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">AdaptiveSizeMajorGCDecayTimeScale</td>
    <td class="tg-7fd7">Time&nbsp;&nbsp;&nbsp;scale over which major costs decay</td>
    <td class="tg-7fd7">10</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MinSurvivorRatio</td>
    <td class="tg-7fd7">Minimum&nbsp;&nbsp;&nbsp;ratio of young generation/survivor space size</td>
    <td class="tg-7fd7">3</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">InitialSurvivorRatio</td>
    <td class="tg-7fd7">Initial&nbsp;&nbsp;&nbsp;ratio of eden/survivor space size</td>
    <td class="tg-7fd7">8</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">BaseFootPrintEstimate</td>
    <td class="tg-7fd7">Estimate&nbsp;&nbsp;&nbsp;of footprint other than Java Heap</td>
    <td class="tg-7fd7">256*M</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseGCOverheadLimit</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;policy to limit of proportion of time spent in GC before an OutOfMemory error&nbsp;&nbsp;&nbsp;is thrown</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">GCTimeLimit</td>
    <td class="tg-7fd7">Limit&nbsp;&nbsp;&nbsp;of proportion of time spent in GC before an OutOfMemory" error is thrown&nbsp;&nbsp;&nbsp;(used with GCHeapFreeLimit)</td>
    <td class="tg-7fd7">98</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">GCHeapFreeLimit</td>
    <td class="tg-7fd7">Minimum&nbsp;&nbsp;&nbsp;percentage of free space after a full GC before an OutOfMemoryError is thrown&nbsp;&nbsp;&nbsp;(used with GCTimeLimit)</td>
    <td class="tg-7fd7">2</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintAdaptiveSizePolicy</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;information about AdaptiveSizePolicy</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">DisableExplicitGC</td>
    <td class="tg-7fd7">Tells&nbsp;&nbsp;&nbsp;whether calling System.gc() does a full GC</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CollectGen0First</td>
    <td class="tg-7fd7">Collect&nbsp;&nbsp;&nbsp;youngest generation before each full GC</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">BindGCTaskThreadsToCPUs</td>
    <td class="tg-7fd7">Bind&nbsp;&nbsp;&nbsp;GCTaskThreads to CPUs if possible</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseGCTaskAffinity</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;worker affinity when asking for GCTasks</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ProcessDistributionStride</td>
    <td class="tg-7fd7">Stride&nbsp;&nbsp;&nbsp;through processors when distributing processes</td>
    <td class="tg-7fd7">4</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSCoordinatorYieldSleepCount</td>
    <td class="tg-7fd7">number&nbsp;&nbsp;&nbsp;of times the coordinator GC thread will sleep while yielding before giving up&nbsp;&nbsp;&nbsp;and resuming GC</td>
    <td class="tg-7fd7">10</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSYieldSleepCount</td>
    <td class="tg-7fd7">number&nbsp;&nbsp;&nbsp;of times a GC thread (minus the coordinator) will sleep while yielding before&nbsp;&nbsp;&nbsp;giving up and resuming GC</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintGCTaskTimeStamps</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;timestamps for individual gc worker thread tasks</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceClassLoadingPreorder</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;all classes loaded in order referenced (not loaded)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceGen0Time</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;accumulated time for Gen 0 collection</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceGen1Time</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;accumulated time for Gen 1 collection</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintTenuringDistribution</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;tenuring age information</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintHeapAtSIGBREAK</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;heap layout in response to SIGBREAK</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceParallelOldGCTasks</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;multithreaded GC activity</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintParallelOldGCPhaseTimes</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;the time taken by each parallel old gc phase." PrintGCDetails must also&nbsp;&nbsp;&nbsp;be enabled.</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CITime</td>
    <td class="tg-7fd7">collect&nbsp;&nbsp;&nbsp;timing information for compilation</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">Inline</td>
    <td class="tg-7fd7">enable&nbsp;&nbsp;&nbsp;inlining</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ClipInlining</td>
    <td class="tg-7fd7">clip&nbsp;&nbsp;&nbsp;inlining if aggregate method exceeds DesiredMethodLimit</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseTypeProfile</td>
    <td class="tg-7fd7">Check&nbsp;&nbsp;&nbsp;interpreter profile for historically monomorphic calls</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TypeProfileMinimumRatio</td>
    <td class="tg-7fd7">Minimum&nbsp;&nbsp;&nbsp;ratio of profiled majority type to all minority types</td>
    <td class="tg-7fd7">9</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">Tier1UpdateMethodData</td>
    <td class="tg-7fd7">Update&nbsp;&nbsp;&nbsp;methodDataOops in Tier1-generated code</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintVMOptions</td>
    <td class="tg-7fd7">print&nbsp;&nbsp;&nbsp;VM flag settings</td>
    <td class="tg-7fd7">trueInDebug</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ErrorFile</td>
    <td class="tg-7fd7">If&nbsp;&nbsp;&nbsp;an error occurs, save the error data to this file [default:&nbsp;&nbsp;&nbsp;./hs_err_pid%p.log] (%p replaced with pid)</td>
    <td class="tg-7fd7">""</td>
    <td class="tg-7fd7">ccstr</td>
  </tr>
  <tr>
    <td class="tg-elk0">DisplayVMOutputToStderr</td>
    <td class="tg-7fd7">If&nbsp;&nbsp;&nbsp;DisplayVMOutput is true, display all VM output to stderr</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">DisplayVMOutputToStdout</td>
    <td class="tg-7fd7">If&nbsp;&nbsp;&nbsp;DisplayVMOutput is true, display all VM output to stdout</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseHeavyMonitors</td>
    <td class="tg-7fd7">use&nbsp;&nbsp;&nbsp;heavyweight instead of lightweight Java monitors</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">RangeCheckElimination</td>
    <td class="tg-7fd7">Split&nbsp;&nbsp;&nbsp;loop iterations to eliminate range checks</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">SplitIfBlocks</td>
    <td class="tg-7fd7">Clone&nbsp;&nbsp;&nbsp;compares and control flow through merge points to fold some branches</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">AggressiveOpts</td>
    <td class="tg-7fd7">Enable&nbsp;&nbsp;&nbsp;aggressive optimizations - see arguments.cpp</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintInterpreter</td>
    <td class="tg-7fd7">Prints&nbsp;&nbsp;&nbsp;the generated interpreter code</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseInterpreter</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;interpreter for non-compiled methods</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseNiagaraInstrs</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;Niagara-efficient instruction subset</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseLoopCounter</td>
    <td class="tg-7fd7">Increment&nbsp;&nbsp;&nbsp;invocation counter on backward branch</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseFastEmptyMethods</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;fast method entry code for empty methods</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseFastAccessorMethods</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;fast method entry code for accessor methods</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">EnableJVMPIInstructionStartEvent</td>
    <td class="tg-7fd7">Enable&nbsp;&nbsp;&nbsp;JVMPI_EVENT_INSTRUCTION_START events - slows down interpretation</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">JVMPICheckGCCompatibility</td>
    <td class="tg-7fd7">If&nbsp;&nbsp;&nbsp;JVMPI is used, make sure that we are using a JVMPI-compatible garbage&nbsp;&nbsp;&nbsp;collector</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ProfileMaturityPercentage</td>
    <td class="tg-7fd7">number&nbsp;&nbsp;&nbsp;of method invocations/branches (expressed as % of CompileThreshold) before&nbsp;&nbsp;&nbsp;using the method's profile</td>
    <td class="tg-7fd7">20</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseCompiler</td>
    <td class="tg-7fd7">use&nbsp;&nbsp;&nbsp;compilation</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseCounterDecay</td>
    <td class="tg-7fd7">adjust&nbsp;&nbsp;&nbsp;recompilation counters</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">AlwaysCompileLoopMethods</td>
    <td class="tg-7fd7">when&nbsp;&nbsp;&nbsp;using recompilation, never interpret methods containing loops</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">DontCompileHugeMethods</td>
    <td class="tg-7fd7">don't&nbsp;&nbsp;&nbsp;compile methods &gt; HugeMethodLimit</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">EstimateArgEscape</td>
    <td class="tg-7fd7">Analyze&nbsp;&nbsp;&nbsp;bytecodes to estimate escape state of arguments</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">BCEATraceLevel</td>
    <td class="tg-7fd7">How&nbsp;&nbsp;&nbsp;much tracing to do of bytecode escape analysis estimates</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MaxBCEAEstimateLevel</td>
    <td class="tg-7fd7">Maximum&nbsp;&nbsp;&nbsp;number of nested calls that are analyzed by BC EA.</td>
    <td class="tg-7fd7">5</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MaxBCEAEstimateSize</td>
    <td class="tg-7fd7">Maximum&nbsp;&nbsp;&nbsp;bytecode size of a method to be analyzed by BC EA.</td>
    <td class="tg-7fd7">150</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">SelfDestructTimer</td>
    <td class="tg-7fd7">Will&nbsp;&nbsp;&nbsp;cause VM to terminate after a given time (in minutes) (0 means off)</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0" rowspan="3">MaxJavaStackTraceDepth</td>
    <td class="tg-7fd7">Max.&nbsp;&nbsp;&nbsp;no. of lines in the stack trace for Java exceptions (0 means all).</td>
    <td class="tg-7fd7" rowspan="3">1024</td>
    <td class="tg-7fd7" rowspan="3">intx</td>
  </tr>
  <tr>
    <td class="tg-7fd7">With Java &gt; 1.6, value 0 really means 0. value -1 or any&nbsp;&nbsp;&nbsp;negative number must be specified to print all the stack (tested with&nbsp;&nbsp;&nbsp;1.6.0_22, 1.7.0 on Windows).</td>
  </tr>
  <tr>
    <td class="tg-7fd7">With Java &lt;= 1.5, value 0 means everything, JVM chokes on&nbsp;&nbsp;&nbsp;negative number (tested with 1.5.0_22 on Windows).</td>
  </tr>
  <tr>
    <td class="tg-elk0">NmethodSweepFraction</td>
    <td class="tg-7fd7">Number&nbsp;&nbsp;&nbsp;of invocations of sweeper to cover all nmethods</td>
    <td class="tg-7fd7">4</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MaxInlineSize</td>
    <td class="tg-7fd7">maximum&nbsp;&nbsp;&nbsp;bytecode size of a method to be inlined</td>
    <td class="tg-7fd7">35</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">ProfileIntervalsTicks</td>
    <td class="tg-7fd7">#&nbsp;&nbsp;&nbsp;of ticks between printing of interval profile (+ProfileIntervals)</td>
    <td class="tg-7fd7">100</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">EventLogLength</td>
    <td class="tg-7fd7">maximum&nbsp;&nbsp;&nbsp;nof events in event log</td>
    <td class="tg-7fd7">2000</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">PerMethodRecompilationCutoff</td>
    <td class="tg-7fd7">After&nbsp;&nbsp;&nbsp;recompiling N times, stay in the interpreter (-1=&gt;'Inf')</td>
    <td class="tg-7fd7">400</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">PerBytecodeRecompilationCutoff</td>
    <td class="tg-7fd7">Per-BCI&nbsp;&nbsp;&nbsp;limit on repeated recompilation (-1=&gt;'Inf')</td>
    <td class="tg-7fd7">100</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">PerMethodTrapLimit</td>
    <td class="tg-7fd7">Limit&nbsp;&nbsp;&nbsp;on traps (of one kind) in a method (includes inlines)</td>
    <td class="tg-7fd7">100</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">PerBytecodeTrapLimit</td>
    <td class="tg-7fd7">Limit&nbsp;&nbsp;&nbsp;on traps (of one kind) at a particular BCI</td>
    <td class="tg-7fd7">4</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">AliasLevel</td>
    <td class="tg-7fd7">0&nbsp;&nbsp;&nbsp;for no aliasing, 1 for oop/field/static/array split, 2 for best</td>
    <td class="tg-7fd7">2</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">ReadSpinIterations</td>
    <td class="tg-7fd7">Number&nbsp;&nbsp;&nbsp;of read attempts before a yield (spin inner loop)</td>
    <td class="tg-7fd7">100</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">PreBlockSpin</td>
    <td class="tg-7fd7">Number&nbsp;&nbsp;&nbsp;of times to spin in an inflated lock before going to an OS lock</td>
    <td class="tg-7fd7">10</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MaxHeapSize</td>
    <td class="tg-7fd7">Default&nbsp;&nbsp;&nbsp;maximum size for object heap (in bytes)</td>
    <td class="tg-7fd7">ScaleForWordSize&nbsp;&nbsp;&nbsp;(64*M)</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MaxNewSize</td>
    <td class="tg-7fd7">Maximum&nbsp;&nbsp;&nbsp;size of new generation (in bytes)</td>
    <td class="tg-7fd7">max_uintx</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">PretenureSizeThreshold</td>
    <td class="tg-7fd7">Max&nbsp;&nbsp;&nbsp;size in bytes of objects allocated in DefNew generation</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MinTLABSize</td>
    <td class="tg-7fd7">Minimum&nbsp;&nbsp;&nbsp;allowed TLAB size (in bytes)</td>
    <td class="tg-7fd7">2*K</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">TLABAllocationWeight</td>
    <td class="tg-7fd7">Allocation&nbsp;&nbsp;&nbsp;averaging weight</td>
    <td class="tg-7fd7">35</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">TLABWasteTargetPercent</td>
    <td class="tg-7fd7">Percentage&nbsp;&nbsp;&nbsp;of Eden that can be wasted</td>
    <td class="tg-7fd7">1</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">TLABRefillWasteFraction</td>
    <td class="tg-7fd7">Max&nbsp;&nbsp;&nbsp;TLAB waste at a refill (internal fragmentation)</td>
    <td class="tg-7fd7">64</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">TLABWasteIncrement</td>
    <td class="tg-7fd7">Increment&nbsp;&nbsp;&nbsp;allowed waste at slow allocation</td>
    <td class="tg-7fd7">4</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MaxLiveObjectEvacuationRatio</td>
    <td class="tg-7fd7">Max&nbsp;&nbsp;&nbsp;percent of eden objects that will be live at scavenge</td>
    <td class="tg-7fd7">100</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">OldSize</td>
    <td class="tg-7fd7">Default&nbsp;&nbsp;&nbsp;size of tenured generation (in bytes)</td>
    <td class="tg-7fd7">ScaleForWordSize&nbsp;&nbsp;&nbsp;(4096*K)</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MinHeapFreeRatio</td>
    <td class="tg-7fd7">Min&nbsp;&nbsp;&nbsp;percentage of heap free after GC to avoid expansion</td>
    <td class="tg-7fd7">40</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MaxHeapFreeRatio</td>
    <td class="tg-7fd7">Max&nbsp;&nbsp;&nbsp;percentage of heap free after GC to avoid shrinking</td>
    <td class="tg-7fd7">70</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">SoftRefLRUPolicyMSPerMB</td>
    <td class="tg-7fd7">Number&nbsp;&nbsp;&nbsp;of milliseconds per MB of free space in the heap</td>
    <td class="tg-7fd7">1000</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MinHeapDeltaBytes</td>
    <td class="tg-7fd7">Min&nbsp;&nbsp;&nbsp;change in heap space due to GC (in bytes)</td>
    <td class="tg-7fd7">ScaleForWordSize&nbsp;&nbsp;&nbsp;(128*K)</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MinPermHeapExpansion</td>
    <td class="tg-7fd7">Min&nbsp;&nbsp;&nbsp;expansion of permanent heap (in bytes)</td>
    <td class="tg-7fd7">ScaleForWordSize&nbsp;&nbsp;&nbsp;(256*K)</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MaxPermHeapExpansion</td>
    <td class="tg-7fd7">Max&nbsp;&nbsp;&nbsp;expansion of permanent heap without full GC (in bytes)</td>
    <td class="tg-7fd7">ScaleForWordSize&nbsp;&nbsp;&nbsp;(4*M)</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">QueuedAllocationWarningCount</td>
    <td class="tg-7fd7">Number&nbsp;&nbsp;&nbsp;of times an allocation that queues behind a GC will retry before printing a&nbsp;&nbsp;&nbsp;warning</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MaxTenuringThreshold</td>
    <td class="tg-wogo"><a href="http://cybergav.in/2009/12/12/the-maxtenuringthreshold-for-a-hotspot-jvm/">Maximum&nbsp;&nbsp;&nbsp;value for tenuring threshold. See more info about that flag here.</a></td>
    <td class="tg-7fd7">15</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">InitialTenuringThreshold</td>
    <td class="tg-7fd7">Initial&nbsp;&nbsp;&nbsp;value for tenuring threshold</td>
    <td class="tg-7fd7">7</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">TargetSurvivorRatio</td>
    <td class="tg-7fd7">Desired&nbsp;&nbsp;&nbsp;percentage of survivor space used after scavenge</td>
    <td class="tg-7fd7">50</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MarkSweepDeadRatio</td>
    <td class="tg-7fd7">Percentage&nbsp;&nbsp;&nbsp;(0-100) of the old gen allowed as dead wood. "Serial mark sweep treats&nbsp;&nbsp;&nbsp;this as both the min and max value." CMS uses this value only if it&nbsp;&nbsp;&nbsp;falls back to mark sweep." Par compact uses a variable scale based on&nbsp;&nbsp;&nbsp;the density of the" generation and treats this as the max value when the&nbsp;&nbsp;&nbsp;heap is" either completely full or completely empty. Par compact&nbsp;&nbsp;&nbsp;also" has a smaller default value; see arguments.cpp.</td>
    <td class="tg-7fd7">5</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">PermMarkSweepDeadRatio</td>
    <td class="tg-7fd7">Percentage&nbsp;&nbsp;&nbsp;(0-100) of the perm gen allowed as dead wood." See MarkSweepDeadRatio&nbsp;&nbsp;&nbsp;for collector-specific comments.</td>
    <td class="tg-7fd7">20</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MarkSweepAlwaysCompactCount</td>
    <td class="tg-7fd7">How&nbsp;&nbsp;&nbsp;often should we fully compact the heap (ignoring the dead space parameters)</td>
    <td class="tg-7fd7">4</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintCMSStatistics</td>
    <td class="tg-7fd7">Statistics&nbsp;&nbsp;&nbsp;for CMS</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintCMSInitiationStatistics</td>
    <td class="tg-7fd7">Statistics&nbsp;&nbsp;&nbsp;for initiating a CMS collection</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintFLSStatistics</td>
    <td class="tg-7fd7">Statistics&nbsp;&nbsp;&nbsp;for CMS' FreeListSpace</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintFLSCensus</td>
    <td class="tg-7fd7">Census&nbsp;&nbsp;&nbsp;for CMS' FreeListSpace</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">DeferThrSuspendLoopCount</td>
    <td class="tg-7fd7">(Unstable)&nbsp;&nbsp;&nbsp;Number of times to iterate in safepoint loop before blocking VM threads</td>
    <td class="tg-7fd7">4000</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">DeferPollingPageLoopCount</td>
    <td class="tg-7fd7">(Unsafe,Unstable)&nbsp;&nbsp;&nbsp;Number of iterations in safepoint loop before changing safepoint polling page&nbsp;&nbsp;&nbsp;to RO</td>
    <td class="tg-7fd7">-1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">SafepointSpinBeforeYield</td>
    <td class="tg-7fd7">(Unstable)</td>
    <td class="tg-7fd7">2000</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseDepthFirstScavengeOrder</td>
    <td class="tg-7fd7">true:&nbsp;&nbsp;&nbsp;the scavenge order will be depth-first, false: the scavenge order will be&nbsp;&nbsp;&nbsp;breadth-first</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">GCDrainStackTargetSize</td>
    <td class="tg-7fd7">how&nbsp;&nbsp;&nbsp;many entries we'll try to leave on the stack during parallel GC</td>
    <td class="tg-7fd7">64</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">ThreadSafetyMargin</td>
    <td class="tg-7fd7">Thread&nbsp;&nbsp;&nbsp;safety margin is used on fixed-stack LinuxThreads (on Linux/x86 only) to&nbsp;&nbsp;&nbsp;prevent heap-stack collision. Set to 0 to disable this feature</td>
    <td class="tg-7fd7">50*M</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CodeCacheMinimumFreeSpace</td>
    <td class="tg-7fd7">When&nbsp;&nbsp;&nbsp;less than X space left, we stop compiling.</td>
    <td class="tg-7fd7">500*K</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CompileOnly</td>
    <td class="tg-7fd7">List&nbsp;&nbsp;&nbsp;of methods (pkg/class.name) to restrict compilation to</td>
    <td class="tg-7fd7">""</td>
    <td class="tg-7fd7">ccstr</td>
  </tr>
  <tr>
    <td class="tg-elk0">CompileCommandFile</td>
    <td class="tg-7fd7">Read&nbsp;&nbsp;&nbsp;compiler commands from this file [.hotspot_compiler]</td>
    <td class="tg-7fd7">""</td>
    <td class="tg-7fd7">ccstr</td>
  </tr>
  <tr>
    <td class="tg-elk0">CompileCommand</td>
    <td class="tg-7fd7">Prepend&nbsp;&nbsp;&nbsp;to .hotspot_compiler; e.g. log,java/lang/String.</td>
    <td class="tg-7fd7">""</td>
    <td class="tg-7fd7">ccstr</td>
  </tr>
  <tr>
    <td class="tg-elk0">CICompilerCountPerCPU</td>
    <td class="tg-7fd7">1&nbsp;&nbsp;&nbsp;compiler thread for log(N CPUs)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseThreadPriorities</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;native thread priorities</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ThreadPriorityPolicy</td>
    <td class="tg-7fd7">0&nbsp;&nbsp;&nbsp;: Normal. VM chooses priorities that are appropriate for normal applications.&nbsp;&nbsp;&nbsp;On Solaris NORM_PRIORITY and above are mapped to normal native priority. Java&nbsp;&nbsp;&nbsp;priorities below NORM_PRIORITY" map to lower native priority values. On&nbsp;&nbsp;&nbsp;Windows applications" are allowed to use higher native priorities.&nbsp;&nbsp;&nbsp;However, with ThreadPriorityPolicy=0, VM will not use the highest&nbsp;&nbsp;&nbsp;possible" native priority, THREAD_PRIORITY_TIME_CRITICAL, as it may&nbsp;&nbsp;&nbsp;interfere with system threads. On Linux thread priorities are ignored because&nbsp;&nbsp;&nbsp;the OS does not support static priority in SCHED_OTHER scheduling class which&nbsp;&nbsp;&nbsp;is the only choice for" non-root, non-realtime applications. 1 :&nbsp;&nbsp;&nbsp;Aggressive. Java thread priorities map over to the entire range of native&nbsp;&nbsp;&nbsp;thread priorities. Higher Java thread priorities map to higher native thread&nbsp;&nbsp;&nbsp;priorities. This policy should be used with care, as sometimes it can cause&nbsp;&nbsp;&nbsp;performance degradation in the application and/or the entire system. On Linux&nbsp;&nbsp;&nbsp;this policy requires root privilege.</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">ThreadPriorityVerbose</td>
    <td class="tg-7fd7">print&nbsp;&nbsp;&nbsp;priority changes</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">DefaultThreadPriority</td>
    <td class="tg-7fd7">what&nbsp;&nbsp;&nbsp;native priority threads run at if not specified elsewhere (-1 means no&nbsp;&nbsp;&nbsp;change)</td>
    <td class="tg-7fd7">-1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CompilerThreadPriority</td>
    <td class="tg-7fd7">what&nbsp;&nbsp;&nbsp;priority should compiler threads run at (-1 means no change)</td>
    <td class="tg-7fd7">-1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">VMThreadPriority</td>
    <td class="tg-7fd7">what&nbsp;&nbsp;&nbsp;priority should VM threads run at (-1 means no change)</td>
    <td class="tg-7fd7">-1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CompilerThreadHintNoPreempt</td>
    <td class="tg-7fd7">(Solaris&nbsp;&nbsp;&nbsp;only) Give compiler threads an extra quanta</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">VMThreadHintNoPreempt</td>
    <td class="tg-7fd7">(Solaris&nbsp;&nbsp;&nbsp;only) Give VM thread an extra quanta</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">JavaPriority1_To_OSPriority</td>
    <td class="tg-7fd7">Map&nbsp;&nbsp;&nbsp;Java priorities to OS priorities</td>
    <td class="tg-7fd7">-1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">JavaPriority2_To_OSPriority</td>
    <td class="tg-7fd7">Map&nbsp;&nbsp;&nbsp;Java priorities to OS priorities</td>
    <td class="tg-7fd7">-1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">JavaPriority3_To_OSPriority</td>
    <td class="tg-7fd7">Map&nbsp;&nbsp;&nbsp;Java priorities to OS priorities</td>
    <td class="tg-7fd7">-1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">JavaPriority4_To_OSPriority</td>
    <td class="tg-7fd7">Map&nbsp;&nbsp;&nbsp;Java priorities to OS priorities</td>
    <td class="tg-7fd7">-1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">JavaPriority5_To_OSPriority</td>
    <td class="tg-7fd7">Map&nbsp;&nbsp;&nbsp;Java priorities to OS priorities</td>
    <td class="tg-7fd7">-1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">JavaPriority6_To_OSPriority</td>
    <td class="tg-7fd7">Map&nbsp;&nbsp;&nbsp;Java priorities to OS priorities</td>
    <td class="tg-7fd7">-1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">JavaPriority7_To_OSPriority</td>
    <td class="tg-7fd7">Map&nbsp;&nbsp;&nbsp;Java priorities to OS priorities</td>
    <td class="tg-7fd7">-1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">JavaPriority8_To_OSPriority</td>
    <td class="tg-7fd7">Map&nbsp;&nbsp;&nbsp;Java priorities to OS priorities</td>
    <td class="tg-7fd7">-1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">JavaPriority9_To_OSPriority</td>
    <td class="tg-7fd7">Map&nbsp;&nbsp;&nbsp;Java priorities to OS priorities</td>
    <td class="tg-7fd7">-1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">JavaPriority10_To_OSPriority</td>
    <td class="tg-7fd7">Map&nbsp;&nbsp;&nbsp;Java priorities to OS priorities</td>
    <td class="tg-7fd7">-1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">StarvationMonitorInterval</td>
    <td class="tg-7fd7">Pause&nbsp;&nbsp;&nbsp;between each check in ms</td>
    <td class="tg-7fd7">200</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">Tier1BytecodeLimit</td>
    <td class="tg-7fd7">Must&nbsp;&nbsp;&nbsp;have at least this many bytecodes before tier1" invocation counters are&nbsp;&nbsp;&nbsp;used</td>
    <td class="tg-7fd7">10</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">StressTieredRuntime</td>
    <td class="tg-7fd7">Alternate&nbsp;&nbsp;&nbsp;client and server compiler on compile requests</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">InterpreterProfilePercentage</td>
    <td class="tg-7fd7">number&nbsp;&nbsp;&nbsp;of method invocations/branches (expressed as % of CompileThreshold) before&nbsp;&nbsp;&nbsp;profiling in the interpreter</td>
    <td class="tg-7fd7">33</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MaxDirectMemorySize</td>
    <td class="tg-7fd7">Maximum&nbsp;&nbsp;&nbsp;total size of NIO direct-buffer allocations</td>
    <td class="tg-7fd7">-1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseUnsupportedDeprecatedJVMPI</td>
    <td class="tg-7fd7">Flag&nbsp;&nbsp;&nbsp;to temporarily re-enable the, soon to be removed, experimental interface&nbsp;&nbsp;&nbsp;JVMPI.</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UsePerfData</td>
    <td class="tg-7fd7">Flag&nbsp;&nbsp;&nbsp;to disable jvmstat instrumentation for performance testing" and problem&nbsp;&nbsp;&nbsp;isolation purposes.</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PerfDataSaveToFile</td>
    <td class="tg-7fd7">Save&nbsp;&nbsp;&nbsp;PerfData memory to hsperfdata_ file on exit</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PerfDataSamplingInterval</td>
    <td class="tg-7fd7">Data&nbsp;&nbsp;&nbsp;sampling interval in milliseconds</td>
    <td class="tg-7fd7">50&nbsp;&nbsp;&nbsp;/*ms*/</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">PerfDisableSharedMem</td>
    <td class="tg-7fd7">Store&nbsp;&nbsp;&nbsp;performance data in standard memory</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PerfDataMemorySize</td>
    <td class="tg-7fd7">Size&nbsp;&nbsp;&nbsp;of performance data memory region. Will be rounded up to a multiple of the&nbsp;&nbsp;&nbsp;native os page size.</td>
    <td class="tg-7fd7">32*K</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">PerfMaxStringConstLength</td>
    <td class="tg-7fd7">Maximum&nbsp;&nbsp;&nbsp;PerfStringConstant string length before truncation</td>
    <td class="tg-7fd7">1024</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">PerfAllowAtExitRegistration</td>
    <td class="tg-7fd7">Allow&nbsp;&nbsp;&nbsp;registration of atexit() methods</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PerfBypassFileSystemCheck</td>
    <td class="tg-7fd7">Bypass&nbsp;&nbsp;&nbsp;Win32 file system criteria checks (Windows Only)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UnguardOnExecutionViolation</td>
    <td class="tg-7fd7">Unguard&nbsp;&nbsp;&nbsp;page and retry on no-execute fault (Win32 only)" 0=off, 1=conservative,&nbsp;&nbsp;&nbsp;2=aggressive</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">ManagementServer</td>
    <td class="tg-7fd7">Create&nbsp;&nbsp;&nbsp;JMX Management Server</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">DisableAttachMechanism</td>
    <td class="tg-7fd7">Disable&nbsp;&nbsp;&nbsp;mechanism that allows tools to attach to this VM</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">StartAttachListener</td>
    <td class="tg-7fd7">Always&nbsp;&nbsp;&nbsp;start Attach Listener at VM startup</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseSharedSpaces</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;shared spaces in the permanent generation</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">RequireSharedSpaces</td>
    <td class="tg-7fd7">Require&nbsp;&nbsp;&nbsp;shared spaces in the permanent generation</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ForceSharedSpaces</td>
    <td class="tg-7fd7">Require&nbsp;&nbsp;&nbsp;shared spaces in the permanent generation</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">DumpSharedSpaces</td>
    <td class="tg-7fd7">Special&nbsp;&nbsp;&nbsp;mode: JVM reads a class list, loads classes, builds shared spaces, and dumps&nbsp;&nbsp;&nbsp;the shared spaces to a file to be used in future JVM runs.</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintSharedSpaces</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;usage of shared spaces</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">SharedDummyBlockSize</td>
    <td class="tg-7fd7">Size&nbsp;&nbsp;&nbsp;of dummy block used to shift heap addresses (in bytes)</td>
    <td class="tg-7fd7">512*M</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">SharedReadWriteSize</td>
    <td class="tg-7fd7">Size&nbsp;&nbsp;&nbsp;of read-write space in permanent generation (in bytes)</td>
    <td class="tg-7fd7">12*M</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">SharedReadOnlySize</td>
    <td class="tg-7fd7">Size&nbsp;&nbsp;&nbsp;of read-only space in permanent generation (in bytes)</td>
    <td class="tg-7fd7">8*M</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">SharedMiscDataSize</td>
    <td class="tg-7fd7">Size&nbsp;&nbsp;&nbsp;of the shared data area adjacent to the heap (in bytes)</td>
    <td class="tg-7fd7">4*M</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">SharedMiscCodeSize</td>
    <td class="tg-7fd7">Size&nbsp;&nbsp;&nbsp;of the shared code area adjacent to the heap (in bytes)</td>
    <td class="tg-7fd7">4*M</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">TaggedStackInterpreter</td>
    <td class="tg-7fd7">Insert&nbsp;&nbsp;&nbsp;tags in interpreter execution stack for oopmap generaion</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ExtendedDTraceProbes</td>
    <td class="tg-7fd7">Enable&nbsp;&nbsp;&nbsp;performance-impacting dtrace probes</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">DTraceMethodProbes</td>
    <td class="tg-7fd7">Enable&nbsp;&nbsp;&nbsp;dtrace probes for method-entry and method-exit</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">DTraceAllocProbes</td>
    <td class="tg-7fd7">Enable&nbsp;&nbsp;&nbsp;dtrace probes for object allocation</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">DTraceMonitorProbes</td>
    <td class="tg-7fd7">Enable&nbsp;&nbsp;&nbsp;dtrace probes for monitor events</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">RelaxAccessControlCheck</td>
    <td class="tg-7fd7">Relax&nbsp;&nbsp;&nbsp;the access control checks in the verifier</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseVMInterruptibleIO</td>
    <td class="tg-7fd7">(Unstable,&nbsp;&nbsp;&nbsp;Solaris-specific) Thread interrupt before or with EINTR for I/O operations&nbsp;&nbsp;&nbsp;results in OS_INTRPT</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">AggressiveHeap</td>
    <td class="tg-7fd7">The&nbsp;&nbsp;&nbsp;option inspects the server resources (size of memory and number of&nbsp;&nbsp;&nbsp;processors), and attempts to set various parameters to be optimal for&nbsp;&nbsp;&nbsp;long-running, memory allocation-intensive jobs. The JVM team view&nbsp;&nbsp;&nbsp;AggressiveHeap as an anachronism and would like to see it go away. Instead,&nbsp;&nbsp;&nbsp;we'd prefer for you to determine which of the individual options that&nbsp;&nbsp;&nbsp;AggressiveHeap sets actually impact your app, and then set those on the&nbsp;&nbsp;&nbsp;command line directly. You can check the Open JDK source code to see what&nbsp;&nbsp;&nbsp;AggressiveHeap actually does (arguments.cpp)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseCompressedStrings</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;a byte[] for Strings which can be represented as pure ASCII. (Introduced in&nbsp;&nbsp;&nbsp;Java 6 Update 21 Performance Release)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">OptimizeStringConcat</td>
    <td class="tg-7fd7">Optimize&nbsp;&nbsp;&nbsp;String concatenation operations where possible. (Introduced in Java 6 Update&nbsp;&nbsp;&nbsp;20)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseStringCache</td>
    <td class="tg-7fd7">Enables&nbsp;&nbsp;&nbsp;caching of commonly allocated strings.</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">G1HeapRegionSize</td>
    <td class="tg-7fd7">With&nbsp;&nbsp;&nbsp;G1 the Java heap is subdivided into uniformly sized regions. This sets the&nbsp;&nbsp;&nbsp;size of the individual sub-divisions. The default value of this parameter is&nbsp;&nbsp;&nbsp;determined ergonomically based upon heap size. The minimum value is 1Mb and&nbsp;&nbsp;&nbsp;the maximum value is 32Mb. Introduced in Java 6 Update 26.</td>
    <td class="tg-7fd7">8m</td>
    <td class="tg-7fd7">　</td>
  </tr>
  <tr>
    <td class="tg-elk0">G1ReservePercent</td>
    <td class="tg-7fd7">Sets&nbsp;&nbsp;&nbsp;the amount of heap that is reserved as a false ceiling to reduce the&nbsp;&nbsp;&nbsp;possibility of promotion failure. Introduced in Java 6 Update 26.</td>
    <td class="tg-7fd7">10</td>
    <td class="tg-7fd7">　</td>
  </tr>
  <tr>
    <td class="tg-elk0">G1ConfidencePercent</td>
    <td class="tg-7fd7">Confidence&nbsp;&nbsp;&nbsp;coefficient for G1 pause prediction. Introduced in Java 6 Update 26.</td>
    <td class="tg-7fd7">50</td>
    <td class="tg-7fd7">　</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintPromotionFailure</td>
    <td class="tg-7fd7">Prints&nbsp;&nbsp;&nbsp;additional information on GC promotion failures.</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-vp9j" colspan="4"><a href="https://stas-blogspot.blogspot.com/2011/07/most-complete-list-of-xx-options-for.html">manageable</a></td>
  </tr>
  <tr>
    <td class="tg-elk0">HeapDumpOnOutOfMemoryError</td>
    <td class="tg-7fd7">Dump&nbsp;&nbsp;&nbsp;heap to file when java.lang.OutOfMemoryError is thrown</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">HeapDumpPath</td>
    <td class="tg-7fd7">When&nbsp;&nbsp;&nbsp;HeapDumpOnOutOfMemoryError is on, the path (filename or" directory) of&nbsp;&nbsp;&nbsp;the dump file (defaults to java_pid.hprof" in the working directory)</td>
    <td class="tg-7fd7">""</td>
    <td class="tg-7fd7">ccstr</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintGC</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;message at garbage collect</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintGCDetails</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;more details at garbage collect</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintGCTimeStamps</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;timestamps at garbage collect</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintGCDateStamps</td>
    <td class="tg-wogo"><a href="http://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations">Print&nbsp;&nbsp;&nbsp;datestamps (ISO_8601, e.g. 2013-10-18T12:32:01.657+0100)&nbsp;&nbsp;&nbsp;at garbage collect. Since Java 1.6.u4.</a></td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintClassHistogram</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;a histogram of class instances</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintConcurrentLocks</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;java.util.concurrent locks in thread dump</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-vp9j" colspan="4"><a href="https://stas-blogspot.blogspot.com/2011/07/most-complete-list-of-xx-options-for.html">experimental</a></td>
  </tr>
  <tr>
    <td class="tg-elk0">UnlockExperimentalVMOptions</td>
    <td class="tg-7fd7">Unlocks&nbsp;&nbsp;&nbsp;experimental options.</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseG1GC</td>
    <td class="tg-7fd7">Switch&nbsp;&nbsp;&nbsp;on G1 for Java6. G1 is default for Java7, so there is no such option there.</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-vp9j" colspan="4"><a href="https://stas-blogspot.blogspot.com/2011/07/most-complete-list-of-xx-options-for.html">product_rw</a></td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceClassLoading</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;all classes loaded</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceClassUnloading</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;unloading of classes</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceLoaderConstraints</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;loader constraints</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintHeapAtGC</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;heap layout before and after each GC</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-vp9j" colspan="4"><a href="https://stas-blogspot.blogspot.com/2011/07/most-complete-list-of-xx-options-for.html">develop</a></td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceItables</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;initialization and use of itables</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TracePcPatching</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;usage of frame::patch_pc</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceJumps</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;assembly jumps in thread ring buffer</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceRelocator</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;the bytecode relocator</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceLongCompiles</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;out every time compilation is longer than a given threashold</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">SafepointALot</td>
    <td class="tg-7fd7">Generates&nbsp;&nbsp;&nbsp;a lot of safepoints. Works with GuaranteedSafepointInterval</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">BailoutToInterpreterForThrows</td>
    <td class="tg-7fd7">Compiled&nbsp;&nbsp;&nbsp;methods which throws/catches exceptions will be deopt and intp.</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">NoYieldsInMicrolock</td>
    <td class="tg-7fd7">Disable&nbsp;&nbsp;&nbsp;yields in microlock</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceOopMapGeneration</td>
    <td class="tg-7fd7">Shows&nbsp;&nbsp;&nbsp;oopmap generation</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">MethodFlushing</td>
    <td class="tg-7fd7">Reclamation&nbsp;&nbsp;&nbsp;of zombie and not-entrant methods</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyStack</td>
    <td class="tg-7fd7">Verify&nbsp;&nbsp;&nbsp;stack of each thread when it is entering a runtime call</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceDerivedPointers</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;traversal of derived pointers on stack</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">InlineArrayCopy</td>
    <td class="tg-7fd7">inline&nbsp;&nbsp;&nbsp;arraycopy native that is known to be part of base library DLL</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">InlineObjectHash</td>
    <td class="tg-7fd7">inline&nbsp;&nbsp;&nbsp;Object::hashCode() native that is known to be part of base library DLL</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">InlineNatives</td>
    <td class="tg-7fd7">inline&nbsp;&nbsp;&nbsp;natives that are known to be part of base library DLL</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">InlineMathNatives</td>
    <td class="tg-7fd7">inline&nbsp;&nbsp;&nbsp;SinD, CosD, etc.</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">InlineClassNatives</td>
    <td class="tg-7fd7">inline&nbsp;&nbsp;&nbsp;Class.isInstance, etc</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">InlineAtomicLong</td>
    <td class="tg-7fd7">inline&nbsp;&nbsp;&nbsp;sun.misc.AtomicLong</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">InlineThreadNatives</td>
    <td class="tg-7fd7">inline&nbsp;&nbsp;&nbsp;Thread.currentThread, etc</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">InlineReflectionGetCallerClass</td>
    <td class="tg-7fd7">inline&nbsp;&nbsp;&nbsp;sun.reflect.Reflection.getCallerClass(), known to be part of base library DLL</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">InlineUnsafeOps</td>
    <td class="tg-7fd7">inline&nbsp;&nbsp;&nbsp;memory ops (native methods) from sun.misc.Unsafe</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ConvertCmpD2CmpF</td>
    <td class="tg-7fd7">Convert&nbsp;&nbsp;&nbsp;cmpD to cmpF when one input is constant in float range</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ConvertFloat2IntClipping</td>
    <td class="tg-7fd7">Convert&nbsp;&nbsp;&nbsp;float2int clipping idiom to integer clipping</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">SpecialStringCompareTo</td>
    <td class="tg-7fd7">special&nbsp;&nbsp;&nbsp;version of string compareTo</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">SpecialStringIndexOf</td>
    <td class="tg-7fd7">special&nbsp;&nbsp;&nbsp;version of string indexOf</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceCallFixup</td>
    <td class="tg-7fd7">traces&nbsp;&nbsp;&nbsp;all call fixups</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">DeoptimizeALot</td>
    <td class="tg-7fd7">deoptimize&nbsp;&nbsp;&nbsp;at every exit from the runtime system</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">DeoptimizeOnlyAt</td>
    <td class="tg-7fd7">a&nbsp;&nbsp;&nbsp;comma separated list of bcis to deoptimize at</td>
    <td class="tg-7fd7">""</td>
    <td class="tg-7fd7">ccstr</td>
  </tr>
  <tr>
    <td class="tg-elk0">Debugging</td>
    <td class="tg-7fd7">set&nbsp;&nbsp;&nbsp;when executing debug methods in debug.ccp (to prevent triggering assertions)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceHandleAllocation</td>
    <td class="tg-7fd7">Prints&nbsp;&nbsp;&nbsp;out warnings when suspicious many handles are allocated</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ShowSafepointMsgs</td>
    <td class="tg-7fd7">Show&nbsp;&nbsp;&nbsp;msg. about safepoint synch.</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">SafepointTimeout</td>
    <td class="tg-7fd7">Time&nbsp;&nbsp;&nbsp;out and warn or fail after SafepointTimeoutDelay milliseconds if failed to&nbsp;&nbsp;&nbsp;reach safepoint</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">DieOnSafepointTimeout</td>
    <td class="tg-7fd7">Die&nbsp;&nbsp;&nbsp;upon failure to reach safepoint (see SafepointTimeout)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ForceFloatExceptions</td>
    <td class="tg-7fd7">Force&nbsp;&nbsp;&nbsp;exceptions on FP stack under/overflow</td>
    <td class="tg-7fd7">trueInDebug</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">SoftMatchFailure</td>
    <td class="tg-7fd7">If&nbsp;&nbsp;&nbsp;the DFA fails to match a node, print a message and bail out</td>
    <td class="tg-7fd7">trueInProduct</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyStackAtCalls</td>
    <td class="tg-7fd7">Verify&nbsp;&nbsp;&nbsp;that the stack pointer is unchanged after calls</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceJavaAssertions</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;java language assertions</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ZapDeadCompiledLocals</td>
    <td class="tg-7fd7">Zap&nbsp;&nbsp;&nbsp;dead locals in compiler frames</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseMallocOnly</td>
    <td class="tg-7fd7">use&nbsp;&nbsp;&nbsp;only malloc/free for allocation (no resource area/arena)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintMalloc</td>
    <td class="tg-7fd7">print&nbsp;&nbsp;&nbsp;all malloc/free calls</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ZapResourceArea</td>
    <td class="tg-7fd7">Zap&nbsp;&nbsp;&nbsp;freed resource/arena space with 0xABABABAB</td>
    <td class="tg-7fd7">trueInDebug</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ZapJNIHandleArea</td>
    <td class="tg-7fd7">Zap&nbsp;&nbsp;&nbsp;freed JNI handle space with 0xFEFEFEFE</td>
    <td class="tg-7fd7">trueInDebug</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ZapUnusedHeapArea</td>
    <td class="tg-7fd7">Zap&nbsp;&nbsp;&nbsp;unused heap space with 0xBAADBABE</td>
    <td class="tg-7fd7">trueInDebug</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintVMMessages</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;vm messages on console</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">Verbose</td>
    <td class="tg-7fd7">Prints&nbsp;&nbsp;&nbsp;additional debugging information from other modes</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintMiscellaneous</td>
    <td class="tg-7fd7">Prints&nbsp;&nbsp;&nbsp;uncategorized debugging information (requires +Verbose)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">WizardMode</td>
    <td class="tg-7fd7">Prints&nbsp;&nbsp;&nbsp;much more debugging information</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">SegmentedHeapDumpThreshold</td>
    <td class="tg-7fd7">Generate&nbsp;&nbsp;&nbsp;a segmented heap dump (JAVA PROFILE 1.0.2 format) when the heap usage is&nbsp;&nbsp;&nbsp;larger than this</td>
    <td class="tg-7fd7">2*G</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">HeapDumpSegmentSize</td>
    <td class="tg-7fd7">Approximate&nbsp;&nbsp;&nbsp;segment size when generating a segmented heap dump</td>
    <td class="tg-7fd7">1*G</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">BreakAtWarning</td>
    <td class="tg-7fd7">Execute&nbsp;&nbsp;&nbsp;breakpoint upon encountering VM warning</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceVMOperation</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;vm operations</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseFakeTimers</td>
    <td class="tg-7fd7">Tells&nbsp;&nbsp;&nbsp;whether the VM should use system time or a fake timer</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintAssembly</td>
    <td class="tg-wogo"><a href="https://wikis.oracle.com/display/HotSpotInternals/PrintAssembly">Print&nbsp;&nbsp;&nbsp;assembly code. Requires disassembler plugin, see details here.</a></td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintNMethods</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;assembly code for nmethods when generated</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintNativeNMethods</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;assembly code for native nmethods when generated</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintDebugInfo</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;debug information for all nmethods when generated</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintRelocations</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;relocation information for all nmethods when generated</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintDependencies</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;dependency information for all nmethods when generated</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintExceptionHandlers</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;exception handler tables for all nmethods when generated</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">InterceptOSException</td>
    <td class="tg-7fd7">Starts&nbsp;&nbsp;&nbsp;debugger when an implicit OS (e.g., NULL) exception happens</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintCodeCache2</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;detailed info on the compiled_code cache when exiting</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintStubCode</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;generated stub code</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintJVMWarnings</td>
    <td class="tg-7fd7">Prints&nbsp;&nbsp;&nbsp;warnings for unimplemented JVM functions</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">InitializeJavaLangSystem</td>
    <td class="tg-7fd7">Initialize&nbsp;&nbsp;&nbsp;java.lang.System - turn off for individual method debugging</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">InitializeJavaLangString</td>
    <td class="tg-7fd7">Initialize&nbsp;&nbsp;&nbsp;java.lang.String - turn off for individual method debugging</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">InitializeJavaLangExceptionsErrors</td>
    <td class="tg-7fd7">Initialize&nbsp;&nbsp;&nbsp;various error and exception classes - turn off for individual method&nbsp;&nbsp;&nbsp;debugging</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">RegisterReferences</td>
    <td class="tg-7fd7">Tells&nbsp;&nbsp;&nbsp;whether the VM should register soft/weak/final/phantom references</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">IgnoreRewrites</td>
    <td class="tg-7fd7">Supress&nbsp;&nbsp;&nbsp;rewrites of bytecodes in the oopmap generator. This is unsafe!</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintCodeCacheExtension</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;extension of code cache</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UsePrivilegedStack</td>
    <td class="tg-7fd7">Enable&nbsp;&nbsp;&nbsp;the security JVM functions</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">IEEEPrecision</td>
    <td class="tg-7fd7">Enables&nbsp;&nbsp;&nbsp;IEEE precision (for INTEL only)</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ProtectionDomainVerification</td>
    <td class="tg-7fd7">Verifies&nbsp;&nbsp;&nbsp;protection domain before resolution in system dictionary</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">DisableStartThread</td>
    <td class="tg-7fd7">Disable&nbsp;&nbsp;&nbsp;starting of additional Java threads (for debugging only)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">MemProfiling</td>
    <td class="tg-7fd7">Write&nbsp;&nbsp;&nbsp;memory usage profiling to log file</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseDetachedThreads</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;detached threads that are recycled upon termination (for SOLARIS only)</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UsePthreads</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;pthread-based instead of libthread-based synchronization (SPARC only)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UpdateHotSpotCompilerFileOnError</td>
    <td class="tg-7fd7">Should&nbsp;&nbsp;&nbsp;the system attempt to update the compiler file when an error occurs?</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">LoadLineNumberTables</td>
    <td class="tg-7fd7">Tells&nbsp;&nbsp;&nbsp;whether the class file parser loads line number tables</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">LoadLocalVariableTables</td>
    <td class="tg-7fd7">Tells&nbsp;&nbsp;&nbsp;whether the class file parser loads local variable tables</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">LoadLocalVariableTypeTables</td>
    <td class="tg-7fd7">Tells&nbsp;&nbsp;&nbsp;whether the class file parser loads local variable type tables</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PreallocatedOutOfMemoryErrorCount</td>
    <td class="tg-7fd7">Number&nbsp;&nbsp;&nbsp;of OutOfMemoryErrors preallocated with backtrace</td>
    <td class="tg-7fd7">4</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintBiasedLockingStatistics</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;statistics of biased locking in JVM</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceJVMPI</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;JVMPI</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceJNICalls</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;JNI calls</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceJNIHandleAllocation</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;allocation/deallocation of JNI handle blocks</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceThreadEvents</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;all thread events</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceBytecodes</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;bytecode execution</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceClassInitialization</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;class initialization</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceExceptions</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;exceptions</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceICs</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;inline cache changes</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceInlineCacheClearing</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;clearing of inline caches in nmethods</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceDependencies</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;dependencies</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyDependencies</td>
    <td class="tg-7fd7">Exercise&nbsp;&nbsp;&nbsp;and verify the compilation dependency mechanism</td>
    <td class="tg-7fd7">trueInDebug</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceNewOopMapGeneration</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;OopMapGeneration</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceNewOopMapGenerationDetailed</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;OopMapGeneration: print detailed cell states</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TimeOopMap</td>
    <td class="tg-7fd7">Time&nbsp;&nbsp;&nbsp;calls to GenerateOopMap::compute_map() in sum</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TimeOopMap2</td>
    <td class="tg-7fd7">Time&nbsp;&nbsp;&nbsp;calls to GenerateOopMap::compute_map() individually</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceMonitorMismatch</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;monitor matching failures during OopMapGeneration</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceOopMapRewrites</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;rewritting of method oops during oop map generation</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceSafepoint</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;safepoint operations</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceICBuffer</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;usage of IC buffer</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceCompiledIC</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;changes of compiled IC</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceStartupTime</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;setup time</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceHPI</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;Host Porting Interface (HPI)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceProtectionDomainVerification</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;protection domain verifcation</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceClearedExceptions</td>
    <td class="tg-7fd7">Prints&nbsp;&nbsp;&nbsp;when an exception is forcibly cleared</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseParallelOldGCChunkPointerCalc</td>
    <td class="tg-7fd7">In&nbsp;&nbsp;&nbsp;the Parallel Old garbage collector use chucks to calculate" new object&nbsp;&nbsp;&nbsp;locations</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyParallelOldWithMarkSweep</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;the MarkSweep code to verify phases of Parallel Old</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyParallelOldWithMarkSweepInterval</td>
    <td class="tg-7fd7">Interval&nbsp;&nbsp;&nbsp;at which the MarkSweep code is used to verify phases of Parallel Old</td>
    <td class="tg-7fd7">1</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">ParallelOldMTUnsafeMarkBitMap</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;the Parallel Old MT unsafe in marking the bitmap</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ParallelOldMTUnsafeUpdateLiveData</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;the Parallel Old MT unsafe in update of live size</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceChunkTasksQueuing</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;the queuing of the chunk tasks</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ScavengeWithObjectsInToSpace</td>
    <td class="tg-7fd7">Allow&nbsp;&nbsp;&nbsp;scavenges to occur when to_space contains objects.</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseCMSAdaptiveFreeLists</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;Adaptive Free Lists in the CMS generation</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseAsyncConcMarkSweepGC</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;Asynchronous Concurrent Mark-Sweep GC in the old generation</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">RotateCMSCollectionTypes</td>
    <td class="tg-7fd7">Rotate&nbsp;&nbsp;&nbsp;the CMS collections among concurrent and STW</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSTraceIncrementalMode</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;CMS incremental mode</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSTraceIncrementalPacing</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;CMS incremental mode pacing computation</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSTraceThreadState</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;the CMS thread state (enable the trace_state() method)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSDictionaryChoice</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;BinaryTreeDictionary as default in the CMS generation</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSOverflowEarlyRestoration</td>
    <td class="tg-7fd7">Whether&nbsp;&nbsp;&nbsp;preserved marks should be restored early</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSTraceSweeper</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;some actions of the CMS sweeper</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">FLSVerifyDictionary</td>
    <td class="tg-7fd7">Do&nbsp;&nbsp;&nbsp;lots of (expensive) FLS dictionary verification</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyBlockOffsetArray</td>
    <td class="tg-7fd7">Do&nbsp;&nbsp;&nbsp;(expensive!) block offset array verification</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceCMSState</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;the state of the CMS collection</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSTestInFreeList</td>
    <td class="tg-7fd7">Check&nbsp;&nbsp;&nbsp;if the coalesced range is already in the free lists as claimed.</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSIgnoreResurrection</td>
    <td class="tg-7fd7">Ignore&nbsp;&nbsp;&nbsp;object resurrection during the verification.</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">FullGCALot</td>
    <td class="tg-7fd7">Force&nbsp;&nbsp;&nbsp;full gc at every Nth exit from the runtime system (N=FullGCALotInterval)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PromotionFailureALotCount</td>
    <td class="tg-7fd7">Number&nbsp;&nbsp;&nbsp;of promotion failures occurring at ParGCAllocBuffer" refill attempts&nbsp;&nbsp;&nbsp;(ParNew) or promotion attempts (other young collectors)</td>
    <td class="tg-7fd7">1000</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">PromotionFailureALotInterval</td>
    <td class="tg-7fd7">Total&nbsp;&nbsp;&nbsp;collections between promotion failures alot</td>
    <td class="tg-7fd7">5</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">WorkStealingSleepMillis</td>
    <td class="tg-7fd7">Sleep&nbsp;&nbsp;&nbsp;time when sleep is used for yields</td>
    <td class="tg-7fd7">1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">WorkStealingYieldsBeforeSleep</td>
    <td class="tg-7fd7">Number&nbsp;&nbsp;&nbsp;of yields before a sleep is done during workstealing</td>
    <td class="tg-7fd7">1000</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceAdaptiveGCBoundary</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;young-old boundary moves</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PSAdaptiveSizePolicyResizeVirtualSpaceAlot</td>
    <td class="tg-7fd7">Resize&nbsp;&nbsp;&nbsp;the virtual spaces of the young or old generations</td>
    <td class="tg-7fd7">-1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">PSAdjustTenuredGenForMinorPause</td>
    <td class="tg-7fd7">Adjust&nbsp;&nbsp;&nbsp;tenured generation to achive a minor pause goal</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PSAdjustYoungGenForMajorPause</td>
    <td class="tg-7fd7">Adjust&nbsp;&nbsp;&nbsp;young generation to achive a major pause goal</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">AdaptiveSizePolicyReadyThreshold</td>
    <td class="tg-7fd7">Number&nbsp;&nbsp;&nbsp;of collections before the adaptive sizing is started</td>
    <td class="tg-7fd7">5</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">AdaptiveSizePolicyGCTimeLimitThreshold</td>
    <td class="tg-7fd7">Number&nbsp;&nbsp;&nbsp;of consecutive collections before gc time limit fires</td>
    <td class="tg-7fd7">5</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">UsePrefetchQueue</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;the prefetch queue during PS promotion</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ConcGCYieldTimeout</td>
    <td class="tg-7fd7">If&nbsp;&nbsp;&nbsp;non-zero, assert that GC threads yield within this # of ms.</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceReferenceGC</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;handling of soft/weak/final/phantom references</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceFinalizerRegistration</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;registration of final references</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceWorkGang</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;activities of work gangs</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceBlockOffsetTable</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;BlockOffsetTable maps</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceCardTableModRefBS</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;CardTableModRefBS maps</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceGCTaskManager</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;actions of the GC task manager</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceGCTaskQueue</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;actions of the GC task queues</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceGCTaskThread</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;actions of the GC task threads</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceParallelOldGCMarkingPhase</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;parallel old gc marking phase</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceParallelOldGCSummaryPhase</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;parallel old gc summary phase</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceParallelOldGCCompactionPhase</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;parallel old gc compaction phase</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceParallelOldGCDensePrefix</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;parallel old gc dense prefix computation</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">IgnoreLibthreadGPFault</td>
    <td class="tg-7fd7">Suppress&nbsp;&nbsp;&nbsp;workaround for libthread GP fault</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CIPrintCompilerName</td>
    <td class="tg-7fd7">when&nbsp;&nbsp;&nbsp;CIPrint is active, print the name of the active compiler</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CIPrintCompileQueue</td>
    <td class="tg-7fd7">display&nbsp;&nbsp;&nbsp;the contents of the compile queue whenever a compilation is enqueued</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CIPrintRequests</td>
    <td class="tg-7fd7">display&nbsp;&nbsp;&nbsp;every request for compilation</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CITimeEach</td>
    <td class="tg-7fd7">display&nbsp;&nbsp;&nbsp;timing information after each successful compilation</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CICountOSR</td>
    <td class="tg-7fd7">use&nbsp;&nbsp;&nbsp;a separate counter when assigning ids to osr compilations</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CICompileNatives</td>
    <td class="tg-7fd7">compile&nbsp;&nbsp;&nbsp;native methods if supported by the compiler</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CIPrintMethodCodes</td>
    <td class="tg-7fd7">print&nbsp;&nbsp;&nbsp;method bytecodes of the compiled code</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CIPrintTypeFlow</td>
    <td class="tg-7fd7">print&nbsp;&nbsp;&nbsp;the results of ciTypeFlow analysis</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CITraceTypeFlow</td>
    <td class="tg-7fd7">detailed&nbsp;&nbsp;&nbsp;per-bytecode tracing of ciTypeFlow analysis</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CICloneLoopTestLimit</td>
    <td class="tg-7fd7">size&nbsp;&nbsp;&nbsp;limit for blocks heuristically cloned in ciTypeFlow</td>
    <td class="tg-7fd7">100</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseStackBanging</td>
    <td class="tg-7fd7">use&nbsp;&nbsp;&nbsp;stack banging for stack overflow checks (required for proper StackOverflow&nbsp;&nbsp;&nbsp;handling; disable only to measure cost of stackbanging)</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">Use24BitFPMode</td>
    <td class="tg-7fd7">Set&nbsp;&nbsp;&nbsp;24-bit FPU mode on a per-compile basis</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">Use24BitFP</td>
    <td class="tg-7fd7">use&nbsp;&nbsp;&nbsp;FP instructions that produce 24-bit precise results</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseStrictFP</td>
    <td class="tg-7fd7">use&nbsp;&nbsp;&nbsp;strict fp if modifier strictfp is set</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">GenerateSynchronizationCode</td>
    <td class="tg-7fd7">generate&nbsp;&nbsp;&nbsp;locking/unlocking code for synchronized methods and monitors</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">GenerateCompilerNullChecks</td>
    <td class="tg-7fd7">Generate&nbsp;&nbsp;&nbsp;explicit null checks for loads/stores/calls</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">GenerateRangeChecks</td>
    <td class="tg-7fd7">Generate&nbsp;&nbsp;&nbsp;range checks for array accesses</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintSafepointStatistics</td>
    <td class="tg-7fd7">print&nbsp;&nbsp;&nbsp;statistics about safepoint synchronization</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">InlineAccessors</td>
    <td class="tg-7fd7">inline&nbsp;&nbsp;&nbsp;accessor methods (get/set)</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseCHA</td>
    <td class="tg-7fd7">enable&nbsp;&nbsp;&nbsp;CHA</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintInlining</td>
    <td class="tg-7fd7">prints&nbsp;&nbsp;&nbsp;inlining optimizations</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">EagerInitialization</td>
    <td class="tg-7fd7">Eagerly&nbsp;&nbsp;&nbsp;initialize classes if possible</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceMethodReplacement</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;when methods are replaced do to recompilation</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintMethodFlushing</td>
    <td class="tg-7fd7">print&nbsp;&nbsp;&nbsp;the nmethods being flushed</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseRelocIndex</td>
    <td class="tg-7fd7">use&nbsp;&nbsp;&nbsp;an index to speed random access to relocations</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">StressCodeBuffers</td>
    <td class="tg-7fd7">Exercise&nbsp;&nbsp;&nbsp;code buffer expansion and other rare state changes</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">DebugVtables</td>
    <td class="tg-7fd7">add&nbsp;&nbsp;&nbsp;debugging code to vtable dispatch</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintVtables</td>
    <td class="tg-7fd7">print&nbsp;&nbsp;&nbsp;vtables when printing klass</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceCreateZombies</td>
    <td class="tg-7fd7">trace&nbsp;&nbsp;&nbsp;creation of zombie nmethods</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">MonomorphicArrayCheck</td>
    <td class="tg-7fd7">Uncommon-trap&nbsp;&nbsp;&nbsp;array store checks that require full type check</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">DelayCompilationDuringStartup</td>
    <td class="tg-7fd7">Delay&nbsp;&nbsp;&nbsp;invoking the compiler until main application class is loaded</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CompileTheWorld</td>
    <td class="tg-7fd7">Compile&nbsp;&nbsp;&nbsp;all methods in all classes in bootstrap class path (stress test)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CompileTheWorldPreloadClasses</td>
    <td class="tg-7fd7">Preload&nbsp;&nbsp;&nbsp;all classes used by a class before start loading</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceIterativeGVN</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;progress during Iterative Global Value Numbering</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">FillDelaySlots</td>
    <td class="tg-7fd7">Fill&nbsp;&nbsp;&nbsp;delay slots (on SPARC only)</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyIterativeGVN</td>
    <td class="tg-7fd7">Verify&nbsp;&nbsp;&nbsp;Def-Use modifications during sparse Iterative Global Value Numbering</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TimeLivenessAnalysis</td>
    <td class="tg-7fd7">Time&nbsp;&nbsp;&nbsp;computation of bytecode liveness analysis</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceLivenessGen</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;the generation of liveness analysis information</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintDominators</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;out dominator trees for GVN</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseLoopSafepoints</td>
    <td class="tg-7fd7">Generate&nbsp;&nbsp;&nbsp;Safepoint nodes in every loop</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">DeutschShiffmanExceptions</td>
    <td class="tg-7fd7">Fast&nbsp;&nbsp;&nbsp;check to find exception handler for precisely typed exceptions</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">FastAllocateSizeLimit</td>
    <td class="tg-7fd7">Inline&nbsp;&nbsp;&nbsp;allocations larger than this in doublewords must go slow</td>
    <td class="tg-7fd7">100000</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseVTune</td>
    <td class="tg-7fd7">enable&nbsp;&nbsp;&nbsp;support for Intel's VTune profiler</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CountCompiledCalls</td>
    <td class="tg-7fd7">counts&nbsp;&nbsp;&nbsp;method invocations</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CountJNICalls</td>
    <td class="tg-7fd7">counts&nbsp;&nbsp;&nbsp;jni method invocations</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ClearInterpreterLocals</td>
    <td class="tg-7fd7">Always&nbsp;&nbsp;&nbsp;clear local variables of interpreter activations upon entry</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseFastSignatureHandlers</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;fast signature handlers for native calls</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseV8InstrsOnly</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;SPARC-V8 Compliant instruction subset</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseCASForSwap</td>
    <td class="tg-7fd7">Do&nbsp;&nbsp;&nbsp;not use swap instructions, but only CAS (in a loop) on SPARC</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PoisonOSREntry</td>
    <td class="tg-7fd7">Detect&nbsp;&nbsp;&nbsp;abnormal calls to OSR code</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CountBytecodes</td>
    <td class="tg-7fd7">Count&nbsp;&nbsp;&nbsp;number of bytecodes executed</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintBytecodeHistogram</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;histogram of the executed bytecodes</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintBytecodePairHistogram</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;histogram of the executed bytecode pairs</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintSignatureHandlers</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;code generated for native method signature handlers</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyOops</td>
    <td class="tg-7fd7">Do&nbsp;&nbsp;&nbsp;plausibility checks for oops</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CheckUnhandledOops</td>
    <td class="tg-7fd7">Check&nbsp;&nbsp;&nbsp;for unhandled oops in VM code</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyJNIFields</td>
    <td class="tg-7fd7">Verify&nbsp;&nbsp;&nbsp;jfieldIDs for instance fields</td>
    <td class="tg-7fd7">trueInDebug</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyFPU</td>
    <td class="tg-7fd7">Verify&nbsp;&nbsp;&nbsp;FPU state (check for NaN's, etc.)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyThread</td>
    <td class="tg-7fd7">Watch&nbsp;&nbsp;&nbsp;the thread register for corruption (SPARC only)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyActivationFrameSize</td>
    <td class="tg-7fd7">Verify&nbsp;&nbsp;&nbsp;that activation frame didn't become smaller than its minimal size</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceFrequencyInlining</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;frequency based inlining</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintMethodData</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;the results of +ProfileInterpreter at end of run</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyDataPointer</td>
    <td class="tg-7fd7">Verify&nbsp;&nbsp;&nbsp;the method data pointer during interpreter profiling</td>
    <td class="tg-7fd7">trueInDebug</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceCompilationPolicy</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;compilation policy</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TimeCompilationPolicy</td>
    <td class="tg-7fd7">Time&nbsp;&nbsp;&nbsp;the compilation policy</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CounterHalfLifeTime</td>
    <td class="tg-7fd7">half-life&nbsp;&nbsp;&nbsp;time of invocation counters (in secs)</td>
    <td class="tg-7fd7">30</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CounterDecayMinIntervalLength</td>
    <td class="tg-7fd7">Min.&nbsp;&nbsp;&nbsp;ms. between invocation of CounterDecay</td>
    <td class="tg-7fd7">500</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceDeoptimization</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;deoptimization</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">DebugDeoptimization</td>
    <td class="tg-7fd7">Tracing&nbsp;&nbsp;&nbsp;various information while debugging deoptimization</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">GuaranteedSafepointInterval</td>
    <td class="tg-7fd7">Guarantee&nbsp;&nbsp;&nbsp;a safepoint (at least) every so many milliseconds (0 means none)</td>
    <td class="tg-7fd7">1000</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">SafepointTimeoutDelay</td>
    <td class="tg-7fd7">Delay&nbsp;&nbsp;&nbsp;in milliseconds for option SafepointTimeout</td>
    <td class="tg-7fd7">10000</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MallocCatchPtr</td>
    <td class="tg-7fd7">Hit&nbsp;&nbsp;&nbsp;breakpoint when mallocing/freeing this pointer</td>
    <td class="tg-7fd7">-1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">TotalHandleAllocationLimit</td>
    <td class="tg-7fd7">Threshold&nbsp;&nbsp;&nbsp;for total handle allocation when +TraceHandleAllocation is used</td>
    <td class="tg-7fd7">1024</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">StackPrintLimit</td>
    <td class="tg-7fd7">number&nbsp;&nbsp;&nbsp;of stack frames to print in VM-level stack dump</td>
    <td class="tg-7fd7">100</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MaxInlineLevel</td>
    <td class="tg-7fd7">maximum&nbsp;&nbsp;&nbsp;number of nested calls that are inlined</td>
    <td class="tg-7fd7">9</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MaxRecursiveInlineLevel</td>
    <td class="tg-7fd7">maximum&nbsp;&nbsp;&nbsp;number of nested recursive calls that are inlined</td>
    <td class="tg-7fd7">1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">InlineSmallCode</td>
    <td class="tg-7fd7">Only&nbsp;&nbsp;&nbsp;inline already compiled methods if their code size is less than this</td>
    <td class="tg-7fd7">1000</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MaxTrivialSize</td>
    <td class="tg-7fd7">maximum&nbsp;&nbsp;&nbsp;bytecode size of a trivial method to be inlined</td>
    <td class="tg-7fd7">6</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MinInliningThreshold</td>
    <td class="tg-7fd7">min.&nbsp;&nbsp;&nbsp;invocation count a method needs to have to be inlined</td>
    <td class="tg-7fd7">250</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">AlignEntryCode</td>
    <td class="tg-7fd7">aligns&nbsp;&nbsp;&nbsp;entry code to specified value (in bytes)</td>
    <td class="tg-7fd7">4</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MethodHistogramCutoff</td>
    <td class="tg-7fd7">cutoff&nbsp;&nbsp;&nbsp;value for method invoc. histogram (+CountCalls)</td>
    <td class="tg-7fd7">100</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">ProfilerNumberOfInterpretedMethods</td>
    <td class="tg-7fd7">#&nbsp;&nbsp;&nbsp;of interpreted methods to show in profile</td>
    <td class="tg-7fd7">25</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">ProfilerNumberOfCompiledMethods</td>
    <td class="tg-7fd7">#&nbsp;&nbsp;&nbsp;of compiled methods to show in profile</td>
    <td class="tg-7fd7">25</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">ProfilerNumberOfStubMethods</td>
    <td class="tg-7fd7">#&nbsp;&nbsp;&nbsp;of stub methods to show in profile</td>
    <td class="tg-7fd7">25</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">ProfilerNumberOfRuntimeStubNodes</td>
    <td class="tg-7fd7">#&nbsp;&nbsp;&nbsp;of runtime stub nodes to show in profile</td>
    <td class="tg-7fd7">25</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">DontYieldALotInterval</td>
    <td class="tg-7fd7">Interval&nbsp;&nbsp;&nbsp;between which yields will be dropped (milliseconds)</td>
    <td class="tg-7fd7">10</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MinSleepInterval</td>
    <td class="tg-7fd7">Minimum&nbsp;&nbsp;&nbsp;sleep() interval (milliseconds) when ConvertSleepToYield is off (used for&nbsp;&nbsp;&nbsp;SOLARIS)</td>
    <td class="tg-7fd7">1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">ProfilerPCTickThreshold</td>
    <td class="tg-7fd7">Number&nbsp;&nbsp;&nbsp;of ticks in a PC buckets to be a hotspot</td>
    <td class="tg-7fd7">15</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">StressNonEntrant</td>
    <td class="tg-7fd7">Mark&nbsp;&nbsp;&nbsp;nmethods non-entrant at registration</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TypeProfileWidth</td>
    <td class="tg-7fd7">number&nbsp;&nbsp;&nbsp;of receiver types to record in call profile</td>
    <td class="tg-7fd7">2</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">BciProfileWidth</td>
    <td class="tg-7fd7">number&nbsp;&nbsp;&nbsp;of return bci's to record in ret profile</td>
    <td class="tg-7fd7">2</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">FreqCountInvocations</td>
    <td class="tg-7fd7">Scaling&nbsp;&nbsp;&nbsp;factor for branch frequencies (deprecated)</td>
    <td class="tg-7fd7">1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">InlineFrequencyRatio</td>
    <td class="tg-7fd7">Ratio&nbsp;&nbsp;&nbsp;of call site execution to caller method invocation</td>
    <td class="tg-7fd7">20</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">InlineThrowCount</td>
    <td class="tg-7fd7">Force&nbsp;&nbsp;&nbsp;inlining of interpreted methods that throw this often</td>
    <td class="tg-7fd7">50</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">InlineThrowMaxSize</td>
    <td class="tg-7fd7">Force&nbsp;&nbsp;&nbsp;inlining of throwing methods smaller than this</td>
    <td class="tg-7fd7">200</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyAliases</td>
    <td class="tg-7fd7">perform&nbsp;&nbsp;&nbsp;extra checks on the results of alias analysis</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ProfilerNodeSize</td>
    <td class="tg-7fd7">Size&nbsp;&nbsp;&nbsp;in K to allocate for the Profile Nodes of each thread</td>
    <td class="tg-7fd7">1024</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">V8AtomicOperationUnderLockSpinCount</td>
    <td class="tg-7fd7">Number&nbsp;&nbsp;&nbsp;of times to spin wait on a v8 atomic operation lock</td>
    <td class="tg-7fd7">50</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">ExitAfterGCNum</td>
    <td class="tg-7fd7">If&nbsp;&nbsp;&nbsp;non-zero, exit after this GC.</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">GCExpandToAllocateDelayMillis</td>
    <td class="tg-7fd7">Delay&nbsp;&nbsp;&nbsp;in ms between expansion and allocation</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CodeCacheSegmentSize</td>
    <td class="tg-7fd7">Code&nbsp;&nbsp;&nbsp;cache segment size (in bytes) - smallest unit of allocation</td>
    <td class="tg-7fd7">64</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">BinarySwitchThreshold</td>
    <td class="tg-7fd7">Minimal&nbsp;&nbsp;&nbsp;number of lookupswitch entries for rewriting to binary switch</td>
    <td class="tg-7fd7">5</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">StopInterpreterAt</td>
    <td class="tg-7fd7">Stops&nbsp;&nbsp;&nbsp;interpreter execution at specified bytecode number</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceBytecodesAt</td>
    <td class="tg-7fd7">Traces&nbsp;&nbsp;&nbsp;bytecodes starting with specified bytecode number</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CIStart</td>
    <td class="tg-7fd7">the&nbsp;&nbsp;&nbsp;id of the first compilation to permit</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CIStop</td>
    <td class="tg-7fd7">the&nbsp;&nbsp;&nbsp;id of the last compilation to permit</td>
    <td class="tg-7fd7">-1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CIStartOSR</td>
    <td class="tg-7fd7">the&nbsp;&nbsp;&nbsp;id of the first osr compilation to permit (CICountOSR must be on)</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CIStopOSR</td>
    <td class="tg-7fd7">the&nbsp;&nbsp;&nbsp;id of the last osr compilation to permit (CICountOSR must be on)</td>
    <td class="tg-7fd7">-1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CIBreakAtOSR</td>
    <td class="tg-7fd7">id&nbsp;&nbsp;&nbsp;of osr compilation to break at</td>
    <td class="tg-7fd7">-1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CIBreakAt</td>
    <td class="tg-7fd7">id&nbsp;&nbsp;&nbsp;of compilation to break at</td>
    <td class="tg-7fd7">-1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CIFireOOMAt</td>
    <td class="tg-7fd7">Fire&nbsp;&nbsp;&nbsp;OutOfMemoryErrors throughout CI for testing the compiler (non-negative value&nbsp;&nbsp;&nbsp;throws OOM after this many CI accesses in each compile)</td>
    <td class="tg-7fd7">-1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CIFireOOMAtDelay</td>
    <td class="tg-7fd7">Wait&nbsp;&nbsp;&nbsp;for this many CI accesses to occur in all compiles before beginning to throw&nbsp;&nbsp;&nbsp;OutOfMemoryErrors in each compile</td>
    <td class="tg-7fd7">-1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">NewCodeParameter</td>
    <td class="tg-7fd7">Testing&nbsp;&nbsp;&nbsp;Only: Create a dedicated integer parameter before putback</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MinOopMapAllocation</td>
    <td class="tg-7fd7">Minimum&nbsp;&nbsp;&nbsp;number of OopMap entries in an OopMapSet</td>
    <td class="tg-7fd7">8</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">LongCompileThreshold</td>
    <td class="tg-7fd7">Used&nbsp;&nbsp;&nbsp;with +TraceLongCompiles</td>
    <td class="tg-7fd7">50</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MaxRecompilationSearchLength</td>
    <td class="tg-7fd7">max.&nbsp;&nbsp;&nbsp;# frames to inspect searching for recompilee</td>
    <td class="tg-7fd7">10</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MaxInterpretedSearchLength</td>
    <td class="tg-7fd7">max.&nbsp;&nbsp;&nbsp;# interp. frames to skip when searching for recompilee</td>
    <td class="tg-7fd7">3</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">DesiredMethodLimit</td>
    <td class="tg-7fd7">desired&nbsp;&nbsp;&nbsp;max. method size (in bytecodes) after inlining</td>
    <td class="tg-7fd7">8000</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">HugeMethodLimit</td>
    <td class="tg-7fd7">don't&nbsp;&nbsp;&nbsp;compile methods larger than this if +DontCompileHugeMethods</td>
    <td class="tg-7fd7">8000</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseNewReflection</td>
    <td class="tg-7fd7">Temporary&nbsp;&nbsp;&nbsp;flag for transition to reflection based on dynamic bytecode generation in&nbsp;&nbsp;&nbsp;1.4; can no longer be turned off in 1.4 JDK, and is unneeded in 1.3 JDK, but&nbsp;&nbsp;&nbsp;marks most places VM changes were needed</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyReflectionBytecodes</td>
    <td class="tg-7fd7">Force&nbsp;&nbsp;&nbsp;verification of 1.4 reflection bytecodes. Does not work in situations like&nbsp;&nbsp;&nbsp;that described in 4486457 or for constructors generated for serialization, so&nbsp;&nbsp;&nbsp;can not be enabled in product.</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">FastSuperclassLimit</td>
    <td class="tg-7fd7">Depth&nbsp;&nbsp;&nbsp;of hardwired instanceof accelerator array</td>
    <td class="tg-7fd7">8</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">PerfTraceDataCreation</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;creation of Performance Data Entries</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PerfTraceMemOps</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;PerfMemory create/attach/detach calls</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">SharedOptimizeColdStartPolicy</td>
    <td class="tg-7fd7">Reordering&nbsp;&nbsp;&nbsp;policy for SharedOptimizeColdStart 0=favor classload-time locality,&nbsp;&nbsp;&nbsp;1=balanced, 2=favor runtime locality</td>
    <td class="tg-7fd7">2</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-vp9j" colspan="4"><a href="https://stas-blogspot.blogspot.com/2011/07/most-complete-list-of-xx-options-for.html">product_pd</a></td>
  </tr>
  <tr>
    <td class="tg-elk0">UseLargePages</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;large page memory</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseSSE</td>
    <td class="tg-7fd7">0=fpu&nbsp;&nbsp;&nbsp;stack,1=SSE for floats,2=SSE/SSE2 for all (x86/amd only)</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseISM</td>
    <td class="tg-wogo"><a href="http://www.oracle.com/technetwork/java/ism-139376.html">Use Intimate&nbsp;&nbsp;&nbsp;Shared Memory. [Not accepted for non-Solaris platforms.] For details,&nbsp;&nbsp;&nbsp;see Intimate Shared Memory.</a></td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseMPSS</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;Multiple Page Size Support w/4mb pages for the heap. Do not use with ISM as&nbsp;&nbsp;&nbsp;this replaces the need for ISM. (Introduced in 1.4.0 update 1, Relevant to&nbsp;&nbsp;&nbsp;Solaris 9 and newer.) [1.4.1 and earlier: false]</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">BackgroundCompilation</td>
    <td class="tg-7fd7">A&nbsp;&nbsp;&nbsp;thread requesting compilation is not blocked during compilation</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseVectoredExceptions</td>
    <td class="tg-7fd7">Temp&nbsp;&nbsp;&nbsp;Flag - Use Vectored Exceptions rather than SEH (Windows Only)</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">DontYieldALot</td>
    <td class="tg-7fd7">Throw&nbsp;&nbsp;&nbsp;away obvious excess yield calls (for SOLARIS only)</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ConvertSleepToYield</td>
    <td class="tg-7fd7">Converts&nbsp;&nbsp;&nbsp;sleep(0) to thread yield (may be off for SOLARIS to improve GUI)</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseTLAB</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;thread-local object allocation</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ResizeTLAB</td>
    <td class="tg-7fd7">Dynamically&nbsp;&nbsp;&nbsp;resize tlab size for threads</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">NeverActAsServerClassMachine</td>
    <td class="tg-7fd7">Never&nbsp;&nbsp;&nbsp;act like a server-class machine</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrefetchCopyIntervalInBytes</td>
    <td class="tg-7fd7">How&nbsp;&nbsp;&nbsp;far ahead to prefetch destination area (&lt;= 0 means off)</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrefetchScanIntervalInBytes</td>
    <td class="tg-7fd7">How&nbsp;&nbsp;&nbsp;far ahead to prefetch scan area (&lt;= 0 means off)</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrefetchFieldsAhead</td>
    <td class="tg-7fd7">How&nbsp;&nbsp;&nbsp;many fields ahead to prefetch in oop scan (&lt;= 0 means off)</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CompilationPolicyChoice</td>
    <td class="tg-7fd7">which&nbsp;&nbsp;&nbsp;compilation policy</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">RewriteBytecodes</td>
    <td class="tg-7fd7">Allow&nbsp;&nbsp;&nbsp;rewriting of bytecodes (bytecodes are not immutable)</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">RewriteFrequentPairs</td>
    <td class="tg-7fd7">Rewrite&nbsp;&nbsp;&nbsp;frequently used bytecode pairs into a single bytecode</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseOnStackReplacement</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;on stack replacement, calls runtime if invoc. counter overflows in loop</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PreferInterpreterNativeStubs</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;always interpreter stubs for native methods invoked via interpreter</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">AllocatePrefetchStyle</td>
    <td class="tg-7fd7">0=no&nbsp;&nbsp;&nbsp;prefetch, 1=dead load, 2=prefetch instruction</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">AllocatePrefetchDistance</td>
    <td class="tg-7fd7">Distance&nbsp;&nbsp;&nbsp;to prefetch ahead of allocation pointer</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">FreqInlineSize</td>
    <td class="tg-7fd7">maximum&nbsp;&nbsp;&nbsp;bytecode size of a frequent method to be inlined</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">PreInflateSpin</td>
    <td class="tg-7fd7">Number&nbsp;&nbsp;&nbsp;of times to spin wait before inflation</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">NewSize</td>
    <td class="tg-7fd7">Default&nbsp;&nbsp;&nbsp;size of new generation (in bytes)</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">TLABSize</td>
    <td class="tg-7fd7">Default&nbsp;&nbsp;&nbsp;(or starting) size of TLAB (in bytes)</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">SurvivorRatio</td>
    <td class="tg-7fd7">Ratio&nbsp;&nbsp;&nbsp;of eden/survivor space size</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">NewRatio</td>
    <td class="tg-7fd7">Ratio&nbsp;&nbsp;&nbsp;of new/old generation sizes</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">NewSizeThreadIncrease</td>
    <td class="tg-7fd7">Additional&nbsp;&nbsp;&nbsp;size added to desired new generation size per non-daemon thread (in bytes)</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">PermSize</td>
    <td class="tg-7fd7">Default&nbsp;&nbsp;&nbsp;size of permanent generation (in bytes)</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MaxPermSize</td>
    <td class="tg-7fd7">Maximum&nbsp;&nbsp;&nbsp;size of permanent generation (in bytes)</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">StackYellowPages</td>
    <td class="tg-7fd7">Number&nbsp;&nbsp;&nbsp;of yellow zone (recoverable overflows) pages</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">StackRedPages</td>
    <td class="tg-7fd7">Number&nbsp;&nbsp;&nbsp;of red zone (unrecoverable overflows) pages</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">StackShadowPages</td>
    <td class="tg-7fd7">Number&nbsp;&nbsp;&nbsp;of shadow zone (for overflow checking) pages this should exceed the depth of&nbsp;&nbsp;&nbsp;the VM and native call stack. In the HotSpot implementation, Java methods&nbsp;&nbsp;&nbsp;share stack frames with C/C++ native code, namely user native code and the&nbsp;&nbsp;&nbsp;virtual machine itself. Java methods generate code that checks that stack&nbsp;&nbsp;&nbsp;space is available a fixed distance towards the end of the stack so that the&nbsp;&nbsp;&nbsp;native code can be called without exceeding the stack space. This distance&nbsp;&nbsp;&nbsp;towards the end of the stack is called “Shadow Pages”. The page size usually&nbsp;&nbsp;&nbsp;is 4096b, which mean that 20 pages would occupy 90Kb. See some more info on&nbsp;&nbsp;&nbsp;that parameter in bug 7059899 and Crash due to Stack&nbsp;&nbsp;&nbsp;Overflow section of "Troubleshooting&nbsp;&nbsp;&nbsp;System Crashes" from Oracle.</td>
    <td class="tg-7fd7">Depends&nbsp;&nbsp;&nbsp;on machine. It's 3 on x86, 6 on amd64, etc</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">ThreadStackSize</td>
    <td class="tg-7fd7">Thread&nbsp;&nbsp;&nbsp;Stack Size (in Kbytes)</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">VMThreadStackSize</td>
    <td class="tg-7fd7">Non-Java&nbsp;&nbsp;&nbsp;Thread Stack Size (in Kbytes)</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CompilerThreadStackSize</td>
    <td class="tg-7fd7">Compiler&nbsp;&nbsp;&nbsp;Thread Stack Size (in Kbytes)</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">InitialCodeCacheSize</td>
    <td class="tg-7fd7">Initial&nbsp;&nbsp;&nbsp;code cache size (in bytes)</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">ReservedCodeCacheSize</td>
    <td class="tg-7fd7">Reserved&nbsp;&nbsp;&nbsp;code cache size (in bytes) - maximum code cache size</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CodeCacheExpansionSize</td>
    <td class="tg-7fd7">Code&nbsp;&nbsp;&nbsp;cache expansion size (in bytes)</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CompileThreshold</td>
    <td class="tg-7fd7">number&nbsp;&nbsp;&nbsp;of method invocations/branches before (re-)compiling</td>
    <td class="tg-7fd7">10000</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">Tier2CompileThreshold</td>
    <td class="tg-7fd7">threshold&nbsp;&nbsp;&nbsp;at which a tier 2 compilation is invoked</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">Tier2BackEdgeThreshold</td>
    <td class="tg-7fd7">Back&nbsp;&nbsp;&nbsp;edge threshold at which a tier 2 compilation is invoked</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">TieredCompilation</td>
    <td class="tg-7fd7">Enable&nbsp;&nbsp;&nbsp;two-tier compilation</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">OnStackReplacePercentage</td>
    <td class="tg-7fd7">number&nbsp;&nbsp;&nbsp;of method invocations/branches (expressed as % of CompileThreshold) before&nbsp;&nbsp;&nbsp;(re-)compiling OSR code</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-vp9j" colspan="4"><a href="https://stas-blogspot.blogspot.com/2011/07/most-complete-list-of-xx-options-for.html">develop_pd</a></td>
  </tr>
  <tr>
    <td class="tg-elk0">ShareVtableStubs</td>
    <td class="tg-7fd7">Share&nbsp;&nbsp;&nbsp;vtable stubs (smaller code but worse branch prediction</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CICompileOSR</td>
    <td class="tg-7fd7">compile&nbsp;&nbsp;&nbsp;on stack replacement methods if supported by the compiler</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ImplicitNullChecks</td>
    <td class="tg-7fd7">generate&nbsp;&nbsp;&nbsp;code for implicit null checks</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UncommonNullCast</td>
    <td class="tg-7fd7">Uncommon-trap&nbsp;&nbsp;&nbsp;NULLs passed to check cast</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">InlineIntrinsics</td>
    <td class="tg-7fd7">Inline&nbsp;&nbsp;&nbsp;intrinsics that can be statically resolved</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ProfileInterpreter</td>
    <td class="tg-7fd7">Profile&nbsp;&nbsp;&nbsp;at the bytecode level during interpretation</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ProfileTraps</td>
    <td class="tg-7fd7">Profile&nbsp;&nbsp;&nbsp;deoptimization traps at the bytecode level</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">InlineFrequencyCount</td>
    <td class="tg-7fd7">Count&nbsp;&nbsp;&nbsp;of call site execution necessary to trigger frequent inlining</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">JVMInvokeMethodSlack</td>
    <td class="tg-7fd7">Stack&nbsp;&nbsp;&nbsp;space (bytes) required for JVM_InvokeMethod to complete</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CodeEntryAlignment</td>
    <td class="tg-7fd7">Code&nbsp;&nbsp;&nbsp;entry alignment for generated code (in bytes)</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CodeCacheMinBlockLength</td>
    <td class="tg-7fd7">Minimum&nbsp;&nbsp;&nbsp;number of segments in a code cache block.</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-vp9j" colspan="4"><a href="https://stas-blogspot.blogspot.com/2011/07/most-complete-list-of-xx-options-for.html">notproduct</a></td>
  </tr>
  <tr>
    <td class="tg-elk0">StressDerivedPointers</td>
    <td class="tg-7fd7">Force&nbsp;&nbsp;&nbsp;scavenge when a derived pointers is detected on stack after rtm call</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceCodeBlobStacks</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;stack-walk of codeblobs</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintRewrites</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;methods that are being rewritten</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">DeoptimizeRandom</td>
    <td class="tg-7fd7">deoptimize&nbsp;&nbsp;&nbsp;random frames on random exit from the runtime system</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ZombieALot</td>
    <td class="tg-7fd7">creates&nbsp;&nbsp;&nbsp;zombies (non-entrant) at exit from the runt. system</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">WalkStackALot</td>
    <td class="tg-7fd7">trace&nbsp;&nbsp;&nbsp;stack (no print) at every exit from the runtime system</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">StrictSafepointChecks</td>
    <td class="tg-7fd7">Enable&nbsp;&nbsp;&nbsp;strict checks that safepoints cannot happen for threads that used&nbsp;&nbsp;&nbsp;No_Safepoint_Verifier</td>
    <td class="tg-7fd7">trueInDebug</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyLastFrame</td>
    <td class="tg-7fd7">Verify&nbsp;&nbsp;&nbsp;oops on last frame on entry to VM</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">LogEvents</td>
    <td class="tg-7fd7">Enable&nbsp;&nbsp;&nbsp;Event log</td>
    <td class="tg-7fd7">trueInDebug</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CheckAssertionStatusDirectives</td>
    <td class="tg-7fd7">temporary&nbsp;&nbsp;&nbsp;- see javaClasses.cpp</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintMallocFree</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;calls to C heap malloc/free allocation</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintOopAddress</td>
    <td class="tg-7fd7">Always&nbsp;&nbsp;&nbsp;print the location of the oop</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyCodeCacheOften</td>
    <td class="tg-7fd7">Verify&nbsp;&nbsp;&nbsp;compiled-code cache often</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ZapDeadLocalsOld</td>
    <td class="tg-7fd7">Zap&nbsp;&nbsp;&nbsp;dead locals (old version, zaps all frames when entering the VM</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CheckOopishValues</td>
    <td class="tg-7fd7">Warn&nbsp;&nbsp;&nbsp;if value contains oop ( requires ZapDeadLocals)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ZapVMHandleArea</td>
    <td class="tg-7fd7">Zap&nbsp;&nbsp;&nbsp;freed VM handle space with 0xBCBCBCBC</td>
    <td class="tg-7fd7">trueInDebug</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintCompilation2</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;additional statistics per compilation</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintAdapterHandlers</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;code generated for i2c/c2i adapters</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintCodeCache</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;the compiled_code cache when exiting</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ProfilerCheckIntervals</td>
    <td class="tg-7fd7">Collect&nbsp;&nbsp;&nbsp;and print info on spacing of profiler ticks</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">WarnOnStalledSpinLock</td>
    <td class="tg-7fd7">Prints&nbsp;&nbsp;&nbsp;warnings for stalled SpinLocks</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintSystemDictionaryAtExit</td>
    <td class="tg-7fd7">Prints&nbsp;&nbsp;&nbsp;the system dictionary at exit</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ValidateMarkSweep</td>
    <td class="tg-7fd7">Do&nbsp;&nbsp;&nbsp;extra validation during MarkSweep collection</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">RecordMarkSweepCompaction</td>
    <td class="tg-7fd7">Enable&nbsp;&nbsp;&nbsp;GC-to-GC recording and querying of compaction during MarkSweep</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceRuntimeCalls</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;run-time calls</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceJVMCalls</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;JVM calls</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceInvocationCounterOverflow</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;method invocation counter overflow</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceZapDeadLocals</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;zapping dead locals</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSMarkStackOverflowALot</td>
    <td class="tg-7fd7">Whether&nbsp;&nbsp;&nbsp;we should simulate frequent marking stack / work queue" overflow</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSMarkStackOverflowInterval</td>
    <td class="tg-7fd7">A&nbsp;&nbsp;&nbsp;per-thread `interval' counter that determines how frequently" we&nbsp;&nbsp;&nbsp;simulate overflow; a smaller number increases frequency</td>
    <td class="tg-7fd7">1000</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CMSVerifyReturnedBytes</td>
    <td class="tg-7fd7">Check&nbsp;&nbsp;&nbsp;that all the garbage collected was returned to the free lists.</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ScavengeALot</td>
    <td class="tg-7fd7">Force&nbsp;&nbsp;&nbsp;scavenge at every Nth exit from the runtime system (N=ScavengeALotInterval)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">GCALotAtAllSafepoints</td>
    <td class="tg-7fd7">Enforce&nbsp;&nbsp;&nbsp;ScavengeALot/GCALot at all potential safepoints</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PromotionFailureALot</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;promotion failure handling on every youngest generation collection</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CheckMemoryInitialization</td>
    <td class="tg-7fd7">Checks&nbsp;&nbsp;&nbsp;memory initialization</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceMarkSweep</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;mark sweep</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintReferenceGC</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;times spent handling reference objects during GC (enabled only when&nbsp;&nbsp;&nbsp;PrintGCDetails)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceScavenge</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;scavenge</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TimeCompiler</td>
    <td class="tg-7fd7">time&nbsp;&nbsp;&nbsp;the compiler</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TimeCompiler2</td>
    <td class="tg-7fd7">detailed&nbsp;&nbsp;&nbsp;time the compiler (requires +TimeCompiler)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">LogMultipleMutexLocking</td>
    <td class="tg-7fd7">log&nbsp;&nbsp;&nbsp;locking and unlocking of mutexes (only if multiple locks are held)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintSymbolTableSizeHistogram</td>
    <td class="tg-7fd7">print&nbsp;&nbsp;&nbsp;histogram of the symbol table</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ExitVMOnVerifyError</td>
    <td class="tg-7fd7">standard&nbsp;&nbsp;&nbsp;exit from VM if bytecode verify error (only in debug mode)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">AbortVMOnException</td>
    <td class="tg-7fd7">Call&nbsp;&nbsp;&nbsp;fatal if this exception is thrown. Example: java&nbsp;&nbsp;&nbsp;-XX:AbortVMOnException=java.lang.NullPointerException Foo</td>
    <td class="tg-7fd7">""</td>
    <td class="tg-7fd7">ccstr</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintVtableStats</td>
    <td class="tg-7fd7">print&nbsp;&nbsp;&nbsp;vtables stats at end of run</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">IgnoreLockingAssertions</td>
    <td class="tg-7fd7">disable&nbsp;&nbsp;&nbsp;locking assertions (for speed)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyLoopOptimizations</td>
    <td class="tg-7fd7">verify&nbsp;&nbsp;&nbsp;major loop optimizations</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CompileTheWorldIgnoreInitErrors</td>
    <td class="tg-7fd7">Compile&nbsp;&nbsp;&nbsp;all methods although class initializer failed</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TracePhaseCCP</td>
    <td class="tg-7fd7">Print&nbsp;&nbsp;&nbsp;progress during Conditional Constant Propagation</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceLivenessQuery</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;queries of liveness analysis information</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CollectIndexSetStatistics</td>
    <td class="tg-7fd7">Collect&nbsp;&nbsp;&nbsp;information about IndexSets</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceCISCSpill</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;allocators use of cisc spillable instructions</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceSpilling</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;spilling</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CountVMLocks</td>
    <td class="tg-7fd7">counts&nbsp;&nbsp;&nbsp;VM internal lock attempts and contention</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CountRuntimeCalls</td>
    <td class="tg-7fd7">counts&nbsp;&nbsp;&nbsp;VM runtime calls</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CountJVMCalls</td>
    <td class="tg-7fd7">counts&nbsp;&nbsp;&nbsp;jvm method invocations</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CountRemovableExceptions</td>
    <td class="tg-7fd7">count&nbsp;&nbsp;&nbsp;exceptions that could be replaced by branches due to inlining</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">ICMissHistogram</td>
    <td class="tg-7fd7">produce&nbsp;&nbsp;&nbsp;histogram of IC misses</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintClassStatistics</td>
    <td class="tg-7fd7">prints&nbsp;&nbsp;&nbsp;class statistics at end of run</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintMethodStatistics</td>
    <td class="tg-7fd7">prints&nbsp;&nbsp;&nbsp;method statistics at end of run</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceOnStackReplacement</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;on stack replacement</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyJNIEnvThread</td>
    <td class="tg-7fd7">Verify&nbsp;&nbsp;&nbsp;JNIEnv.thread == Thread::current() when entering VM from JNI</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceTypeProfile</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;type profile</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">MemProfilingInterval</td>
    <td class="tg-7fd7">Time&nbsp;&nbsp;&nbsp;between each invocation of the MemProfiler</td>
    <td class="tg-7fd7">500</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">AssertRepeat</td>
    <td class="tg-7fd7">number&nbsp;&nbsp;&nbsp;of times to evaluate expression in assert (to estimate overhead); only works&nbsp;&nbsp;&nbsp;with -DUSE_REPEATED_ASSERTS</td>
    <td class="tg-7fd7">1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">SuppressErrorAt</td>
    <td class="tg-7fd7">List&nbsp;&nbsp;&nbsp;of assertions (file:line) to muzzle</td>
    <td class="tg-7fd7">""</td>
    <td class="tg-7fd7">ccstr</td>
  </tr>
  <tr>
    <td class="tg-elk0">HandleAllocationLimit</td>
    <td class="tg-7fd7">Threshold&nbsp;&nbsp;&nbsp;for HandleMark allocation when +TraceHandleAllocation is used</td>
    <td class="tg-7fd7">1024</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MaxElementPrintSize</td>
    <td class="tg-7fd7">maximum&nbsp;&nbsp;&nbsp;number of elements to print</td>
    <td class="tg-7fd7">256</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MaxSubklassPrintSize</td>
    <td class="tg-7fd7">maximum&nbsp;&nbsp;&nbsp;number of subklasses to print when printing klass</td>
    <td class="tg-7fd7">4</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">ScavengeALotInterval</td>
    <td class="tg-7fd7">Interval&nbsp;&nbsp;&nbsp;between which scavenge will occur with +ScavengeALot</td>
    <td class="tg-7fd7">1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">FullGCALotInterval</td>
    <td class="tg-7fd7">Interval&nbsp;&nbsp;&nbsp;between which full gc will occur with +FullGCALot</td>
    <td class="tg-7fd7">1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">FullGCALotStart</td>
    <td class="tg-7fd7">For&nbsp;&nbsp;&nbsp;which invocation to start FullGCAlot</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">FullGCALotDummies</td>
    <td class="tg-7fd7">Dummy&nbsp;&nbsp;&nbsp;object allocated with +FullGCALot, forcing all objects to move</td>
    <td class="tg-7fd7">32*K</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">DeoptimizeALotInterval</td>
    <td class="tg-7fd7">Number&nbsp;&nbsp;&nbsp;of exits until DeoptimizeALot kicks in</td>
    <td class="tg-7fd7">5</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">ZombieALotInterval</td>
    <td class="tg-7fd7">Number&nbsp;&nbsp;&nbsp;of exits until ZombieALot kicks in</td>
    <td class="tg-7fd7">5</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">ExitOnFullCodeCache</td>
    <td class="tg-7fd7">Exit&nbsp;&nbsp;&nbsp;the VM if we fill the code cache.</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CompileTheWorldStartAt</td>
    <td class="tg-7fd7">First&nbsp;&nbsp;&nbsp;class to consider when using +CompileTheWorld</td>
    <td class="tg-7fd7">1</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">CompileTheWorldStopAt</td>
    <td class="tg-7fd7">Last&nbsp;&nbsp;&nbsp;class to consider when using +CompileTheWorld</td>
    <td class="tg-7fd7">max_jint</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-vp9j" colspan="4"><a href="https://stas-blogspot.blogspot.com/2011/07/most-complete-list-of-xx-options-for.html">diagnostic</a></td>
  </tr>
  <tr>
    <td class="tg-elk0">PrintFlagsFinal</td>
    <td class="tg-7fd7">Prints&nbsp;&nbsp;&nbsp;list of all available java paramenters. Information is displayed in 4&nbsp;&nbsp;&nbsp;columns. First one is the type of parameter, second is parameter name, third&nbsp;&nbsp;&nbsp;is default value and the fourth is the type of the flag, i.e. product,&nbsp;&nbsp;&nbsp;diagnostic, C1 product (only for client JVM), C2 product (only for server&nbsp;&nbsp;&nbsp;JVM), etc. Available since 1.6.</td>
    <td class="tg-7fd7">　</td>
    <td class="tg-7fd7">　</td>
  </tr>
  <tr>
    <td class="tg-elk0">UnlockDiagnosticVMOptions</td>
    <td class="tg-7fd7">Enable&nbsp;&nbsp;&nbsp;processing of flags relating to field diagnostics</td>
    <td class="tg-7fd7">trueInDebug</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">LogCompilation</td>
    <td class="tg-7fd7">Log&nbsp;&nbsp;&nbsp;compilation activity in detail to hotspot.log or LogFile</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UnsyncloadClass</td>
    <td class="tg-7fd7">Unstable:&nbsp;&nbsp;&nbsp;VM calls loadClass unsynchronized. Custom classloader must call VM&nbsp;&nbsp;&nbsp;synchronized for findClass &amp; defineClass</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">FLSVerifyAllHeapReferences</td>
    <td class="tg-7fd7">Verify&nbsp;&nbsp;&nbsp;that all refs across the FLS boundary are to valid objects</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">FLSVerifyLists</td>
    <td class="tg-7fd7">Do&nbsp;&nbsp;&nbsp;lots of (expensive) FreeListSpace verification</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">FLSVerifyIndexTable</td>
    <td class="tg-7fd7">Do&nbsp;&nbsp;&nbsp;lots of (expensive) FLS index table verification</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyBeforeExit</td>
    <td class="tg-7fd7">Verify&nbsp;&nbsp;&nbsp;system before exiting</td>
    <td class="tg-7fd7">trueInDebug</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyBeforeGC</td>
    <td class="tg-7fd7">Verify&nbsp;&nbsp;&nbsp;memory system before GC</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyAfterGC</td>
    <td class="tg-7fd7">Verify&nbsp;&nbsp;&nbsp;memory system after GC</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyDuringGC</td>
    <td class="tg-7fd7">Verify&nbsp;&nbsp;&nbsp;memory system during GC (between phases)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyRememberedSets</td>
    <td class="tg-7fd7">Verify&nbsp;&nbsp;&nbsp;GC remembered sets</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyObjectStartArray</td>
    <td class="tg-7fd7">Verify&nbsp;&nbsp;&nbsp;GC object start array if verify before/after</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">BindCMSThreadToCPU</td>
    <td class="tg-7fd7">Bind&nbsp;&nbsp;&nbsp;CMS Thread to CPU if possible</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">CPUForCMSThread</td>
    <td class="tg-7fd7">When&nbsp;&nbsp;&nbsp;BindCMSThreadToCPU is true, the CPU to bind CMS thread to</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">TraceJVMTIObjectTagging</td>
    <td class="tg-7fd7">Trace&nbsp;&nbsp;&nbsp;JVMTI object tagging calls</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyBeforeIteration</td>
    <td class="tg-7fd7">Verify&nbsp;&nbsp;&nbsp;memory system before JVMTI iteration</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">DebugNonSafepoints</td>
    <td class="tg-7fd7">Generate&nbsp;&nbsp;&nbsp;extra debugging info for non-safepoints in nmethods</td>
    <td class="tg-7fd7">trueInDebug</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">SerializeVMOutput</td>
    <td class="tg-7fd7">Use&nbsp;&nbsp;&nbsp;a mutex to serialize output to tty and hotspot.log</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">DisplayVMOutput</td>
    <td class="tg-7fd7">Display&nbsp;&nbsp;&nbsp;all VM output on the tty, independently of LogVMOutput</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">LogVMOutput</td>
    <td class="tg-7fd7">Save&nbsp;&nbsp;&nbsp;VM output to hotspot.log, or to LogFile</td>
    <td class="tg-7fd7">trueInDebug</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">LogFile</td>
    <td class="tg-7fd7">If&nbsp;&nbsp;&nbsp;LogVMOutput is on, save VM output to this file [hotspot.log]</td>
    <td class="tg-7fd7">""</td>
    <td class="tg-7fd7">ccstr</td>
  </tr>
  <tr>
    <td class="tg-elk0">MallocVerifyInterval</td>
    <td class="tg-7fd7">if&nbsp;&nbsp;&nbsp;non-zero, verify C heap after every N calls to malloc/realloc/free</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">MallocVerifyStart</td>
    <td class="tg-7fd7">if&nbsp;&nbsp;&nbsp;non-zero, start verifying C heap after Nth call to malloc/realloc/free</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyGCStartAt</td>
    <td class="tg-7fd7">GC&nbsp;&nbsp;&nbsp;invoke count where +VerifyBefore/AfterGC kicks in</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">uintx</td>
  </tr>
  <tr>
    <td class="tg-elk0">VerifyGCLevel</td>
    <td class="tg-7fd7">Generation&nbsp;&nbsp;&nbsp;level at which to start +VerifyBefore/AfterGC</td>
    <td class="tg-7fd7">0</td>
    <td class="tg-7fd7">intx</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseNewCode</td>
    <td class="tg-7fd7">Testing&nbsp;&nbsp;&nbsp;Only: Use the new version while testing</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseNewCode2</td>
    <td class="tg-7fd7">Testing&nbsp;&nbsp;&nbsp;Only: Use the new version while testing</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">UseNewCode3</td>
    <td class="tg-7fd7">Testing&nbsp;&nbsp;&nbsp;Only: Use the new version while testing</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">SharedOptimizeColdStart</td>
    <td class="tg-7fd7">At&nbsp;&nbsp;&nbsp;dump time, order shared objects to achieve better cold startup time.</td>
    <td class="tg-7fd7">TRUE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">SharedSkipVerify</td>
    <td class="tg-7fd7">Skip&nbsp;&nbsp;&nbsp;assert() and verify() which page-in unwanted shared objects.</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PauseAtStartup</td>
    <td class="tg-7fd7">Causes&nbsp;&nbsp;&nbsp;the VM to pause at startup time and wait for the pause file to be removed&nbsp;&nbsp;&nbsp;(default: ./vm.paused.)</td>
    <td class="tg-7fd7">FALSE</td>
    <td class="tg-7fd7">bool</td>
  </tr>
  <tr>
    <td class="tg-elk0">PauseAtStartupFile</td>
    <td class="tg-7fd7">The&nbsp;&nbsp;&nbsp;file to create and for whose removal to await when pausing at startup.&nbsp;&nbsp;&nbsp;(default: ./vm.paused.)</td>
    <td class="tg-7fd7">""</td>
    <td class="tg-7fd7">ccstr</td>
  </tr>
</tbody>
</table>

## References

- [The most complete list of -XX options for Java JVM](https://stas-blogspot.blogspot.com/2011/07/most-complete-list-of-xx-options-for.html)
- [The most complete list of -XX options for Java JVM](https://wujc.cn/archives/92)