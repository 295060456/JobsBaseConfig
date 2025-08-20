#!/usr/bin/env zsh

# 一次性把全部子模块前移到各自跟踪分支的最新

# 终端执行目录转向目前脚本所在目录
script_path="$(cd "$(dirname "${BASH_SOURCE[0]:-${(%):-%x}}")" && pwd)"
cd "$script_path"

# 先将目前的改动，做一次提交，否则后续流程无法走通
git add .

# 初始化 & 同步
git submodule update --init --recursive
# 同步配置到 .git/config
git submodule sync --recursive

#（可选，提速）并发更新
# --jobs=<N> 是 Git 2.8+ 给 git submodule update 加的一个参数，用来 并发更新子模块
## --jobs=8 ：表示同时开 8 个并行任务 去处理子模块。
## --jobs=$(nproc)，number of processing units，返回当前机器可用的 逻辑 CPU 核心数。
## --jobs=$(sysctl -n hw.ncpu)，在 macOS / BSD 系统里，获取当前机器的 逻辑 CPU 核心数，sysctl 是 BSD/macOS 下的系统配置查询命令，-n 参数表示只输出数值，不带字段名。
# 什么时候不建议用 --jobs
## 子模块不多（比如就 1~2 个），加了也没意义。
## 网络或磁盘 IO 特别差时，太多并发反而会拖慢或者容易超时。
## Git 版本太老（2.7 以下），根本没有这个选项，会报错。
# 让全部子模块按“各自的 branch”前移
git submodule update --remote --merge --recursive --jobs=$(sysctl -n hw.ncpu)

# 提交父仓库里的“子模块指针变化”
git add .gitmodules $(git config -f .gitmodules --get-regexp '^submodule\..*\.path' | awk '{print $2}')
git commit -m "chore(submodule): bump all submodules to latest"
git push

git push
