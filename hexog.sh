##########################################################################
# File Name: hexog.sh
# Author: Wang Zongwu
# mail: wangzongwu@outlook.com
# Created Time: 2021年07月30日 星期五 19时57分28秒
# Description: 判断当前git分支是否为master，如果是则生成博客，并部署到github.io
#########################################################################
#!/bin/bash

get_branch=`git symbolic-ref --short -q HEAD`
echo git branch is $get_branch

if [ "$get_branch" == "master" ]
then
    hexo g
    hexo d
else
    echo "Please chechout to master branch before deploy"
    echo "Please chechout to master branch before deploy"
    echo "Please chechout to master branch before deploy"
    echo "重要的事情说三遍！！！"
fi
