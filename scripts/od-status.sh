#!/bin/bash
# 轮询 open-design 生成状态直到完成
# 用法: od-status.sh <run_id> [timeout_sec]
# 输出: "done" | "failed" | "timeout"

set -e

RUN_ID="${1}"
TIMEOUT="${2:-900}"

if [ -z "$OD_DAEMON_URL" ]; then
  OD_DAEMON_URL="http://127.0.0.1:55850"
fi

if [ -z "$RUN_ID" ]; then
  echo "用法: $0 <run_id> [timeout_sec]" >&2
  exit 1
fi

ELAPSED=0
INTERVAL=5

while [ "$ELAPSED" -lt "$TIMEOUT" ]; do
  STATUS=$(curl -sf "$OD_DAEMON_URL/api/runs/$RUN_ID" 2>/dev/null | \
    python3 -c "import sys,json; r=json.load(sys.stdin); print(r.get('status','?'))" 2>/dev/null)

  case "$STATUS" in
    succeeded)
      echo "done"
      exit 0
      ;;
    failed|canceled)
      echo "failed"
      exit 1
      ;;
    running|queued)
      echo "⏳ 生成中... (${ELAPSED}s / ${TIMEOUT}s)" >&2
      sleep "$INTERVAL"
      ELAPSED=$((ELAPSED + INTERVAL))
      ;;
    *)
      echo "未知状态: $STATUS" >&2
      sleep "$INTERVAL"
      ELAPSED=$((ELAPSED + INTERVAL))
      ;;
  esac
done

echo "timeout"
exit 1
