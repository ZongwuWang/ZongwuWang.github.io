---
title: Linux Tools Mannual
date: 2021-07-22 13:47:27
tags:
---
# Linux 常用工具使用命令速查表

## tmux

### tmu常用操作指令及快捷键

1. 查看有所有tmux会话
   指令：tmux ls
   快捷键：Ctrl+b s
2. 新建tmux窗口
   指令：tmux new -s <session-name>
3. 重命名会话
   指令：tmux rename-session -t <old-name> <new-name>
   快捷键：Ctrl+b $
4. 分离会话
   指令：tmux detach/exit(关闭窗口，杀死会话)
   快捷键：Ctrl+b d
5. 平铺当前窗口
   快捷键：Ctrl+b z(再次Ctrl+b d恢复)
6. 杀死会话
   指令：tmux kill-session -t <session-name>
7. 切换会话
   指令：tmux switch -t <session-name>
8. 划分上下两个窗格
   指令：tmux split
   快捷键：Ctrl+b "
9.  划分左右两个窗格
   指令：tmux split -h
   快捷键：Ctrl+b %
10. 光标切换到上方窗格
   指令：tmux select-pane -U
   快捷键：Ctrl+b 方向键上
11. 光标切换到下方窗格
   指令：tmux select-pane -D
   快捷键：Ctrl+b 方向键下
12. 光标切换到左边窗格
   指令：tmux select-pane -L
   快捷键：Ctrl+b 方向键左
13. 光标钱换到右边窗格
   指令：tmux select-pane -R
   快捷键：Ctrl+b 方向键右

https://zhuanlan.zhihu.com/p/90464490
