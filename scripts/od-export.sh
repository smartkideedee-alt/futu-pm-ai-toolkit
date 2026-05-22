#!/bin/bash
# 从 open-design 项目导出文件（HTML / PDF / ZIP / PNG）
# 用法: od-export.sh <project_id> <format> [output_path]
# format: html | pdf | zip | png
# 输出: 下载的文件路径

set -e

PROJECT_ID="${1}"
FORMAT="${2:-html}"
OUTPUT_DIR="/tmp/od-diagrams"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_PATH="${3:-${OUTPUT_DIR}/diagram_${TIMESTAMP}.${FORMAT}}"

if [ -z "$OD_DAEMON_URL" ]; then
  OD_DAEMON_URL="http://127.0.0.1:55850"
fi

if [ -z "$PROJECT_ID" ]; then
  echo "用法: $0 <project_id> <format> [output_path]" >&2
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

if [ "$FORMAT" = "png" ]; then
  # PNG 需要先下载 HTML，再用 screencapture
  HTML_PATH="${OUTPUT_DIR}/diagram_${TIMESTAMP}.html"
  od-export.sh "$PROJECT_ID" html "$HTML_PATH"

  # 检查是否有 shot-scraper 或使用系统工具
  if command -v shot-scraper &>/dev/null; then
    shot-scraper "$HTML_PATH" -o "$OUTPUT_PATH" --width 1400 --height 900
  elif command -v puppeteer &>/dev/null; then
    puppeteer screenshot "file://$HTML_PATH" "$OUTPUT_PATH"
  else
    # macOS: 打开 Safari 截图（fallback）
    echo "⚠️ 未找到 shot-scraper，返回 HTML 路径代替 PNG" >&2
    echo "$HTML_PATH"
    exit 0
  fi
else
  # 从 API 获取文件列表，找到第一个 HTML/指定格式文件
  FILES=$(curl -sf "$OD_DAEMON_URL/api/projects/$PROJECT_ID/files" 2>/dev/null)

  case "$FORMAT" in
    html)
      FILENAME=$(echo "$FILES" | python3 -c "
import sys, json
data = json.load(sys.stdin)
files = [f for f in data.get('files',[]) if f.get('kind') == 'html']
print(files[0]['name'] if files else '')
")
      ;;
    pdf|zip)
      # export format via artifact export endpoint
      FILENAME=$(echo "$FILES" | python3 -c "
import sys, json
data = json.load(sys.stdin)
files = [f for f in data.get('files',[]) if f.get('kind') == 'html']
print(files[0]['name'] if files else '')
")
      # Use export endpoint if available
      curl -sf "$OD_DAEMON_URL/api/projects/$PROJECT_ID/export?format=$FORMAT" \
        -o "$OUTPUT_PATH" 2>/dev/null && echo "$OUTPUT_PATH" && exit 0
      ;;
  esac

  if [ -z "$FILENAME" ]; then
    echo "错误：项目中未找到可导出的文件" >&2
    exit 1
  fi

  # 下载原始文件
  curl -sf "$OD_DAEMON_URL/api/projects/$PROJECT_ID/raw/$FILENAME" \
    -o "$OUTPUT_PATH" 2>/dev/null
fi

echo "✅ 已导出: $OUTPUT_PATH" >&2
echo "$OUTPUT_PATH"
