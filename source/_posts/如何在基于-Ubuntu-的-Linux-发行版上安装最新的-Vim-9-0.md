---
title: 如何在基于 Ubuntu 的 Linux 发行版上安装最新的 Vim 9.0
categories: 系统环境
date: 2022-08-22 01:22:16
tags:
- vim
- vim9
- ubuntu
---

## 使用 PPA 在 Ubuntu 上安装 Vim 9

```shell {.line-numbers}
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install vim
```

## 降级或删除

```shell {.line-numbers}
sudo apt remove vim
sudo add-apt-repository -r ppa:jonathonf/vim
```

## Reference

1. https://itsfoss.com/install-latest-vim-ubuntu/
2. https://www.51cto.com/article/715747.html