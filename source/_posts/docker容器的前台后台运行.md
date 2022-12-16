---
title: docker容器的前台后台运行
categories: 系统环境
date: 2022-08-22 21:15:40
tags:
- docker
---

## 容器运行时的 -dit 选项

docker run 命令的选项

```shell {.line-numbers}
--attach , -a 		Attach to STDIN, STDOUT or STDERR
--detach , -d 		Run container in background and print container ID
--interactive , -i 	Keep STDIN open even if not attached
--tty , -t 		    Allocate a pseudo-TTY
```

docker exec 命令

```shell {.line-numbers}
-d, --detach               Detached mode: run command in the background
-i, --interactive          Keep STDIN open even if not attached
-t, --tty                  Allocate a pseudo-TTY

没有 -a --attach 选项
```

- -a 可以多次指定 ，比如 -a stdin -a stdout
- 不要同时使用 -t 和 -a stderr，因为 pty 本身的限制。

> Do not use the -t and -a stderr options together due to limitations in the pty implementation. All stderr in pty mode simply goes to stdout.

使用 bash:lastest 镜像，通过观察 /dev/fd/ 目录，查看容器控制台IO的打开关闭情况。

默认，dit组合是001，前台运行，无法输入，只能看到输出。
只有 -i 没有 -t，容器可以接受stdin的输入，也可以输出，但是通过管道，不是伪终端，是批处理模式，而不是交互模式。

默认：前台运行，stdout 和 stderr 转接出来，而stdin关了

默认 -d=false, -i=false, -t=false

默认 -d=false
-d=false时，默认-i=false，-t=false

dit:000

```shell {.line-numbers}
[work@cdh06 ~]$ docker run --rm  bash -c 'ls  -l /dev/fd/'
total 0
ls: /dev/fd/3: cannot read link: No such file or directory
lrwx------    1 root     root            64 Jun 22 09:11 0 -> /dev/null
l-wx------    1 root     root            64 Jun 22 09:11 1 -> pipe:[55404435]
l-wx------    1 root     root            64 Jun 22 09:11 2 -> pipe:[55404436]
lr-x------    1 root     root            64 Jun 22 09:11 3
[work@cdh06 ~]$ docker run --rm -d=false bash -c 'ls  -l /dev/fd/'
total 0
ls: /dev/fd/3: cannot read link: No such file or directory
lrwx------    1 root     root            64 Jun 22 09:11 0 -> /dev/null
l-wx------    1 root     root            64 Jun 22 09:11 1 -> pipe:[55409027]
l-wx------    1 root     root            64 Jun 22 09:11 2 -> pipe:[55409028]
lr-x------    1 root     root            64 Jun 22 09:11 3
```

此时，docker 使用了 -a STDERR -a STDOUT 选项。

## 前台 -t

dit: 001

```shell {.line-numbers}
$ docker run --rm -t bash -c 'ls  -l /dev/fd/'
total 0
lrwx------    1 root     root            64 Jun 22 10:14 0 -> /dev/pts/0
lrwx------    1 root     root            64 Jun 22 10:14 1 -> /dev/pts/0
lrwx------    1 root     root            64 Jun 22 10:14 2 -> /dev/pts/0
```

但是 stdin （/dev/fd/0）是得不到输入的。

## 前台 -i

dit:010

```shell {.line-numbers}
$ docker run --rm -i bash -c 'ls  -l /dev/fd/'
total 0
lr-x------    1 root     root            64 Jun 22 10:18 0 -> pipe:[55703397]
l-wx------    1 root     root            64 Jun 22 10:18 1 -> pipe:[55703398]
l-wx------    1 root     root            64 Jun 22 10:18 2 -> pipe:[55703399]
```

## 前台 -it

dit:011

```shell {.line-numbers}
$ docker run --rm -it bash -c 'ls  -l /dev/fd/'
total 0
lrwx------    1 root     root            64 Jun 22 10:19 0 -> /dev/pts/0
lrwx------    1 root     root            64 Jun 22 10:19 1 -> /dev/pts/0
lrwx------    1 root     root            64 Jun 22 10:19 2 -> /dev/pts/0
```

Q: -it 和 -t 没有看出来区别呀。
Ans: 有的。-i才能接收标准输入，前台运行时，只有-t没有-i，虽然会保持不退出，但无法输入任何命令和特殊字符，要退出，只有再开
一个窗口，docker rm -f 命令删除容器。

## detach模式

-d=true 时，默认 -i=false，-t=true

