#!/usr/bin/env zsh

# Git添加子模块

# 终端执行目录转向目前脚本所在目录
script_path="$(cd "$(dirname "${BASH_SOURCE[0]:-${(%):-%x}}")" && pwd)"
cd "$script_path"

# 该目录一定是Git管理的目录
git init
# 先将目前的改动，做一次提交，否则后续流程无法走通
git add .

# 查看Git状态，一定要保证暂存区干净
git status

# 添加Git子模块
git submodule add -b main https://github.com/295060456/JobsOCBaseConfigDemo          ./JobsBaseConfig@JobsOCBaseConfigDemo
git submodule add -b main https://github.com/295060456/JobsSwiftBaseConfigDemo       ./JobsBaseConfig@JobsSwiftBaseConfigDemo
git submodule add -b main https://github.com/295060456/JobsFlutterBaseConfigDemo     ./JobsBaseConfig@JobsFlutterBaseConfigDemo

# 同步子模块记录
git submodule sync

# 添加Git暂存区和提交日志
git add .gitmodules */ 
git commit -m "同步：JobsOCBaseConfigDemo/JobsSwiftBaseConfigDemo/JobsFlutterBaseConfigDemo"

# 首次拉取子模块内容（macOS）
git submodule update --init --recursive --jobs=$(sysctl -n hw.ncpu)

# 更新子模块工作区，使它们和父仓库记录的指针（commit hash）保持一致。
## --remote 👉 不仅仅是 checkout 到父仓库记录的指针，而是去拉取子模块配置的远端分支（在 .gitmodules 中定义的 branch = xxx），把子模块更新到远端最新提交
## --merge 👉 把远端最新合并到当前子模块分支
## --recursive 👉 子模块里还有子模块（嵌套 submodule），也会递归更新
## --jobs=<N> 是 Git 2.8+ 给 git submodule update 加的一个参数，用来 并发更新子模块
### --jobs=8 ：表示同时开 8 个并行任务 去处理子模块。
### --jobs=$(nproc)，number of processing units，返回当前机器可用的 逻辑 CPU 核心数。
### --jobs=$(sysctl -n hw.ncpu)，在 macOS / BSD 系统里，获取当前机器的 逻辑 CPU 核心数，sysctl 是 BSD/macOS 下的系统配置查询命令，-n 参数表示只输出数值，不带字段名。
## 什么时候不建议用 --jobs
### 子模块不多（比如就 1~2 个），加了也没意义。
### 网络或磁盘 IO 特别差时，太多并发反而会拖慢或者容易超时。
### Git 版本太老（2.7 以下），根本没有这个选项，会报错。
# 让全部子模块按“各自的 branch”前移
git submodule update --remote --merge --recursive --jobs=$(sysctl -n hw.ncpu)


