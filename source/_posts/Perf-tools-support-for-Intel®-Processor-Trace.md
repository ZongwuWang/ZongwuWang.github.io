---
title: Perf tools support for Intel® Processor Trace
categories: CPU性能分析
password: www
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
date: 2022-07-19 15:23:53
tags:
- perf
- 性能分析
- profiling
- intel_pt
- processor trace
---

这个网页介绍了最新版perf的安装以及于intel_pt的集成开发。安装时一定要安装所有依赖，否则容易发生找不到symbol的错误。此外，这个链接中介绍的是直接下载linux内核编译perf，我选择的是直接下载perf的最新源码，也没有什么问题。

## 1. Introduction

### 1.1 What is Intel® Processor Trace

Intel processors (Broadwell or newer, or Apollo Lake or newer) have a performance analysis and debugging feature called Intel® Processor Trace, or Intel® PT for short. Intel PT essentially provides **control flow tracing**, and you can get all the technical details in the Intel Processor Trace chapter in the Intel SDM (http://www.intel.com/sdm).

**Control flow tracing** is different from other kinds of performance analysis and debugging. It provides fine-grained information on branches taken in a program, but that means there can be a vast amount of trace data. Such an enormous amount of trace data creates a number of challenges, but it raises the central question: how to reduce the amount of trace data that needs to be captured. That inverts the way performance analysis is normally done. Instead of taking a test case and creating a trace of it, you need first to create a test case that is suitable for tracing.

#### 1.1.1 Reducing and handling the massive amount of trace data

Intel PT can potentially produce hundreds of megabytes of trace data per CPU per second. That can be at a faster rate than it can be recorded to file (resulting in trace data loss), and sometimes faster even than can be recording to memory (resulting in overflow packets).

perf tools support output to memory buffers. CPU overhead is low, but memory bandwidth consumption can be significant. perf tools do not support output of Intel PT to Intel® Trace Hub.

Here are some ways for reducing and handling the massive amount of trace data:

##### 1.1.1.1 Shorten the tracing time

Whereas statistical sampling can generally handle arbitrarily large test cases, to reduce the massive amount Intel PT trace data, test cases need to be created that provide a small representative set of operations to trace.

##### 1.1.1.2 Kernel-only tracing

Typically, the kernel does not do particularly CPU intensive operations, making it possible to trace for longer periods. Tracing the kernel-only can be useful for analyzing latencies.

##### 1.1.1.3 Snapshots

perf tools support the ability to make snapshots of Intel PT trace. A snapshot can be made at any time during recording by sending signal USR2 to perf. The snapshot size is configurable.

##### 1.1.1.4 Sampling

perf tools support adding Intel PT traces (up to 60 KiB per sample) onto samples of other events. The makes it possible, for example, to get extended call chains or branch stacks.

##### 1.1.1.5 Address filtering

perf tools support specifying Intel PT address filters, refer to the --filter option of [perf record](http://www.man7.org/linux/man-pages/man1/perf-record.1.html)

##### 1.1.1.6 Process only a fraction of the data collected

It is possible to decode only a fraction of a recorded trace by setting time ranges (--time option of perf script or perf report) or specifying CPUs (--cpu option of perf script or perf report).

#### 1.1.2 Intel PT in context

The following paragraphs provide some context for Intel PT:

##### 1.1.2.1 Intel PT vs Performance Counters

Normal performance analysis is done using performance counters and performance monitoring events. Counters can be used to provide overall statistics, which is what the perf stat tool does, or to provide statistical sampling which is what [perf record](https://perf.wiki.kernel.org/index.php/Tutorial#Sampling_with_perf_record) / [perf report](https://perf.wiki.kernel.org/index.php/Tutorial#Sample_analysis_with_perf_report) do.

There are lots and lots of different performance events, not to mention software events, probes and tracepoints.

By comparison, Intel PT fills a niche. People unfamiliar with normal performance analysis and debugging, perhaps should not start their learning with Intel PT.

##### 1.1.2.2 Intel PT vs Function Profiling

Function profiling records function entry and exit, but usually requires programs to be re-compiled for that purpose. It has the advantages of flexible filtering and sophisticated tools.

Intel PT can be used to provide a call trace without re-compiling a program, and can trace both user space and kernel space, but with the challenges of massive trace data described above.

##### 1.1.2.3 Intel PT vs Last Branch Record (LBR)

LBR can store branches, filtering different branch types, and providing finer timing than Intel PT. LBR can provide additional information that Intel PT does not, such as branch prediction "misses". Intel PT, however, can record significantly longer branch traces.

##### 1.1.2.4 Intel PT vs Branch Trace Store (BTS)

BTS could be considered the predecessor to Intel PT. It records taken branches and other changes in control flow such as interrupts and exceptions, but it has much greater overhead than Intel PT, and does not provide timing information.

#### 1.1.3 Intel PT miscellaneous abilities

Intel PT also has some miscellaneous abilities.

##### 1.1.3.1 Virtualization

Intel PT can trace through VM Entries / Exits, perf tools have support for tracing a host and guests, but kernel mode only. Refer [perf Intel PT man page](https://man7.org/linux/man-pages/man1/perf-intel-pt.1.html).

##### 1.1.3.2 Intel® Transactional Synchronization Extensions (Intel® TSX)

Intel PT traces transactions including aborted transactions. That is Intel PT will show the instructions in the incomplete transaction and the subsequent transaction abort.

##### 1.1.3.3 Power events and C-States

Some Intel Atom® processors support reporting C-state changes. All Intel PT implementations support reporting of CPU frequency changes.

##### 1.1.3.4 PEBS-via-PT

Some Intel Atom® processors support recording adaptive PEBS records into the Intel PT trace.

##### 1.1.3.5 PTWRITE

Hardware that supports it can write directly to the Intel PT trace using an instruction, 'ptwrite'.

### 1.2 Can I use Intel PT

Because Intel PT is a hardware feature, you need hardware that supports it, and also a Linux kernel that has support. Support was added to Linux in version 4.2 and nowadays, most Linux distributions have a kernel more recent than that, so the simple way to tell whether you can use Intel PT is to check whether the directory /sys/devices/intel_pt exists.

### 1.3 Intel PT man page

The online [perf Intel PT man page](http://www.man7.org/linux/man-pages/man1/perf-intel-pt.1.html) is not necessarily the latest version, but the source in the Linux repository is quite readable: ==[perf Intel PT man page source](http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/Documentation/perf-intel-pt.txt)==.

### 1.4 Other tools

It is not necessary to use perf to use Intel PT. Here are some other tools.

#### 1.4.1 GDB

Get Intel PT branch traces within the GNU Debugger [GDB](http://sourceware.org/gdb/current/onlinedocs/gdb/Process-Record-and-Replay.html#index-Intel-Processor-Trace)

Note GDB needs to be built with libipt (can be checked with "ldd `which gdb` | grep ipt"), unfortunately many are still not, but there is an Intel version of GDB in Intel® System Studio for linux.

#### 1.4.2 Fuzzers

Some feedback-driven fuzzers (such as [honggfuzz](http://honggfuzz.dev/)) utilize Intel PT.

#### 1.4.3 libipt

==[libipt](http://github.com/intel/libipt)== is an Intel® Processor Trace decoder library that lets you build your own tools.

#### 1.4.4 Intel® VTune™

[Intel® VTune™](http://software.intel.com/en-us/get-started-with-vtune-linux-os) Profiler for Linux

#### 1.4.5 SATT

[SATT Software Analyze Trace Tool](http://github.com/intel/satt) This tool requires building and installing a custom kernel module.

### 1.5 Other resources

- [Cheat sheet for Intel Processor Trace with Linux perf and gdb](http://halobates.de/blog/p/410)
- [perf Intel PT man page](http://www.man7.org/linux/man-pages/man1/perf-intel-pt.1.html) and [perf Intel PT man page source](http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/Documentation/perf-intel-pt.txt)
- [LWN article: Adding Processor Trace support to Linux](http://lwn.net/Articles/648154/)

## 2. Getting set up

perf tools are packaged based on the kernel version, which means the version of perf provided by Linux distributions is always quite old, whereas updates to Intel PT support are happening all the time. That means, for the latest Intel PT features, we really need to download and build that latest perf.

For other purposes, perf on modern Linux is usually fine.

### 2.1 Downloading and building the latest perf tools

The example below is for a Debian-based system, specifically Ubuntu 20.04 in this case, although there is a package list also for Fedora. We will need 4G of disk space.

git is needed:

```shell {.line-numbers}
$ sudo apt-get install git
```

perf is in the Linux source tree so get that:

```shell {.line-numbers}
$ cd
$ mkdir git
$ cd git
$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
```

Get the minimum tools to build it:

```shell {.line-numbers}
$ sudo apt-get install build-essential flex bison
```

It should be possible to build perf at this stage but it will be missing essential features. Add some more development libraries:

```shell {.line-numbers}
$ sudo apt-get install libelf-dev libnewt-dev libdw-dev libaudit-dev libiberty-dev libunwind-dev libcap-dev libzstd-dev libnuma-dev libssl-dev python3-dev python3-distutils binutils-dev gcc-multilib liblzma-dev
```

Aside: example packages for Fedora instead of Ubuntu:

```shell {.line-numbers}
sudo yum install flex bison gcc make elfutils-libelf-devel elfutils-devel libunwind-devel python-devel libcap-devel slang-devel binutils-devel numactl-devel openssl-devel
```

To build perf (with script bindings for python3 instead of python2) and put it in ~/bin/perf :

```shell {.line-numbers}
$ cd ~/git/linux
$ PYTHON=python3 make -C tools/perf install
```

To use ~/bin/perf, ~/bin must be in \$PATH. In Ubuntu, that is added automatically when a user logs in if the ~/bin directory exists (refer ~/.bashrc). If it is not in \$PATH, log out and in again. We can echo $PATH to check:

```shell {.line-numbers}
$ echo $PATH
/home/user/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
$ which perf
/home/user/bin/perf
```

#### 2.1.1 Permissions and limits

Typically regular userids do not have permission to trace the kernel or other processes. It is essential to understand [Perf Events and tool security](http://www.kernel.org/doc/html/latest/admin-guide/perf-security.html).

Intel PT benefits from large buffers which is controlled by the RLIMIT_MEMLOCK limit or the perf_event_mlock_kb setting or the CAP_IPC_LOCK capability. For kernel tracing with Intel PT, perf benefits from access to /proc/kcore.

The examples on this page use perf with extra privileges.

#### 2.1.2 Adding capabilities to perf

To give perf extra privileges (refer to [Perf Events and tool security](http://www.kernel.org/doc/html/latest/admin-guide/perf-security.html)), we can add capabilities to the perf executable. Note these capabilities are not inherited by programs started by perf.

First, we can create a new group and add ourself. This only needs to be done once.

```shell {.line-numbers}
$ sudo groupadd perf_users
$ sudo usermod -a -G perf_users $(whoami)
```

We will need to logout and login again to pick up the new _perf_users_ group.

Now we can add capabilities, making perf executable by only _root_ and _perf_users_.

```shell {.line-numbers}
$ sudo chown root ~/bin/perf
$ sudo chgrp perf_users ~/bin/perf
$ sudo chmod 550 ~/bin/perf
$ sudo setcap "cap_ipc_lock,cap_sys_ptrace,cap_sys_admin,cap_syslog=ep" ~/bin/perf
$ getcap ~/bin/perf
~/bin/perf = cap_ipc_lock,cap_sys_ptrace,cap_sys_admin,cap_syslog+ep
```

When not using perf, we can remove the capabilities:

```shell {.line-numbers}
$ sudo setcap -r ~/bin/perf
```

### 2.2 Updating perf tools

To fetch and update the tools again in the future, we can do the following:

```shell {.line-numbers}
$ cd ~/git/linux
$ git pull
$ rm tools/perf/PERF-VERSION-FILE
$ make -C tools/perf install
```

### 2.3 Getting debug packages

Debug packages are necessary to map addresses to function names. Ubuntu provides -dbg and -dbgsym style packages, refer [Debug Symbol Packages - Ubuntu Wiki](http://wiki.ubuntu.com/Debug%20Symbol%20Packages).

## 3. Example: Tracing your own code : Hello World

Before we start, if we haven't done it already, we will need to install [Intel X86 Encoder Decoder (XED)](http://intelxed.github.io/).

这边注意XED可以编译安装到任意路径，然后将安装路径增加到\$PATH中即可，不污染系统安装路径。参考github中的安装模式，而不需要按照下面安装到/usr/local中

```shell {.line-numbers}
$ cd ~/git
$ git clone https://github.com/intelxed/mbuild.git mbuild
$ git clone https://github.com/intelxed/xed
$ cd xed
$ ./mfile.py --share
$ ./mfile.py examples
$ sudo ./mfile.py --prefix=/usr/local install
$ sudo ldconfig
$ find . -type f -name xed
./obj/wkit/examples/obj/xed
$ cp ./obj/wkit/examples/obj/xed /usr/local/bin
```

Then, we can start with a trivial "Hello World" program:

```shell {.line-numbers}
$ cat hello.c 
#include <stdio.h>

int main()
{
        printf("Hello World!\n");
        return 0;
}
```

We can compile it with debugging information:

```shell {.line-numbers}
$ gcc -g -o hello hello.c
```

We can use perf record with options:

- **-e** to select which events, i.e. the following:
- **intel_pt/cyc,noretcomp/u** to get Intel PT with cycle-accurate mode. We can add noretcomp to get a timing information at RET instructions.
- **--filter 'filter main @ ./hello'** specifies an address filter to trace only main()
- **./hello** is the workload.

We can display an instruction trace with source line information and source code:

```shell {.line-numbers}
$ perf script --insn-trace --xed -F+srcline,+srccode
           hello 20444 [003] 28111.955861407:      5635beeae149 main+0x0 (/home/ahunter/git/linux/hello)
  hello.c:4             nop %edi, %edx
|4        {
           hello 20444 [003] 28111.955861407:      5635beeae14d main+0x4 (/home/ahunter/git/linux/hello)
  hello.c:4             pushq  %rbp
           hello 20444 [003] 28111.955861407:      5635beeae14e main+0x5 (/home/ahunter/git/linux/hello)
  hello.c:4             mov %rsp, %rbp
           hello 20444 [003] 28111.955861407:      5635beeae151 main+0x8 (/home/ahunter/git/linux/hello)
  hello.c:5             leaq  0xeac(%rip), %rdi
|5              printf("Hello World!\n");
           hello 20444 [003] 28111.955861407:      5635beeae158 main+0xf (/home/ahunter/git/linux/hello)
  hello.c:5             callq  0xfffffffffffffef8
           hello 20444 [003] 28111.955902827:      5635beeae15d main+0x14 (/home/ahunter/git/linux/hello)
  hello.c:6             mov $0x0, %eax
|6              return 0;
           hello 20444 [003] 28111.955902827:      5635beeae162 main+0x19 (/home/ahunter/git/linux/hello)
  hello.c:7             popq  %rbp
|7        }
           hello 20444 [003] 28111.955902938:      5635beeae163 main+0x1a (/home/ahunter/git/linux/hello)
  hello.c:7             retq  
```

We can tidy that up a bit with awk:

```shell {.line-numbers}
$ perf script --insn-trace --xed -F-dso,+srcline,+srccode | awk '/hello / {printf("\n%-85s",$0)} /hello.c:/ {ln=$0;gsub("\t","  ",ln);printf("%-58s",ln)} /^\|/ {printf("%s",$0)}' 

           hello 20444 [003] 28111.955861407:      5635beeae149 main+0x0               hello.c:4     nop %edi, %edx                            |4        {
           hello 20444 [003] 28111.955861407:      5635beeae14d main+0x4               hello.c:4     pushq  %rbp                               
           hello 20444 [003] 28111.955861407:      5635beeae14e main+0x5               hello.c:4     mov %rsp, %rbp                            
           hello 20444 [003] 28111.955861407:      5635beeae151 main+0x8               hello.c:5     leaq  0xeac(%rip), %rdi                   |5               printf("Hello World!\n");
           hello 20444 [003] 28111.955861407:      5635beeae158 main+0xf               hello.c:5     callq  0xfffffffffffffef8                 
           hello 20444 [003] 28111.955902827:      5635beeae15d main+0x14              hello.c:6     mov $0x0, %eax                            |6               return 0;
           hello 20444 [003] 28111.955902827:      5635beeae162 main+0x19              hello.c:7     popq  %rbp                                |7        }
           hello 20444 [003] 28111.955902938:      5635beeae163 main+0x1a              hello.c:7     retq
```

在[Cheat sheet for Intel Processor Trace with Linux perf and gdb](http://halobates.de/blog/p/410)还提供了一种打印方案：

```shell {.line-numbers}
perf script --itrace=i0ns --ns -F time,pid,comm,sym,symoff,insn,ip | xed -F insn: -S /proc/kallsyms -64
```

## 4. Example: Tracing short-running commands

It is possible to trace short-running commands entirely. A very simple example is a trace of 'ls -l'.

First, we can get some debug symbols e.g.

```shell {.line-numbers}
$ find-dbgsym-packages `which ls`
coreutils-dbgsym libpcre2-8-0-dbgsym libselinux1-dbgsym
$ sudo apt-get install coreutils-dbgsym libpcre2-8-0-dbgsym libselinux1-dbgsym libc6-dbg
```

The trace is more interesting if we can drop all file system caches which will force the test case to do I/O instead of reading from a cache. For how to use /proc/sys/vm/drop_caches, refer to the /proc/sys/vm/drop_caches section in the manual page for [/proc](http://man7.org/linux/man-pages/man5/proc.5.html).

```shell {.line-numbers}
sudo bash -c 'echo 3 > /proc/sys/vm/drop_caches'
```

This example includes kernel tracing, which requires administrator privileges.

We can use perf record with options:

- **--kcore** to copy kernel object code from the /proc/kcore image (helps avoid decoding errors due to kernel self-modifying code)
- **-e** to select which events, i.e. the following:
- **intel_pt/cyc/** to get Intel PT with cycle-accurate mode
- **ls -l** is the workload to trace

```shell {.line-numbers}
$ sudo perf record --kcore -e intel_pt/cyc/ ls -l
total 832
drwxrwxr-x  27 user user   4096 Jun  2 11:11 arch
drwxrwxr-x   3 user user   4096 Jun  4 08:40 block
drwxrwxr-x   2 user user   4096 May 23 15:47 certs
-rw-rw-r--   1 user user    496 May 23 15:47 COPYING
-rw-rw-r--   1 user user  99752 Jun  2 11:11 CREDITS
drwxrwxr-x   4 user user   4096 Jun  2 11:11 crypto
drwxrwxr-x  79 user user   4096 Jun  4 08:40 Documentation
drwxrwxr-x 140 user user   4096 May 23 15:47 drivers
drwxrwxr-x  79 user user   4096 Jun  4 08:40 fs
drwxrwxr-x  10 user user   4096 Jun  4 08:39 heads
drwxrwxr-x   3 user user   4096 Jun  4 17:11 hold
drwxrwxr-x  30 user user   4096 Jun  2 12:37 include
drwxrwxr-x   2 user user   4096 Jun  4 08:40 init
drwxrwxr-x   2 user user   4096 Jun  4 08:40 ipc
-rw-rw-r--   1 user user   1327 May 23 15:47 Kbuild
-rw-rw-r--   1 user user    595 May 23 15:47 Kconfig
drwxrwxr-x  18 user user   4096 Jun  4 08:40 kernel
drwxrwxr-x  20 user user  12288 Jun  4 08:40 lib
drwxrwxr-x   6 user user   4096 May 23 15:47 LICENSES
-rw-rw-r--   1 user user 556326 Jun  4 08:40 MAINTAINERS
-rw-rw-r--   1 user user  61844 Jun  2 11:11 Makefile
drwxrwxr-x   3 user user   4096 Jun  4 08:40 mm
drwxrwxr-x  72 user user   4096 Jun  4 08:40 net
drwx------   3 user user   4096 Jun  4 17:30 perf.data
-rw-rw-r--   1 user user    727 May 23 15:47 README
drwxrwxr-x  30 user user   4096 Jun  2 11:11 samples
drwxrwxr-x  16 user user   4096 Jun  4 08:40 scripts
drwxrwxr-x  13 user user   4096 Jun  4 08:40 security
drwxrwxr-x  26 user user   4096 May 23 15:47 sound
drwxrwxr-x  37 user user   4096 Jun  4 12:11 tools
drwxrwxr-x   3 user user   4096 May 23 15:47 usr
drwxrwxr-x   4 user user   4096 May 23 15:47 virt
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 1.041 MB perf.data ]
```

Rather than look at the trace directly, we will instead create a GUI call graph. To do that we will use 2 python scripts. The first, export-to-sqlite.py will export the trace data to a SQLite3 database. The second exported-sql-viewer.py will create a GUI call graph.

We can install support for the script export-to-sqlite.py, using python3 (remember we built perf with python3 support not python2) as follows:

```shell {.line-numbers}
sudo apt-get install sqlite3 python3-pyside2.qtsql libqt5sql5-psql
```

Refer to the script [export-to-sqlite.py](http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/scripts/python/export-to-sqlite.py) for more information.

Then we can perform the export:

```shell {.line-numbers}
$ perf script --itrace=bep -s ~/libexec/perf-core/scripts/python/export-to-sqlite.py ls-example.db branches calls
2020-06-04 17:30:59.646366 Creating database ...
2020-06-04 17:30:59.656860 Writing records...
2020-06-04 17:31:21.215702 Adding indexes
2020-06-04 17:31:21.408810 Dropping unused tables
2020-06-04 17:31:21.427048 Done
```

We can install support for the script exported-sql-viewer.py, using python3 (remember we built perf with python3 support not python2) as follows:

```shell {.line-numbers}
$ sudo apt-get install python3-pyside2.qtcore python3-pyside2.qtgui python3-pyside2.qtsql python3-pyside2.qtwidgets
```

We can see the call graph, running the script as below, and selecting 'Reports' then 'Context-Sensitive Call Graph'

```shell {.line-numbers}
$ python3 ~/libexec/perf-core/scripts/python/exported-sql-viewer.py ls-example.db
```

We can drill down the trace to see where most of the time is spent. In this case, waiting on I/O in the lstat system call.

```shell {.line-numbers}
Call Path                                                                         Object         Count   Time (ns)   Time (%)   Insn Cnt   Insn Cnt (%)   Cyc Cnt   Cyc Cnt (%)    IPC   Branch Count   Branch Count (%)
▶ perf
▼ ls
  ▼ 41672:41672
    ▶ setup_new_exec                                                              [kernel]           1         290        0.0        727            0.0      1230           0.0   0.59             68                0.0
    ▶ native_sched_clock                                                          [kernel]           1           0        0.0          0            0.0         0           0.0      0              1                0.0
    ▶ sched_clock                                                                 [kernel]           1           0        0.0          0            0.0         0           0.0      0              1                0.0
    ▶ sched_clock_cpu                                                             [kernel]           1           0        0.0          0            0.0         0           0.0      0              1                0.0
    ▶ local_clock                                                                 [kernel]           1           0        0.0         48            0.0        49           0.0   0.98              1                0.0
    ▶ __perf_event_header__init_id.isra.0                                         [kernel]           1           1        0.0         21            0.0         5           0.0   4.20              3                0.0
    ▶ perf_event_comm_output                                                      [kernel]           1         123        0.0        506            0.0       517           0.0   0.98             73                0.0
    ▶ perf_iterate_ctx                                                            [kernel]           1          65        0.0        199            0.0       273           0.0   0.73             23                0.0
    ▶ perf_iterate_sb                                                             [kernel]           1           0        0.0          7            0.0         3           0.0   2.33              1                0.0
    ▶ perf_event_comm                                                             [kernel]           1           0        0.0          9            0.0         8           0.0   1.13              1                0.0
    ▶ __set_task_comm                                                             [kernel]           1           0        0.0          7            0.0         2           0.0   3.50              1                0.0
    ▶ load_elf_binary                                                             [kernel]           1      454912        2.3     143405            1.6    255719           2.5   0.56          16318                1.6
    ▶ search_binary_handler                                                       [kernel]           1          11        0.0         28            0.0        46           0.0   0.61              6                0.0
    ▶ __do_execve_file.isra.0                                                     [kernel]           1         554        0.0        357            0.0      2319           0.0   0.15             38                0.0
    ▶ __x64_sys_execve                                                            [kernel]           1           0        0.0          6            0.0        17           0.0   0.35              1                0.0
    ▶ do_syscall_64                                                               [kernel]           1        5635        0.0       3227            0.0     23637           0.2   0.14            438                0.0
    ▶ entry_SYSCALL_64_after_hwframe                                              [kernel]           1         217        0.0         48            0.0       906           0.0   0.05              4                0.0
    ▼ _start                                                                      ld-2.31.so         1    19015524       97.6    8862084           98.4   9861482          97.2   0.90         980661               98.3
      ▶ page_fault                                                                [kernel]           1        3259        0.0       5925            0.1     13626           0.1   0.43            510                0.1
      ▶ _dl_start                                                                 ld-2.31.so         1      956115        5.0     915528           10.3   1665766          16.9   0.55          94430                9.6
      ▶ _dl_init                                                                  ld-2.31.so         1      298497        1.6     283430            3.2    600916           6.1   0.47          28996                3.0
      ▼ _start                                                                    ls                 1    17757387       93.4    7657198           86.4   7580061          76.9   1.01         856721               87.4
        ▶ page_fault                                                              [kernel]           1        2073        0.0       7214            0.1      8685           0.1   0.83            566                0.1
        ▼ __libc_start_main                                                       libc-2.31.so       1    17754971      100.0    7649972           99.9   7569935          99.9   1.01         856153               99.9
          ▶ __cxa_atexit                                                          libc-2.31.so       1        1836        0.0       5944            0.1      7699           0.1   0.77            503                0.1
          ▶ __libc_csu_init                                                       ls                 1        3685        0.0      12103            0.2     15466           0.2   0.78            971                0.1
          ▶ _setjmp                                                               libc-2.31.so       1         176        0.0         32            0.0       797           0.0   0.04              4                0.0
          ▼ main                                                                  ls                 1    17584228       99.0    7263996           95.0   7282964          96.2   1.00         815563               95.3
            ▶ set_program_name                                                    ls                 1        1980        0.0       2590            0.0      8318           0.1   0.31            306                0.0
            ▶ unknown                                                             ls                 1       79537        0.5     219668            3.0    332415           4.6   0.66          24704                3.0
            ▶ unknown                                                             ls                 1         446        0.0        297            0.0      1866           0.0   0.16             35                0.0
            ▶ unknown                                                             ls                 1         199        0.0        449            0.0       831           0.0   0.54             47                0.0
            ▶ atexit                                                              ls                 1          80        0.0          9            0.0       122           0.0   0.07              8                0.0
            ▶ unknown                                                             ls                 1        3420        0.0        829            0.0     14809           0.2   0.06            105                0.0
            ▶ set_quoting_style                                                   ls                 1           0        0.0          0            0.0         0           0.0      0              1                0.0
            ▶ unknown                                                             ls                 7        1023        0.0       3125            0.0      4292           0.1   0.73            501                0.1
            ▶ unknown                                                             ls                 1         512        0.0        488            0.0      2134           0.0   0.23             60                0.0
            ▶ unknown                                                             ls                 2        3091        0.0       6780            0.1     12494           0.2   0.54            642                0.1
            ▶ human_options                                                       ls                 1         445        0.0       1325            0.0      1868           0.0   0.71            217                0.0
            ▶ get_quoting_style                                                   ls                 1           0        0.0          0            0.0         0           0.0      0              1                0.0
            ▶ clone_quoting_options                                               ls                 2         444        0.0        548            0.0      1862           0.0   0.29             58                0.0
            ▶ set_char_quoting                                                    ls                 1           0        0.0          0            0.0         0           0.0      0              1                0.0
            ▶ argmatch                                                            ls                 1         360        0.0        211            0.0      1489           0.0   0.14             28                0.0
            ▶ hard_locale                                                         ls                 1         135        0.0         85            0.0       664           0.0   0.13              8                0.0
            ▶ unknown                                                             ls                 2       14056        0.1      49612            0.7     58942           0.8   0.84           4687                0.6
            ▶ abformat_init                                                       ls                 1       11578        0.1      58235            0.8     48048           0.7   1.21           6651                0.8
            ▶ tzalloc                                                             ls                 1          62        0.0        224            0.0       255           0.0   0.88             19                0.0
            ▶ xmalloc                                                             ls                 1        1642        0.0       2187            0.0      6877           0.1   0.32            214                0.0
            ▶ clear_files                                                         ls                 1         107        0.0         22            0.0       450           0.0   0.05              2                0.0
            ▶ queue_directory                                                     ls                 1         184        0.0        453            0.0       773           0.0   0.59             65                0.0
            ▼ print_dir                                                           ls                 1    17464204       99.3    6916440           95.2   6782904          93.1   1.02         777118               95.3
              ▶ unknown                                                           ls                 1         121        0.0         39            0.0       509           0.0   0.08              2                0.0
              ▶ unknown                                                           ls                 1        5298        0.0      12006            0.2     22207           0.3   0.54           1169                0.2
              ▶ clear_files                                                       ls                 1           0        0.0          0            0.0         0           0.0      0              2                0.0
              ▶ unknown                                                           ls                43       19841        0.1      54011            0.8     81698           1.2   0.66           5943                0.8
              ▼ gobble_file.constprop.0                                           ls                32    10586230       60.6    4486659           64.9   4423411          65.2   1.01         496893               63.9
                ▶ needs_quoting                                                   ls                32        5639        0.1      17998            0.4     23544           0.5   0.76           2421                0.5
                ▶ unknown                                                         ls                96         732        0.0       2983            0.1      3359           0.1   0.89            290                0.1
                ▼ unknown                                                         ls                32     8836035       83.5    3477158           77.5   2937626          66.4   1.18         382210               76.9
                  ▼ __lxstat64                                                    libc-2.31.so      32     8835858      100.0    3475998          100.0   2935941          99.9   1.18         382178              100.0
                    ▼ entry_SYSCALL_64                                            [kernel]          32     8828726       99.9    3466363           99.7   2905440          99.0   1.19         380853               99.7
                      ▼ do_syscall_64                                             [kernel]          32     8825966      100.0    3464667          100.0   2894453          99.6   1.20         380757              100.0
                        ▼ __x64_sys_newlstat                                      [kernel]          32     8816599       99.9    3462903           99.9   2866632          99.0   1.21         380458               99.9
                          ▼ __do_sys_newlstat                                     [kernel]          32     8816391      100.0    3460695           99.9   2854386          99.6   1.21         380330              100.0
                            ▼ vfs_statx                                           [kernel]          32     8814939      100.0    3453687           99.8   2848318          99.8   1.21         379722               99.8
                              ▼ user_path_at_empty                                [kernel]          32     8806551       99.9    3436824           99.5   2816689          98.9   1.22         377734               99.5
                                ▶ getname_flags                                   [kernel]          32        3471        0.0      13785            0.4     16445           0.6   0.84           1542                0.4
                                ▼ filename_lookup                                 [kernel]          32     8803067      100.0    3422884           99.6   2800182          99.4   1.22         376096               99.6
                                  ▼ path_lookupat.isra.0                          [kernel]          32     8801121      100.0    3417967           99.9   2792250          99.7   1.22         375552               99.9
                                    ▶ path_init                                   [kernel]          32         603        0.0       3784            0.1      2854           0.1   1.33            192                0.1
                                    ▶ link_path_walk.part.0                       [kernel]          32         708        0.0       5794            0.2      3316           0.1   1.75            422                0.1
                                    ▼ walk_component                              [kernel]          32     8798631      100.0    3404427           99.6   2780753          99.6   1.22         374125               99.6
                                      ▶ lookup_fast                               [kernel]          32        4016        0.0       7158            0.2     16248           0.6   0.44            663                0.2
                                      ▼ lookup_slow                               [kernel]          31     8793533       99.9    3392561           99.7   2760139          99.3   1.23         372807               99.6
                                        ▶ down_read                               [kernel]          31         240        0.0       1009            0.0       499           0.0   2.02            186                0.0
                                        ▼ __lookup_slow                           [kernel]          31     8792986      100.0    3390994          100.0   2758348          99.9   1.23         372466               99.9
                                          ▶ d_alloc_parallel                      [kernel]          31        5966        0.1      13928            0.4     21691           0.8   0.64           1375                0.4
                                          ▼ ext4_lookup                           [kernel]          31     8786755       99.9    3376539           99.6   2736392          99.2   1.23         370998               99.6
                                            ▶ ext4_fname_prepare_lookup           [kernel]          31           0        0.0          0            0.0         0           0.0      0            124                0.0
                                            ▶ __ext4_find_entry                   [kernel]          31       11669        0.1      59063            1.7     49644           1.8   1.19           5687                1.5
                                            ▶ kfree                               [kernel]          62         426        0.0       1888            0.1      2724           0.1   0.69            124                0.0
                                            ▶ __brelse                            [kernel]          31         115        0.0        117            0.0       117           0.0   1.00             31                0.0
                                            ▼ __ext4_iget                         [kernel]          31     8770362       99.8    3301339           97.8   2663781          97.3   1.24         363327               97.9
                                              ▶ iget_locked                       [kernel]          31       12625        0.1      28525            0.9     54273           2.0   0.53           3083                0.8
                                              ▼ __ext4_get_inode_loc              [kernel]          31     8744348       99.7    3219494           97.5   2553678          95.9   1.26         353658               97.3
                                                ▶ ext4_get_group_desc             [kernel]          31         717        0.0       2139            0.1      3006           0.1   0.71             62                0.0
                                                ▶ ext4_inode_table                [kernel]          46          86        0.0          0            0.0         0           0.0      0             46                0.0
                                                ▶ __getblk_gfp                    [kernel]          31       23459        0.3      77443            2.4     98450           3.9   0.79           8842                2.5
                                                ▶ _cond_resched                   [kernel]          30          43        0.0         12            0.0        23           0.0   0.52            120                0.0
                                                ▶ blk_start_plug                  [kernel]          15           0        0.0          0            0.0         0           0.0      0             30                0.0
                                                ▶ ext4_itable_unused_count        [kernel]          15         198        0.0          0            0.0         0           0.0      0             15                0.0
                                                ▶ __breadahead                    [kernel]         474      505000        5.8    2835900           88.1   2111610          82.7   1.34         310764               87.9
                                                ▶ submit_bh                       [kernel]          15        4421        0.1      27069            0.8     18098           0.7   1.50           2720                0.8
                                                ▶ blk_finish_plug                 [kernel]          15       42049        0.5     172041            5.3    175937           6.9   0.98          16287                4.6
                                                ▼ __wait_on_buffer                [kernel]          15     8167641       93.4     102309            3.2    143500           5.6   0.71          13445                3.8
                                                  ▶ _cond_resched                 [kernel]          15         231        0.0        559            0.5      1122           0.8   0.50             60                0.4
                                                  ▼ out_of_line_wait_on_bit       [kernel]          15     8167384      100.0     101705           99.4    142275          99.1   0.71          13340               99.2
                                                    ▼ __wait_on_bit               [kernel]          15     8167361      100.0     101630           99.9    142183          99.9   0.71          13310               99.8
                                                      ▶ prepare_to_wait           [kernel]          15         812        0.0       1211            1.2      2828           2.0   0.43            105                0.8
                                                      ▼ bit_wait_io               [kernel]          15     8166063      100.0      99755           98.2    137321          96.6   0.73          13055               98.1
                                                        ▼ io_schedule             [kernel]          15     8165721      100.0      98826           99.1    135309          98.5   0.73          12980               99.4
                                                          ▶ io_schedule_prepare   [kernel]          15         461        0.0        375            0.4      1944           1.4   0.19             30                0.2
                                                          ▶ schedule              [kernel]          15     8165090      100.0      98301           99.5    132656          98.0   0.74          12905               99.4
                                                      ▶ finish_wait               [kernel]          15           0        0.0          0            0.0         0           0.0      0             45                0.3
                                              ▶ crypto_shash_update               [kernel]          62         966        0.0       6204            0.2     12343           0.5   0.50            620                0.2
                                              ▶ ext4_inode_csum.isra.0            [kernel]          31        3712        0.0      19437            0.6     15561           0.6   1.25           2697                0.7
                                              ▶ make_kuid                         [kernel]          31         467        0.0          0            0.0         0           0.0      0            186                0.1
                                              ▶ make_kgid                         [kernel]          31         186        0.0       4470            0.1      2661           0.1   1.68            186                0.1
                                              ▶ make_kprojid                      [kernel]          31         306        0.0       1343            0.0      1313           0.0   1.02            186                0.1
                                              ▶ set_nlink                         [kernel]          31         245        0.0       1017            0.0      1117           0.0   0.91             93                0.0
                                              ▶ ext4_set_inode_flags              [kernel]          31         568        0.0       2213            0.1      2181           0.1   1.01            124                0.0
                                              ▶ _raw_read_lock                    [kernel]          31         534        0.0         93            0.0       200           0.0   0.47             31                0.0
                                              ▶ ext4_ext_check_inode              [kernel]          31        2147        0.0       9174            0.3     12353           0.5   0.74            654                0.2
                                              ▶ __brelse                          [kernel]          31          73        0.0        557            0.0       670           0.0   0.83             31                0.0
                                              ▶ unlock_new_inode                  [kernel]          31         608        0.0       1339            0.0      1578           0.1   0.85            248                0.1
                                              ▶ ext4_set_aops                     [kernel]           7          95        0.0        384            0.0       397           0.0   0.97             21                0.0
                                            ▶ d_splice_alias                      [kernel]          31        3328        0.0      10072            0.3     12639           0.5   0.80           1178                0.3
                                        ▶ up_read                                 [kernel]          31         283        0.0          0            0.0         0           0.0      0             31                0.0
                                      ▶ follow_managed                            [kernel]          31           0        0.0          0            0.0         0           0.0      0             31                0.0
                                      ▶ dput                                      [kernel]          31         656        0.0       1890            0.1      2576           0.1   0.73            279                0.1
                                    ▶ complete_walk                               [kernel]          32         312        0.0        432            0.0      1605           0.1   0.27             77                0.0
                                    ▶ terminate_walk                              [kernel]          32         515        0.0       1170            0.0      2130           0.1   0.55            352                0.1
                                  ▶ restore_nameidata                             [kernel]          32         530        0.0        720            0.0      2693           0.1   0.27             96                0.0
                                  ▶ putname                                       [kernel]          32        1107        0.0        277            0.0       713           0.0   0.39            256                0.1
                              ▶ vfs_getattr                                       [kernel]          32        4552        0.1       7924            0.2     18723           0.7   0.42            853                0.2
                              ▶ path_put                                          [kernel]          32        3010        0.0       3250            0.1      5836           0.2   0.56           1007                0.3
                            ▶ cp_new_stat                                         [kernel]          32         740        0.0       5834            0.2      2933           0.1   1.99            512                0.1
                        ▶ fpregs_assert_state_consistent                          [kernel]          32         103        0.0        523            0.0       575           0.0   0.91             81                0.0
                        ▶ switch_fpu_return                                       [kernel]          15         422        0.0          0            0.0         0           0.0      0             45                0.0
                    ▶ irq_entries_start                                           [kernel]           1        6062        0.1       9283            0.3     25448           0.9   0.36           1260                0.3
                ▶ rpl_lgetfilecon                                                 ls                32       45398        0.4     105988            2.4    191418           4.3   0.55          12026                2.4
                ▶ unknown                                                         ls                32         257        0.0        288            0.0      1077           0.0   0.27             64                0.0
                ▶ file_has_acl                                                    ls                32       47974        0.5     154946            3.5    199782           4.5   0.78          17666                3.6
                ▶ human_readable                                                  ls                64        5859        0.1      17717            0.4     24550           0.6   0.72           1224                0.2
                ▶ gnu_mbswidth                                                    ls                96        2885        0.0      12761            0.3     12586           0.3   1.01           1776                0.4
                ▶ format_user_width                                               ls                32      511932        4.8     360256            8.0    669309          15.1   0.54          39985                8.0
                ▶ getgroup                                                        ls                32     1120258       10.6     313835            7.0    321667           7.3   0.98          35905                7.2
                ▶ umaxtostr                                                       ls                32         251        0.0        926            0.0       612           0.0   1.51             47                0.0
                ▶ xstrdup                                                         ls                32        2645        0.0       8339            0.2     11308           0.3   0.74            986                0.2
                ▶ page_fault                                                      [kernel]           2        2942        0.0       3786            0.1     12322           0.3   0.31            388                0.1
              ▶ process_signals                                                   ls                42         248        0.0        688            0.0      1285           0.0   0.54            126                0.0
              ▶ unknown                                                           ls                 1        3143        0.0       7469            0.1     13138           0.2   0.57            651                0.1
              ▶ sort_files                                                        ls                 1        9564        0.1      47816            0.7     40449           0.6   1.18           4631                0.6
              ▶ unknown                                                           ls                 1     4465654       25.6    1375195           19.9   1259338          18.6   1.09         155028               19.9
              ▶ unknown                                                           ls                 2        4339        0.0       1922            0.0      6816           0.1   0.28            182                0.0
              ▶ unknown                                                           ls                 2         122        0.0         61            0.0       290           0.0   0.21              6                0.0
              ▶ unknown                                                           ls                 2       11181        0.1       4541            0.1     17820           0.3   0.25            561                0.1
              ▶ human_readable                                                    ls                 1         641        0.0        258            0.0      1040           0.0   0.25             20                0.0
              ▶ print_current_files                                               ls                 1     2356845       13.5     925664           13.4    913979          13.5   1.01         111603               14.4
            ▶ unknown                                                             ls                 3         383        0.0        167            0.0       610           0.0   0.27             15                0.0
          ▶ exit                                                                  libc-2.31.so       1      164956        0.9     367844            4.8    262690           3.5   1.40          39106                4.6
```

## 5. Example: Tracing power events and CPU frequency

Intel PT can record changes in CPU frequency.

This example includes kernel tracing, which requires administrator privileges.

To trace power events, we can use perf record with options:

- **-a** to trace system wide i.e. all tasks, all CPUs
- **-e** to select which events, i.e. the following 2:
- **intel_pt/branch=0/** to get Intel PT but without control flow (branch) information
- **power:cpu_idle** to get the Intel CPU Idle driver tracepoint
- **sleep 1** is the workload. The tracing will stop when the workload finishes, so this is simply a way of tracing for about 1 second.

Note, although only 2 events have been selected, we could add anything else we are interested in.

```shell {.line-numbers}
$ sudo perf record -a -e intel_pt/branch=0/,power:cpu_idle sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.894 MB perf.data ]
```

To list the power events, use perf script with options:

- **--itrace=ep** to show errors (e) and power events (p)
- **-F-ip** to prevent showing the address i.e. instruction pointer (ip) register
- **--ns** to show the timestamp to nanoseconds instead of the default microseconds

The output shows the 10-character task command string, PID, CPU, timestamp, and event:

```shell {.line-numbers}
perf script --itrace=ep -F-ip --ns | head 
            perf  4355 [000] 11253.350232603:                cbr:  cbr: 42 freq: 4219 MHz (156%)    
         swapper     0 [000] 11253.350253949:     power:cpu_idle: state=6 cpu_id=0
            perf  4355 [001] 11253.350293104:                cbr:  cbr: 42 freq: 4219 MHz (156%)    
         swapper     0 [001] 11253.350311546:     power:cpu_idle: state=8 cpu_id=1
            perf  4355 [002] 11253.350350478:                cbr:  cbr: 42 freq: 4219 MHz (156%)    
         swapper     0 [002] 11253.350369240:     power:cpu_idle: state=8 cpu_id=2
            perf  4355 [003] 11253.350407645:                cbr:  cbr: 42 freq: 4219 MHz (156%)    
         swapper     0 [003] 11253.350424940:     power:cpu_idle: state=6 cpu_id=3
            perf  4355 [004] 11253.350464191:                cbr:  cbr: 42 freq: 4219 MHz (156%)    
         swapper     0 [004] 11253.350482739:     power:cpu_idle: state=8 cpu_id=4
```

To limit the output to a particular CPU, the -C option can be used e.g. for CPU 1

```shell {.line-numbers}
$ perf script --itrace=ep -F-ip --ns -C 1 | head 
            perf  4355 [001] 11253.350293104:                cbr:  cbr: 42 freq: 4219 MHz (156%)    
         swapper     0 [001] 11253.350311546:     power:cpu_idle: state=8 cpu_id=1
         swapper     0 [001] 11253.569359111:                cbr:  cbr: 26 freq: 2612 MHz ( 96%)    
         swapper     0 [001] 11253.569364879:     power:cpu_idle: state=4294967295 cpu_id=1
         swapper     0 [001] 11253.569424754:     power:cpu_idle: state=8 cpu_id=1
         swapper     0 [001] 11253.644214090:                cbr:  cbr: 23 freq: 2310 MHz ( 85%)    
         swapper     0 [001] 11253.644220472:     power:cpu_idle: state=4294967295 cpu_id=1
         konsole  2033 [001] 11253.644436892:                cbr:  cbr: 20 freq: 2009 MHz ( 74%)    
         swapper     0 [001] 11253.645046629:     power:cpu_idle: state=2 cpu_id=1
         swapper     0 [001] 11253.645074374:     power:cpu_idle: state=4294967295 cpu_id=1
```

To see some context, show context switch events (different trace to above):

```shell {.line-numbers}
$ perf script --itrace=ep -F-ip --ns -C 1 --show-switch-events | head -30
         swapper     0 [001] 15355.259304318: PERF_RECORD_SWITCH_CPU_WIDE OUT preempt  next pid/tid: 17393/17393
            perf 17393 [001] 15355.259305768: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:     0/0    
            perf 17393 [001] 15355.259311919:                psb:  psb offs: 0                      
            perf 17393 [001] 15355.259311919:                cbr:  cbr: 42 freq: 4219 MHz (156%)    
            perf 17393 [001] 15355.259322862: PERF_RECORD_SWITCH_CPU_WIDE OUT preempt  next pid/tid:    20/20   
     migration/1    20 [001] 15355.259323762: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid: 17393/17393
     migration/1    20 [001] 15355.259330003: PERF_RECORD_SWITCH_CPU_WIDE OUT          next pid/tid:     0/0    
         swapper     0 [001] 15355.259330401: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:    20/20   
         swapper     0 [001] 15355.259333457:     power:cpu_idle: state=8 cpu_id=1
         swapper     0 [001] 15355.349681141:                cbr:  cbr: 23 freq: 2310 MHz ( 85%)    
         swapper     0 [001] 15355.349687604:     power:cpu_idle: state=4294967295 cpu_id=1
         swapper     0 [001] 15355.349711470: PERF_RECORD_SWITCH_CPU_WIDE OUT preempt  next pid/tid: 15823/15823
         konsole 15823 [001] 15355.349714239: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:     0/0    
         konsole 15823 [001] 15355.349816414: PERF_RECORD_SWITCH_CPU_WIDE OUT          next pid/tid:     0/0    
         swapper     0 [001] 15355.349817827: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid: 15823/15823
         swapper     0 [001] 15355.349825977:     power:cpu_idle: state=8 cpu_id=1
         swapper     0 [001] 15355.390601064:                cbr:  cbr: 16 freq: 1607 MHz ( 59%)    
         swapper     0 [001] 15355.390608944:     power:cpu_idle: state=4294967295 cpu_id=1
         swapper     0 [001] 15355.390649821: PERF_RECORD_SWITCH_CPU_WIDE OUT preempt  next pid/tid: 11264/11264
 kworker/1:0-mm_ 11264 [001] 15355.390652189: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:     0/0    
 kworker/1:0-mm_ 11264 [001] 15355.390662452: PERF_RECORD_SWITCH_CPU_WIDE OUT          next pid/tid:     0/0    
         swapper     0 [001] 15355.390663434: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid: 11264/11264
         swapper     0 [001] 15355.390671955:     power:cpu_idle: state=8 cpu_id=1
         swapper     0 [001] 15355.422505769:     power:cpu_idle: state=4294967295 cpu_id=1
         swapper     0 [001] 15355.422538477: PERF_RECORD_SWITCH_CPU_WIDE OUT preempt  next pid/tid:    66/66   
      kcompactd0    66 [001] 15355.422541064: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:     0/0    
      kcompactd0    66 [001] 15355.422549431: PERF_RECORD_SWITCH_CPU_WIDE OUT          next pid/tid:     0/0    
         swapper     0 [001] 15355.422550337: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:    66/66   
         swapper     0 [001] 15355.422557517:     power:cpu_idle: state=8 cpu_id=1
         swapper     0 [001] 15355.456474916:                cbr:  cbr: 15 freq: 1507 MHz ( 56%)    
```

To see how to create a custom script refer to intel-pt-events.py (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/scripts/python/intel-pt-events.py)

To trace with virtual machines:

```shell {.line-numbers}
$ sudo ~/bin/perf record -a -e intel_pt/branch=0/,power:cpu_idle sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.764 MB perf.data ]
$ perf inject -i perf.data --vm-time-correlation=dry-run
ERROR: Unknown TSC Offset for VMCS 0x24bad0
VMCS: 0x25da39  TSC Offset 0xffffd5c7e6fbb0e0
VMCS: 0x24bad0  TSC Offset 0xffffd5c0fd708df0
VMCS: 0x1fd127  TSC Offset 0xffffd5c7e6fbb0e0
VMCS: 0x24bb7d  TSC Offset 0xffffd5c0fd708df0
VMCS: 0x2659c5  TSC Offset 0xffffd5c7e6fbb0e0
ERROR: Unknown TSC Offset for VMCS 0x25dbc1
VMCS: 0x25dbc1  TSC Offset 0xffffd5c0fd708df0
ERROR: Unknown TSC Offset for VMCS 0x213002
VMCS: 0x213002  TSC Offset 0xffffd5c0fd708df0
VMCS: 0x1fd374  TSC Offset 0xffffd5c7e6fbb0e0
$ perf inject -i perf.data --vm-time-correlation="dry-run 0xffffd5c7e6fbb0e0:0x25da39,0x1fd127,0x2659c5,0x1fd374 0xffffd5c0fd708df0:0x24bad0,0x24bb7d,0x25dbc1,0x213002"
$ perf inject -i perf.data --vm-time-correlation="0xffffd5c7e6fbb0e0:0x25da39,0x1fd127,0x2659c5,0x1fd374 0xffffd5c0fd708df0:0x24bad0,0x24bb7d,0x25dbc1,0x213002"
The input file would be updated in place, the --force option is required.
$ perf inject -i perf.data --vm-time-correlation="0xffffd5c7e6fbb0e0:0x25da39,0x1fd127,0x2659c5,0x1fd374 0xffffd5c0fd708df0:0x24bad0,0x24bb7d,0x25dbc1,0x213002" --force
$ perf script --itrace=ep -F-ip --ns --show-switch-events
...
   perf 18011 [004] 17398.037394927:                psb:  psb offs: 0                      
            perf 18011 [004] 17398.037394927:                cbr:  cbr: 42 freq: 4219 MHz (156%)    
            perf 18011 [004] 17398.037408451: PERF_RECORD_SWITCH_CPU_WIDE OUT preempt  next pid/tid:    38/38   
     migration/4    38 [004] 17398.037409609: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid: 18011/18011
       CPU 3/KVM 17819 [005] 17398.037417897: PERF_RECORD_SWITCH_CPU_WIDE OUT preempt  next pid/tid: 18011/18011
            perf 18011 [005] 17398.037421458: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid: 17809/17819
     migration/4    38 [004] 17398.037423366: PERF_RECORD_SWITCH_CPU_WIDE OUT          next pid/tid:     0/0    
         swapper     0 [004] 17398.037423908: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:    38/38   
         swapper     0 [004] 17398.037426640:     power:cpu_idle: state=6 cpu_id=4
            perf 18011 [005] 17398.037427626:                psb:  psb offs: 0                      
            perf 18011 [005] 17398.037427626:                cbr:  cbr: 42 freq: 4219 MHz (156%)    
            perf 18011 [005] 17398.037440808: PERF_RECORD_SWITCH_CPU_WIDE OUT preempt  next pid/tid:    44/44   
     migration/5    44 [005] 17398.037441699: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid: 18011/18011
     migration/5    44 [005] 17398.037446582: PERF_RECORD_SWITCH_CPU_WIDE OUT          next pid/tid: 17809/17819
       CPU 3/KVM 17819 [005] 17398.037448806: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:    44/44   
         swapper     0 [006] 17398.037483980: PERF_RECORD_SWITCH_CPU_WIDE OUT preempt  next pid/tid: 18011/18011
            perf 18011 [006] 17398.037485458: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:     0/0    
            perf 18011 [006] 17398.037491426:                psb:  psb offs: 0                      
            perf 18011 [006] 17398.037491426:                cbr:  cbr: 42 freq: 4219 MHz (156%)    
            perf 18011 [006] 17398.037502683: PERF_RECORD_SWITCH_CPU_WIDE OUT preempt  next pid/tid:    50/50   
     migration/6    50 [006] 17398.037503350: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid: 18011/18011
     migration/6    50 [006] 17398.037510565: PERF_RECORD_SWITCH_CPU_WIDE OUT          next pid/tid:     0/0    
         swapper     0 [006] 17398.037510908: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:    50/50   
         swapper     0 [006] 17398.037514870:     power:cpu_idle: state=8 cpu_id=6
       CPU 1/KVM 17817 [000] 17398.037533765:                cbr:  cbr: 41 freq: 4118 MHz (152%)    
       CPU 0/KVM 17816 [001] 17398.037533766:                cbr:  cbr: 41 freq: 4118 MHz (152%)    
       CPU 3/KVM 17819 [005] 17398.037533767:                cbr:  cbr: 41 freq: 4118 MHz (152%)    
         swapper     0 [006] 17398.037533829:                cbr:  cbr: 41 freq: 4118 MHz (152%)    
         swapper     0 [007] 17398.037541586: PERF_RECORD_SWITCH_CPU_WIDE OUT preempt  next pid/tid: 18011/18011
            perf 18011 [007] 17398.037544217: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:     0/0    
            perf 18011 [007] 17398.037550910:                psb:  psb offs: 0                      
            perf 18011 [007] 17398.037550910:                cbr:  cbr: 41 freq: 4118 MHz (152%)    
       CPU 1/KVM 17817 [000] 17398.037572496:                cbr:  cbr: 42 freq: 4219 MHz (156%)    
       CPU 0/KVM 17816 [001] 17398.037572496:                cbr:  cbr: 42 freq: 4219 MHz (156%)    
       CPU 3/KVM 17819 [005] 17398.037572498:                cbr:  cbr: 42 freq: 4219 MHz (156%)    
            perf 18011 [007] 17398.037572508:                cbr:  cbr: 42 freq: 4219 MHz (156%)    
       CPU 3/KVM 17819 [005] 17398.037644052:                cbr:  cbr: 41 freq: 4118 MHz (152%)    
       CPU 1/KVM 17817 [000] 17398.037644053:                cbr:  cbr: 41 freq: 4118 MHz (152%)    
       CPU 0/KVM 17816 [001] 17398.037644054:                cbr:  cbr: 41 freq: 4118 MHz (152%)    
            perf 18011 [007] 17398.037644064:                cbr:  cbr: 41 freq: 4118 MHz (152%)    
         swapper     0 [002] 17398.037646332:                cbr:  cbr: 41 freq: 4118 MHz (152%)    
         swapper     0 [002] 17398.037647762:     power:cpu_idle: state=4294967295 cpu_id=2
...
```

## 6. Example: Tracing the NMI handler

## 7. Example: Tracing __switch_to()

## 8. Example: Tracing GUI program kcalc

## 9. Example: Using SQL to analyze latencies

## 10. Example: Looking at Intel PT trace packets

## 11. Example: Detecting System Management Mode (SMM)

## 12. Example: rdtsc vs Intel PT

## 相关资料

- https://blog.cubieserver.de/publications/Henschel_Intel-PT_2017.pdf
- [Intel PT Micro Tutorial](https://sites.google.com/site/intelptmicrotutorial/references)

> 本文转载自：https://perf.wiki.kernel.org/index.php/Perf_tools_support_for_Intel%C2%AE_Processor_Trace#:~:text=perf%20tools%20support%20the%20ability%20to%20make%20snapshots,USR2%20to%20perf.%20The%20snapshot%20size%20is%20configurable.