#!/usr/bin/env zsh
# 作用：在父仓库中一键同步 .gitmodules → 初始化并下载所有子模块
# 行为：默认仅把子模块检出到“父仓记录的提交”（不改 gitlink、不推送）
# 可选：设置 TRACK_BRANCH=1 时，切到各子模块的 main 分支并 pull（会让父仓变脏）

set -euo pipefail

# ===== 可调参数 =====
DEPTH="${DEPTH:-0}"            # 0=完整克隆；>0 则浅克隆（如 1）
TRACK_BRANCH="${TRACK_BRANCH:-0}"  # 1=把子模块切到 main 并拉最新；0=保持父仓记录的提交
PARALLEL="${PARALLEL:-4}"      # 并行作业数（仅在 foreach 简单并行时使用）

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]:-${(%):-%x}}")" && pwd)"
cd "$script_dir"

# ===== 基础检查 =====
command -v git >/dev/null || { echo "❌ 未找到 git"; exit 1; }
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || { echo "❌ 当前不在 Git 仓库内"; exit 1; }
[[ -f .gitmodules ]] || { echo "❌ 未发现 .gitmodules，确认脚本放在父仓根目录"; exit 1; }

echo "ℹ️  同步子模块 URL（.gitmodules → .git/config）"
git submodule sync --recursive

echo "⏬ 初始化并下载所有子模块（可能耗时）"
if [[ "$DEPTH" != "0" ]]; then
  git submodule update --init --recursive --depth "$DEPTH"
else
  git submodule update --init --recursive
fi

# 显示一下状态
echo "📋 子模块状态："
git submodule status --recursive || true

if [[ "$TRACK_BRANCH" == "1" ]]; then
  echo "🔀 将子模块切到 main 分支并拉取最新（父仓 gitlink 将变化）"
  # 如果子模块配置了别的分支，可以改成 set-branch
  git submodule foreach --recursive '
    set -e
    branch="main"
    # 尝试 main，不行就 master
    if ! git show-ref --verify --quiet refs/heads/$branch; then
      [[ -n "$(git branch -a | grep remotes/.*/main)" ]] || branch="master"
    fi
    git fetch --all --tags --prune
    git checkout "$branch" || true
    git pull --ff-only || true
    echo "✅ $(basename "$name"): on $(git rev-parse --abbrev-ref HEAD) @ $(git rev-parse --short HEAD)"
  '
  echo "⚠️  父仓现在可能处于“已修改的子模块指针”状态："
  echo "    若要固化到父仓，请手动： git add . && git commit -m 'chore(submodules): bump'"
fi

echo "✅ 完成"

# 常见故障提示
cat <<'EOF'

🩺 如果仍为空/拉取失败，按顺序排查：
1) 权限：子模块是否私有？HTTPS 需要 Token；SSH 需要配置公钥（ssh -T git@github.com）。
2) URL：检查 .gitmodules 中地址是否正确；改过后记得运行：git submodule sync --recursive
3) 网络：公司代理/防火墙；必要时切换 HTTPS/SSH 协议。
4) 浅克隆过深：尝试删除该子模块目录后重新执行，或把 DEPTH=0。
EOF
