---
title: Cheat sheet for Intel Processor Trace with Linux perf and gdb
categories: CPU性能分析
date: 2022-07-19 13:57:10
tags:
- perf
- 性能分析
- gdb
- intel_pt
- pt
- processor trace
---

## What is Processor Trace


Intel Processor Trace (PT) traces program execution (every branch) with low overhead.

This is a cheat sheet of how to use PT with perf for common tasks.

It is not a full introduction to PT. Please read [Adding PT to Linux perf](https://lwn.net/Articles/648154/) or the links from the general [PT reference page](http://halobates.de/blog/p/406).

## PT support in hardware

CPU	Support
Broadwell (5th generation Core, Xeon v4)	More overhead. No fine grained timing.
Skylake (6th generation Core, Xeon v5)	Fine grained timing. Address filtering.
Goldmont (Apollo Lake, Denverton)	Fine grained timing. Address filtering.

## PT support in Linux

PT is supported in Linux perf, which is integrated in the Linux kernel.
It can be used through the “perf” command or through gdb.

There are also other tools that support PT: [VTune](https://software.intel.com/en-us/intel-vtune-amplifier-xe), [simple-pt](https://github.com/andikleen/simple-pt), gdb, JTAG debuggers.

In general it is best to use the newest kernel and the newest Linux perf tools. If that is not possible older tools and kernels can be used. Newer tools can be used on an older kernel, but may not support all features


Linux version	Support
Linux 4.1	Initial PT driver
Linux 4.2	Support for Skylake and Goldmont
Linux 4.3	Initial user tools support in Linux perf
Linux 4.5	Support for JIT decoding using agent
Linux 4.6	Bug fixes. Support address filtering.
Linux 4.8	Bug fixes.
Linux 4.10	Bug fixes. Support for PTWRITE and power tracing

Many commands require recent perf tools, you may need to update them from a recent kernel tree.

This article covers mainly Linux perf and briefly gdb.

## Preparations


Only needed once.

Allow seeing kernel symbols (as root)

```shell {.line-numbers}
echo kernel.kptr_restrict=0' >> /etc/sysctl.conf
sysctl -p
```

## Basic perf command lines for recording PT

```shell {.line-numbers}
# Check if PT is supported and what capabilities.
ls /sys/devices/intel_pt/format
# Trace program
perf record -e intel_pt// program
# Trace whole system for 1 second
perf record -e intel_pt// -a sleep 1
# Trace CPU 0 for 1 second
perf record -C 0 -e intel_pt// -a sleep 1
# Trace already running program.
perf record --pid $(pidof program) -e intel_pt//
```

perf has to save the data to disk. The CPU can execute branches much faster than than the disk can keep up, so there will be some data loss for code that executes many instructions. perf has no way to slow down the CPU, so when trace bandwidth > disk bandwidth there will be gaps in the trace. Because of this it is usually not a good idea to try to save a long trace, but work with shorter traces. Long traces also take a lot of time to decode.

When decoding kernel data the decoder usually has to run as root.
An alternative is to use the perf-with-kcore.sh script included with perf.

```shell {.line-numbers}
# Record program execution and display function call graph.
perf script --ns --itrace=cr
```

perf script by defaults “samples” the data (only dumps a sample every 100us).
This can be configured using the –itrace option (see reference below)

Install [xed](https://github.com/intelxed/xed) first.

```shell {.line-numbers}
# Show every assembly instruction executed with disassembler.
perf script --itrace=i0ns --ns -F time,pid,comm,sym,symoff,insn,ip | xed -F insn: -S /proc/kallsyms -64
```

For this it is also useful to get more accurate time stamps (see below)

```shell {.line-numbers}
# Show source lines executed (requires debug information)
perf script --itrace=i0ns --ns -F time,sym,srcline,ip
# Often initialization code is not interesting. Skip initial 1M instructions while decoding
perf script --itrace=s1Mi0ns ....
# Slice trace into different time regions Generally the time stamps need to be looked up first in the trace, as they are absolute.
perf script --time 1.000,2.000 ...
# Print hot paths every 100us as call graph histograms
perf report --itrace=g32l64i100us --branch-history
# Install Flame graph tools first. Generate flame graph from execution, sampled every 100us
perf script --itrace=i100usg | stackcollapse-perf.pl > workload.folded
flamegraph.pl workloaded.folded > workload.svg
google-chrome workload.svg
```

## Other ways to record data

```shell {.line-numbers}
# Capture whole system for 1 second
perf record -a -e intel_pt// sleep 1
```

Use snapshot mode

This collects data, but does not continuously save it all to disk. When an event of interest happens a data dump of the current buffer can be triggered by sending a SIGUSR2 signal to the perf process.

```shell {.line-numbers}
perf record -a -e --snapshot intel_pt// sleep 1
PERF_PID=$!
*execute workload*


*event happens*
kill -USR2 $PERF_PID


*end of recording*
kill $PERF_PID>
```

```shell {.line-numbers}
# Record kernel only, complete system
perf record -a -e intel_pt//k sleep 1

# Record user space only, complete system
perf record -a -e intel_pt//u

# Enable fine grained timing (needs Skylake/Goldmont, adds more overhead)
perf record -a -e intel_pt/cyc=1,cyc_thresh=2/ ...

# Increase perf buffer to limit data loss
echo $[100*1024*1024] > /proc/sys/kernel/perf_event_mlock_kb
perf record -m 512,100000 -e intel_pt// ...

# Only record main function in program
perf record -e intel_pt// --filter 'filter main @ /path/to/program' ...

# Filter kernel code (needs 4.11+ kernel)
perf record -e intel_pt// -a --filter 'filter sys_write' program

# Stop tracing at func2.
perf record -e intel_pt// -a  --filter 'stop func2 @ program' program

# Transfer data to a trace on another system. May also require using perf-with-kcore.sh if decoding kernel.
perf archive
rsync -r ~/.debug perf.data other-system:
```

## Using gdb

Requires a new enough gdb built with libipt. For user space only.

```shell {.line-numbers}
gdb program
start
record btrace pt
cont

record instruction-history /m # show instructions
record function-history # show functions executed
prev # step backwards in time
```

For more information on gdb pt see the [gdb documentation](https://sourceware.org/gdb/onlinedocs/gdb/Process-Record-and-Replay.html)

## References

The [perf PT documentation](The perf PT documentation)

Reference for –itrace option (from perf documentation)

```shell {.line-numbers}
i synthesize "instructions" events
b synthesize "branches" events
x synthesize "transactions" events
c synthesize branches events (calls only)
r synthesize branches events (returns only)
e synthesize tracing error events
d create a debug log
g synthesize a call chain (use with i or x)
l synthesize last branch entries (use with i or x)
s skip initial number of events
```

Reference for –filter option (from perf documentation)

```shell {.line-numbers}
A hardware trace PMU advertises its ability to accept a number of
address filters by specifying a non-zero value in
/sys/bus/event_source/devices/ /nr_addr_filters.

Address filters have the format:

filter|start|stop|tracestop [/ ] [@]

Where:
- 'filter': defines a region that will be traced.
- 'start': defines an address at which tracing will begin.
- 'stop': defines an address at which tracing will stop.
- 'tracestop': defines a region in which tracing will stop.

is the name of the object file, is the offset to the
code to trace in that file, and is the size of the region to
trace. 'start' and 'stop' filters need not specify a .

If no object file is specified then the kernel is assumed, in which case
the start address must be a current kernel memory address.

can also be specified by providing the name of a symbol. If the
symbol name is not unique, it can be disambiguated by inserting #n where
'n' selects the n'th symbol in address order. Alternately #0, #g or #G
select only a global symbol. can also be specified by providing
the name of a symbol, in which case the size is calculated to the end
of that symbol. For 'filter' and 'tracestop' filters, if is
omitted and is a symbol, then the size is calculated to the end
of that symbol.

If is omitted and is '*', then the start and size will
be calculated from the first and last symbols, i.e. to trace the whole
file.
If symbol names (or '*') are provided, they must be surrounded by white
space.

The filter passed to the kernel is not necessarily the same as entered.
To see the filter that is passed, use the -v option.

The kernel may not be able to configure a trace region if it is not
within a single mapping. MMAP events (or /proc/ /maps) can be
examined to determine if that is a possibility.


Multiple filters can be separated with space or comma.
```

## Related

- [A primer on Processor Trace timing](http://halobates.de/blog/p/432)
- [Intel Processor Trace resources](http://halobates.de/blog/p/406)

> 本文转载自：http://halobates.de/blog/p/410