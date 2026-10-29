#!/usr/bin/env bash
# 把本仓库某个分支上的技能或工具装到本地目录。
# 用法：./install.sh <name> [target] [kind]
set -euo pipefail

NAME="${1:?用法: ./install.sh <name> [target] [kind]}"
TARGET="${2:-$HOME/.codex/skills}"
KIND="${3:-skill}"
REMOTE="${REMOTE:-https://github.com/YijiaQian/skills.git}"
BRANCH="$KIND/$NAME"

if [ "$KIND" = "skill" ]; then
  MARKER="SKILL.md"
else
  MARKER="README.md"
fi

STAGING="$(mktemp -d)"
trap 'rm -rf "$STAGING"' EXIT

echo "克隆 $BRANCH ..."
git clone --depth 1 --branch "$BRANCH" "$REMOTE" "$STAGING" >/dev/null 2>&1 || {
  echo "克隆失败：分支 $BRANCH 可能不存在" >&2
  exit 1
}

[ -f "$STAGING/$MARKER" ] || {
  echo "$BRANCH 的根目录缺少 $MARKER，分支结构不符合约定" >&2
  exit 1
}

mkdir -p "$TARGET"
DEST="$TARGET/$NAME"
if [ -e "$DEST" ]; then
  BACKUP="$DEST.bak-$(date +%Y%m%d%H%M%S)"
  mv "$DEST" "$BACKUP"
  echo "已存在同名目录，备份为 $BACKUP"
fi

mv "$STAGING" "$DEST"
echo "已安装到 $DEST"
