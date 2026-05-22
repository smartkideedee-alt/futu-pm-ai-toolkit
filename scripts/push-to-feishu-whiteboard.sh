#!/bin/bash
# 将 Mermaid DSL 推送到飞书画板（通过 lark-cli）
# 用法：./push-to-feishu-whiteboard.sh <mermaid_content_file> [whiteboard_token]
# 依赖：lark-cli（已在 nexu 环境中内置）

set -e

MERMAID_FILE="${1}"
WHITEBOARD_TOKEN="${2}"

if [ -z "$MERMAID_FILE" ] || [ ! -f "$MERMAID_FILE" ]; then
  echo "用法：$0 <mermaid_file.mmd> [whiteboard_token]"
  exit 1
fi

MERMAID_CONTENT=$(cat "$MERMAID_FILE")

if [ -z "$WHITEBOARD_TOKEN" ]; then
  # 未指定画板，创建新画板
  echo "🔨 正在创建新飞书画板..."
  WHITEBOARD_TOKEN=$(lark-cli whiteboard create --title "PM图表_$(date +%m%d_%H%M)")
fi

echo "📤 正在将 Mermaid 图表写入飞书画板 $WHITEBOARD_TOKEN ..."

# 通过 lark-whiteboard Skill 支持的 mermaid 格式推送
lark-cli whiteboard update \
  --token "$WHITEBOARD_TOKEN" \
  --format mermaid \
  --content "$MERMAID_CONTENT"

WHITEBOARD_URL="https://www.feishu.cn/docx/${WHITEBOARD_TOKEN}"
echo "✅ 已写入飞书画板：$WHITEBOARD_URL"
echo "$WHITEBOARD_URL"
