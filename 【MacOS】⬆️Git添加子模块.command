#!/usr/bin/env zsh
set -euo pipefail

# ============================ Git 子模块批量管理（模块化调用） ============================

# —— 自述 & 用户确认 ——
show_intro_and_wait() {
  cat <<'EOF'
📘 脚本说明
------------------------------------------------------------
本脚本用于批量管理 Git 子模块，包含以下流程：
  1. 切换到脚本所在目录，并确保这是 Git 仓库根目录
  2. 删除当前仓库下所有已存在的子模块（包括 .gitmodules 配置）
  3. 重新添加预定义的子模块
  4. 同步子模块配置并首次拉取
  5. 将子模块前移到远端分支最新，并【固化到父仓】记录最新 SHA
  6. 配置远程仓库（交互式输入）

⚠️ 注意：
运行后将会：彻底清空现有的子模块，并提交一笔清理记录。
请确保你已经备份或不再需要原有子模块的数据。

------------------------------------------------------------
按下 [回车] 键继续，或 Ctrl+C 取消。
EOF
  read -r
}

# —— 简易语义输出（避免外部依赖） ——
info_echo()    { echo "ℹ️  $*"; }
success_echo() { echo "✅ $*"; }
warn_echo()    { echo "⚠️  $*"; }
error_echo()   { echo "❌ $*" >&2; }

# 1) 切到脚本所在目录
cd_to_script_dir() {
  local script_path
  script_path="$(cd "$(dirname "${BASH_SOURCE[0]:-${(%):-%x}}")" && pwd)"
  cd "$script_path"
}

# 2) 初始化父仓（幂等）
ensure_repo_initialized() {
  git init
  # 先把现状纳入暂存，避免后续操作依赖失败（无变更时不报错）
  git add . || true
  git status
}

