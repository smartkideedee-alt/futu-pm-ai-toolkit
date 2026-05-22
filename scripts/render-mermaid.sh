#!/bin/bash
# Mermaid 代码 → PNG 渲染脚本
# 用法：./render-mermaid.sh <mermaid_file.mmd> [output.png]
# 依赖：npm install -g @mermaid-js/mermaid-cli

set -e

INPUT_FILE="${1:-/dev/stdin}"
OUTPUT_DIR="/tmp/pm-diagrams"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_FILE="${2:-${OUTPUT_DIR}/diagram_${TIMESTAMP}.png}"

mkdir -p "$OUTPUT_DIR"

if ! command -v mmdc &> /dev/null; then
  echo "错误：未找到 Mermaid CLI。请运行：npm install -g @mermaid-js/mermaid-cli"
  exit 1
fi

mmdc \
  --input "$INPUT_FILE" \
  --output "$OUTPUT_FILE" \
  --theme default \
  --backgroundColor white \
  --width 1200 \
  --height 800 \
  --scale 2

echo "✅ 渲染完成：$OUTPUT_FILE"
echo "$OUTPUT_FILE"
