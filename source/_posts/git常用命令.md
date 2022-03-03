---
title: git常用命令
password: www
abstract: 'Welcome to my blog, enter password to read.'
message: 'Welcome to my blog, enter password to read.'
date: 2022-02-22 15:35:11
tags:
categories:
---

- git init: 初始化一个Git仓库
- git add <file>: 把文件添加到仓库
- git commit: 把文件提交到仓库
- git status: 输出工作区的状态
- git diff: 查看修改内容
- git log <--pretty=oneline>: 显示从最近到最远的提交日志
- git reset --hard HEAD^: 回退到上一个版本，上一个版本就是HEAD^，上上一个版本就是HEAD^^，当然往上100个版本写100个^比较容易数不过来，所以写成HEAD~100
- git reset --hard 1094a: 指定回到未来的某个版本，版本号没必要写全，前几位就可以了，Git会自动去找。当然也不能只写前一两位，因为Git可能会找到多个版本号，就无法确定是哪一个了
- git reflog：记录你的每一次命令

![](./git常用命令/2022-02-22-15-46-05.png)

git add命令实际上就是把要提交的所有修改放到暂存区（Stage），然后，执行git commit就可以一次性把暂存区的所有修改提交到分支。

- git checkout -- <file>: 意思就是，把readme.txt文件在工作区的修改全部撤销，这里有两种情况：
  - 自修改后还没有被放到暂存区，现在，撤销修改就回到和版本库一模一样的状态；
  - 已经添加到暂存区后，又作了修改，现在，撤销修改就回到添加到暂存区后的状态。
总之，就是让这个文件回到最近一次git commit或git add时的状态。

- git reset HEAD <file>: 把暂存区的修改撤销掉（unstage），重新放回工作区
- git rm: 删除一个文件
  
由于远程库是空的，我们第一次推送master分支时，加上了-u参数，Git不但会把本地的master分支内容推送的远程新的master分支，还会把本地的master分支和远程的master分支关联起来，在以后的推送或者拉取时就可以简化命令。

- 删除远程库

如果添加的时候地址写错了，或者就是想删除远程库，可以用git remote rm <name>命令。使用前，建议先用git remote -v查看远程库信息：

```shell
$ git remote -v
origin  git@github.com:michaelliao/learn-git.git (fetch)
origin  git@github.com:michaelliao/learn-git.git (push)
```

然后，根据名字删除，比如删除origin：

```shell
$ git remote rm origin
```

此处的“删除”其实是解除了本地和远程的绑定关系，并不是物理上删除了远程库。远程库本身并没有任何改动。要真正删除远程库，需要登录到GitHub，在后台页面找到删除按钮再删除。

- 查看分支：git branch

- 创建分支：git branch <name>

- 切换分支：git checkout <name>或者git switch <name>

- 创建+切换分支：git checkout -b <name>或者git switch -c <name>

- 合并某分支到当前分支：git merge <name>

- 删除分支：git branch -d <name>

- 用git log --graph命令可以看到分支合并图

> 参考：https://www.liaoxuefeng.com/wiki/89604348802960