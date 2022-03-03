---
title: linux下迁移用户home下主目录
date: 2021-11-02 09:28:13
tags: 
- 系统环境
- Linux
categories: 系统环境
---

# linux下迁移用户home下主目录

迁移用户主目录命令： usermod -d /data0/home/mypic -m mypic

/data0/home/mypic 为目标目录  -m表示移动主目录  mypic为用户名

移动后用户mypic原本默认 对应/home/mypic的主目录将被移动到/data0/home/mypic。

查看/etc/passwd文件后发现主目录已经修改成功。

 

注意如果要修改创建用户时候默认主目录位置，可以修改/etc/default/useradd文件中Home的路径

如将#HOME=/home 修改为HOME=/data0/home 则后续创建用户时候默认主目录创建位置即在/data0/home下面

 

du -slh /data0/home/mypic 查看mypic目录占用空间

df -h 查看系统使用空间状况