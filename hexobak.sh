##########################################################################
# File Name: hexobak.sh
# Author: Wang Zongwu
# mail: wangzongwu@outlook.com
# Created Time: 2021年07月30日 星期五 20时09分52秒
# Description: 判断当前git分支是否为hexo，如果是则备份博客到github hexo分支
#########################################################################
#!/bin/bash

get_branch=`git symbolic-ref --short -q HEAD`
echo git branch is $get_branch

if [ "$get_branch" == "hexo" ]
then
    git add *
    git commit -m "hexo backupdate"
    git push -u origin hexo
else
    echo "Please chechout to hexo branch before backup"
    echo "Please chechout to hexo branch before backup"
    echo "Please chechout to hexo branch before backup"
    echo "重要的事情说三遍！！！"
fi