后台模式，执行docker run 命令是看不到任何标准输出的，需要借助docker logs 命令。

```shell {.line-numbers}
$ docker run --rm -dit bash -c 'echo hello'
689d972fb889adf9e62e2a003e7976827cf0405233ffdc30dc54a70aa7e67aaa
$ docker run --name demo -d bash -c 'echo hello' && docker logs demo && docker rm demo
4a9aeb1cfdf5686cdfba00512b83d3e2e4635d989332c60f13aa63940ef36940
hello
demo
```

```shell {.line-numbers}
# -d 模式
$ docker run --name demo -d bash -c 'ls  -l /dev/fd/' && docker logs demo && docker rm demo
5d137c240eab57296702faec3ba155402ca72ed99086573951c0d07269b84dd3
ls: /dev/fd/3: cannot read link: No such file or directory
total 0
lrwx------    1 root     root            64 Jun 22 10:48 0 -> /dev/null
l-wx------    1 root     root            64 Jun 22 10:48 1 -> pipe:[55834607]
l-wx------    1 root     root            64 Jun 22 10:48 2 -> pipe:[55834608]
lr-x------    1 root     root            64 Jun 22 10:48 3
demo

# -dit 模式
$ docker run --name demo -dit bash -c 'ls  -l /dev/fd/' && docker logs demo && docker rm demo
dda596f4c4edc1b8a720490b64bc9101bd17f97343075e5017efa69dab5ef9eb
total 0
lrwx------    1 root     root            64 Jun 22 10:49 0 -> /dev/pts/0
lrwx------    1 root     root            64 Jun 22 10:49 1 -> /dev/pts/0
lrwx------    1 root     root            64 Jun 22 10:49 2 -> /dev/pts/0
ls: /dev/fd/3: cannot read link: No such file or directory
lr-x------    1 root     root            64 Jun 22 10:49 3
demo
# -di
# ps: 其实，后台模式下，开启 STDIN 没有意义
$ docker run --name demo -di bash -c 'ls  -l /dev/fd/' && docker logs demo && docker rm demo
lr-x------    1 root     root            64 Jun 22 10:54 0 -> pipe:[55975007]
l-wx------    1 root     root            64 Jun 22 10:54 1 -> pipe:[55975008]
l-wx------    1 root     root            64 Jun 22 10:54 2 -> pipe:[55975009]
# -dt
$ docker run --name demo -dt bash -c 'ls  -l /dev/fd/' && docker logs demo && docker rm demo
lrwx------    1 root     root            64 Jun 22 10:58 0 -> /dev/pts/0
lrwx------    1 root     root            64 Jun 22 10:58 1 -> /dev/pts/0
lrwx------    1 root     root            64 Jun 22 10:58 2 -> /dev/pts/0
```

## 前后台切换

docker attach 命令可以把后台运行的容器挂到前台来。
如果容器运行时使用了 -it，那么可以使用 Ctrl-P Ctrl-Q 把容器重新放到后台，继续执行。
如果没有使用 -it，那么就只能使用 Ctrl-C 杀死容器才能退出。

## –attach

使用 -a stdin 之后，就进入detach模式，还得按下Ctrl-D才能返回。
这是因为不指定 -a，容器默认有 -a stdout 和 -a stderr，而指定了-a stdin，默认绑定就没了，没了默认绑定就只有进入后台了。

```shell {.line-numbers}
$ docker run -a stdin --name  demo bash
a642ce63d68c8ac8edca395b51004a2f7ee635a9ecbac4ca28f31d2a8d721fef
<Ctrl-D>
```

分析一下，借助 ls -l /dev/fd/ 查看文件描述符，借助 cat 读取标准输入。

