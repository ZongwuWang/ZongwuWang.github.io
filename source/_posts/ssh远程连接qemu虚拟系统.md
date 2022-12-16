---
title: ssh远程连接qemu虚拟系统
categories: 挖坑待填
password: www
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
date: 2022-08-03 01:29:44
tags:
---

最近在实现Aarch64程序调试时，需要使用qemu实现arm-v8平台的虚拟系统，但是即使使用图形界面也只能实现很低的分辨率，导致在qemu系统中调试gdb时，layout窗口显示的代码段过少。尝试使用sdl，vga，virtio，xql和vnc等各种手段，要么是平台不兼容，要么是不能够实现更高的分辨率。为此，记录一下qemu系统实现ssh远程连接的方案。

1. 运行qemu：

```shell {.line-numbers}
qemu-system-aarch64 -m 4096 -cpu cortex-a57 -smp 2 -M virt -bios QEMU_EFI.fd -nographic  -device virtio-scsi-device -drive if=none,file=ubuntuimg.img,format=raw,index=0,id=hd0 -device virtio-blk-device,drive=hd0 -fsdev local,security_model=passthrough,id=fsdev0,path=/data/wzw/qemu_    system/share -device virtio-9p-pci,fsdev=fsdev0,mount_tag=host_folder -device VGA,id=video0,vgamem_mb=256  -s -net user,hostfwd=tcp::10021-:22 -net nic
```

2. qemu系统中安装和启动ssh服务

```shell {.line-numbers}
# 查看ssh服务的状态
sudo service sshd status
# 安装ssh服务
sudo apt-get install openssh-server
# 开启ssh服务
sudo service sshd start
```

3. ssh访问qemu

```shell {.line-numbers}
ssh -p 10021 root@127.0.01
```

## Reference

- [ubuntu 如何使用ssh登录qemu开启的虚拟机？](https://blog.csdn.net/qq_34160841/article/details/104793441)