# 3) 运行前：清空当前仓库下所有子模块（递归安全）
#    - 逐个 deinit
#    - 从索引与工作区移除 gitlink（git rm）
#    - 删除 .git/modules/<name>
#    - 从 .gitmodules 移除对应 section；若空则删除 .gitmodules
#    - 同时兜底清理“孤儿 gitlink”
purge_all_submodules() {
  if [[ ! -f .gitmodules ]]; then
    info_echo ".gitmodules 不存在，跳过子模块清理"
  else
    info_echo "开始清理已存在的子模块……"

    # 列出所有子模块 name
    local names
    names=($(git config -f .gitmodules --name-only --get-regexp '^submodule\..*\.path' \
              2>/dev/null | sed -E 's/^submodule\.([^.]*)\.path/\1/'))

    for name in "${names[@]:-}"; do
      local path
      path="$(git config -f .gitmodules --get "submodule.${name}.path" 2>/dev/null || true)"
      [[ -z "${path:-}" ]] && continue

      warn_echo "移除子模块：$name ($path)"

      # 1) deinit
      git submodule deinit -f -- "$path" 2>/dev/null || true

      # 2) 从索引与工作区移除（优先 git rm；若失败则直接 rm -rf）
      if git ls-files --stage -- "$path" | grep -q '160000'; then
        git rm -f --cached -- "$path" 2>/dev/null || true
        git rm -f -- "$path" 2>/dev/null || true
      fi
      [[ -e "$path" ]] && rm -rf -- "$path"

      # 3) 删除 .git/modules/<name>
      [[ -d ".git/modules/$name" ]] && rm -rf ".git/modules/$name"

      # 4) 从 .gitmodules 移除对应 section
      git config -f .gitmodules --remove-section "submodule.$name" 2>/dev/null || true
    done

    # 如果 .gitmodules 已无内容则删除
    if ! git config -f .gitmodules -l >/dev/null 2>&1; then
      rm -f .gitmodules
      info_echo "已删除空的 .gitmodules"
    fi
  fi

  # 兜底：清理可能残留的“孤儿 gitlink”（索引里 type=160000，但 .gitmodules 没有）
  local orphan_paths
  orphan_paths=($(git ls-files -s | awk '$1==160000 {print $4}'))
  if [[ ${#orphan_paths[@]} -gt 0 ]]; then
    warn_echo "检测到孤儿 gitlink：${orphan_paths[*]}"
    for p in "${orphan_paths[@]}"; do
      git rm -f --cached -- "$p" 2>/dev/null || true
      [[ -e "$p" ]] && rm -rf -- "$p"
    done
  fi

  # 整体变更纳入暂存（无变更不报错）
  git add -A || true
  # 有变更则提交一笔记录（无变更时跳过）
  if ! git diff --cached --quiet; then
    git commit -m "chore: purge all existing submodules" || true
    success_echo "已提交子模块清理记录"
  else
    info_echo "无子模块需要清理"
  fi
}

# 4) 确保 .gitmodules 在“当前脚本运行目录”（且该目录就是仓库根）
ensure_gitmodules_here() {
  # 已是 Git 仓库时，校验顶层目录
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    local top
    top="$(git rev-parse --show-toplevel 2>/dev/null || true)"
    if [[ -n "${top:-}" && "$top" != "$PWD" ]]; then
      error_echo "当前目录不是仓库根目录：top-level = $top （.gitmodules 必须在仓库根）"
      exit 1
    fi
  fi

  if [[ ! -e .gitmodules ]]; then
    printf "# Auto-created by script on %s\n" "$(date -u +"%Y-%m-%dT%H:%M:%SZ")" > .gitmodules
    info_echo "已创建空的 .gitmodules 于：$PWD"
  elif [[ -L .gitmodules || -d .gitmodules ]]; then
    local bak=".gitmodules.bak.$(date +%s)"
    mv .gitmodules "$bak"
    printf "# Auto-recreated by script on %s (backup: %s)\n" "$(date -u +"%Y-%m-%dT%H:%M:%SZ")" "$bak" > .gitmodules
    warn_echo "检测到异常的 .gitmodules（目录/符号链接），已备份为 $bak 并重建为常规文件"
  fi

  git add .gitmodules 2>/dev/null || true
}

# 5) 添加子模块（此时就在拉取远端）
add_submodules() {
  git submodule add -b main https://github.com/295060456/JobsCommand-Flutter.git  ./JobsGenesis@JobsCommand.Flutter
  git submodule add -b main https://github.com/295060456/JobsCommand-iOS.git      ./JobsGenesis@JobsCommand.iOS
  git submodule add -b main https://github.com/295060456/JobsCommand-Gits.git     ./JobsGenesis@JobsCommand.Gits
  git submodule add -b main https://github.com/295060456/JobsCommand-Others.git   ./JobsGenesis@JobsCommand.Others
  git submodule add -b main https://github.com/295060456/JobsSh.git               ./JobsGenesis@JobsSh
}

# 6) 同步子模块记录
sync_submodules() {
  git submodule sync
}

# 7) 提交 .gitmodules 及目录占位
commit_gitmodules_and_dirs() {
  git add .gitmodules */ 2>/dev/null || true
  git commit -m "同步文件" || info_echo "无变更可提交，跳过 commit"
}

# 8) 获取并发数（macOS 优先，用于 submodule --jobs）
get_ncpu() {
  if command -v sysctl >/dev/null 2>&1; then
    sysctl -n hw.ncpu
  else
    echo 1
  fi
}

# 9) 首次拉取子模块内容（并发）
submodule_init_update() {
  git submodule update --init --recursive --jobs="$(get_ncpu)"
}

# 10) 让全部子模块按“各自的 branch”前移到远端最新
submodule_ff_remote_merge() {
  git submodule update --remote --merge --recursive --jobs="$(get_ncpu)"
}

# 11) 配置当前 Git 仓库的 remote（交互式，兼容 zsh）
ensure_git_remote() {
  local remote_name="${1:-origin}"
  local remote_url=""

  # 如果已经存在远程仓库，直接提示并返回
  if git remote get-url "$remote_name" >/dev/null 2>&1; then
    info_echo "已存在 git remote [$remote_name] -> $(git remote get-url "$remote_name")"
    return 0
  fi

  while true; do
    # ✅ 在 zsh 里用 read '?prompt:'，在 bash 里用 read -p
    if [ -n "${ZSH_VERSION:-}" ]; then
      read "?请输入远程仓库地址 (例如 https://github.com/user/repo.git): " remote_url
    else
      read -p "请输入远程仓库地址 (例如 https://github.com/user/repo.git): " remote_url
    fi

    if [[ -z "${remote_url:-}" ]]; then
      warn_echo "输入为空，请重新输入"
      continue
    fi

    # 验证远程是否可访问
    if git ls-remote "$remote_url" >/dev/null 2>&1; then
      git remote add "$remote_name" "$remote_url"
      success_echo "已成功配置 git remote [$remote_name] -> $remote_url"
      break
    else
      error_echo "无法访问 $remote_url，请检查地址是否正确"
    fi
  done
}


# 12) 记录子模块新的 SHA 到父仓，并尽量让子模块处于分支 HEAD（避免 detached HEAD）
record_and_normalize_submodules() {
  info_echo "标准化子模块分支并固化 gitlink 到父仓……"

  # 尽量让每个子模块处于 main 分支（若存在）
  git submodule foreach '
    set -e
    # 有 main 分支就切过去并同步
    if git show-ref --verify --quiet refs/heads/main; then
      git checkout main >/dev/null 2>&1 || true
      git pull --ff-only || true
    else
      # 尝试创建 main 跟踪 origin/main
      if git ls-remote --exit-code --heads origin main >/dev/null 2>&1; then
        git checkout -B main --track origin/main || true
        git pull --ff-only || true
      fi
    fi
  '

  # 取出所有子模块路径，提交到父仓，使父仓记录最新 gitlink
  local paths
  paths=($(git config -f .gitmodules --get-regexp '^submodule\..*\.path$' 2>/dev/null | awk '{print $2}'))
  if [[ ${#paths[@]} -gt 0 ]]; then
    git add "${paths[@]}" 2>/dev/null || true
  fi

  git commit -m "chore: bump submodules to latest remote" || info_echo "无子模块前移需要固化，跳过 commit"
  success_echo "子模块最新提交已固化到父仓（若有变更）"
}

# ================================== main（只调用函数） ==================================
main() {
  show_intro_and_wait         # 自述信息 + 等待用户确认
  cd_to_script_dir            # 切到脚本所在目录
  ensure_repo_initialized     # 初始化父仓（幂等）
  purge_all_submodules        # ✅ 运行前：先删除本文件夹下所有子模块（含索引与 .git/modules）
  ensure_gitmodules_here      # 确保 .gitmodules 在当前目录（且为仓库根），必要时创建/修复
  add_submodules              # 添加子模块（立即拉取）
  sync_submodules             # 同步子模块记录
  commit_gitmodules_and_dirs  # 提交 .gitmodules 及目录占位
  submodule_init_update       # 首次拉取子模块内容（并发）
  submodule_ff_remote_merge   # 让全部子模块按“各自的 branch”前移到远端最新
  record_and_normalize_submodules  # ✅ 固化子模块 SHA 到父仓，并尽量在 main 分支上
  ensure_git_remote           # 配置 remote（可交互）
}

main "$@"