```shell {.line-numbers}
# 容器的标准输入并没有打开，但外部确实看到好像标准输入能读取
$ docker run -a stdin --name  demo bash -c 'ls -l /dev/fd/; cat'
4465e310ef751b79245b598b09d35b149fc5ee85002fb97d24ddcfae53fe95b9
hello, world
<Ctrl-D>
[work@cdh06 ~]$ docker logs demo
total 0
lrwx------    1 root     root            64 Jun 22 11:26 0 -> /dev/null
l-wx------    1 root     root            64 Jun 22 11:26 1 -> pipe:[56065531]
l-wx------    1 root     root            64 Jun 22 11:26 2 -> pipe:[56065532]
lr-x------    1 root     root            64 Jun 22 11:26 3
ls: /dev/fd/3: cannot read link: No such file or directory

# 加上-i就通了。
$ docker rm -f demo
demo
[work@cdh06 ~]$ docker run -a stdin -i --name  demo bash -c 'ls -l /dev/fd/; cat'
28548534643ab2a6fde1ac7ef4393eca13e2671b95570a5ff898732f0f165fbf
hello
world
<Ctrl-D>

[work@cdh06 ~]$ docker logs demo
total 0
ls: /dev/fd/3: cannot read link: No such file or directory
lr-x------    1 root     root            64 Jun 22 11:27 0 -> pipe:[56069724]
l-wx------    1 root     root            64 Jun 22 11:27 1 -> pipe:[56069725]
l-wx------    1 root     root            64 Jun 22 11:27 2 -> pipe:[56069726]
lr-x------    1 root     root            64 Jun 22 11:27 3
hello
world

# -a stdout 和 -a stderr 指定至少一个，就不会进入后台
[work@cdh06 ~]$ docker run --rm -a stdout -a stderr bash -c 'ls -l /dev/fd/'
ls: /dev/fd/3: cannot read link: No such file or directory
total 0
lrwx------    1 root     root            64 Jun 22 11:49 0 -> /dev/null
l-wx------    1 root     root            64 Jun 22 11:49 1 -> pipe:[56124973]
l-wx------    1 root     root            64 Jun 22 11:49 2 -> pipe:[56124974]
lr-x------    1 root     root            64 Jun 22 11:49 3
[work@cdh06 ~]$ docker run --rm -a stdout  bash -c 'ls -l /dev/fd/'
total 0
lrwx------    1 root     root            64 Jun 22 11:49 0 -> /dev/null
l-wx------    1 root     root            64 Jun 22 11:49 1 -> pipe:[56128608]
l-wx------    1 root     root            64 Jun 22 11:49 2 -> pipe:[56128609]
lr-x------    1 root     root            64 Jun 22 11:49 3
[work@cdh06 ~]$ docker run --rm -a stderr  bash -c 'ls -l /dev/fd/'
ls: /dev/fd/3: cannot read link: No such file or directory
# 不论如何，stdout 和 stderr 的输出都可以通过logs没了查看
$ docker run --name demo -a stderr bash -c 'ls -l /dev/fd/'
ls: /dev/fd/3: cannot read link: No such file or directory
[work@cdh06 ~]$ docker logs demo
total 0
ls: /dev/fd/3: cannot read link: No such file or directory
lrwx------    1 root     root            64 Jun 22 11:54 0 -> /dev/null
l-wx------    1 root     root            64 Jun 22 11:54 1 -> pipe:[56138416]
l-wx------    1 root     root            64 Jun 22 11:54 2 -> pipe:[56138417]
lr-x------    1 root     root            64 Jun 22 11:54 3

# Extend：甚至，交互模式的容器，其标准IO也可以用 docker logs 命令查看
$ docker run -it --name demo bash
bash-5.1# echo hello
hello
bash-5.1#
exit
[work@cdh06 ~]$ docker logs demo
bash-5.1# echo hello
hello
bash-5.1#
exit
# 由此，有时候交互模式卡顿，可能是日志阻塞了交互，可以使用异步日志
docker run --rm -it --log-opt mode=non-blocking --log-opt max-buffer-size=10m bash
docker run --rm -it bash
```

## -i 和 -a

容器内的进程 P，docker 服务进程 D，命令行进程 S。
想要容器读取输入，必须做两点：

1. 使用 -i 选项，把 P 的 STDIN 打开，打开的STDIN的另一头在进程D中。
2. 使用 -a stdin 把 S 的标准输入对接到 P 的STDIN，通过 D 做中转。
3. -i 会默认启用 -a stdin；但 -a stdin 却不会自动启用 -i。

## 注：bash 镜像

使用 bash 镜像的时候，

```shell {.line-numbers}
docker run bash -c 'ls -l /dev/fd/'
```

完整的格式应该写成

```shell {.line-numbers}
docker run bash bash -c 'ls -l /dev/fd/'
```

```shell {.line-numbers}
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["bash"]
```

而 docker-engrypoint.sh 就这一点。

```shell {.line-numbers}
#!/usr/bin/env bash
set -Eeuo pipefail

# first arg is `-f` or `--some-option`
# or there are no args
if [ "$#" -eq 0 ] || [ "${1#-}" != "$1" ]; then
	# docker run bash -c 'echo hi'
	exec bash "$@"
fi

exec "$@"
```

当指定 -c 的时候，脚本会自动补上 bash。

注：本文转载自https://blog.csdn.net/chenxizhan1995/article/details/118116216