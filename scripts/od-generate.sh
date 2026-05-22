#!/bin/bash
# 通过 open-design REST API 创建项目并触发生成
# 用法: od-generate.sh <skill_id> <diagram_name> <brief>
# 输出: project_id:run_id (写入 stdout)
# 依赖: open-design daemon 运行中

set -e

SKILL_ID="${1}"
DIAGRAM_NAME="${2:-PM图表_$(date +%m%d_%H%M)}"
BRIEF="${3}"

OD_DAEMON_URL="${OD_DAEMON_URL:-http://127.0.0.1:55850}"

if [ -z "$SKILL_ID" ] || [ -z "$BRIEF" ]; then
  echo "用法: $0 <skill_id> <diagram_name> <brief>" >&2
  exit 1
fi

# 1. 生成唯一项目 ID
PROJECT_ID="pm-$(date +%s)-$(openssl rand -hex 4 2>/dev/null || echo $RANDOM$RANDOM)"

# 2. 创建项目（REST API）
CREATE_RESULT=$(python3 -c "
import json, urllib.request, sys
data = json.dumps({
    'id': '$PROJECT_ID',
    'name': '''$DIAGRAM_NAME''',
    'skillId': '$SKILL_ID'
}).encode()
req = urllib.request.Request('$OD_DAEMON_URL/api/projects',
    data=data, headers={'Content-Type': 'application/json'}, method='POST')
resp = urllib.request.urlopen(req)
print(resp.read().decode())
" 2>/dev/null)

CONV_ID=$(echo "$CREATE_RESULT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['conversationId'])")

if [ -z "$CONV_ID" ]; then
  echo "错误：创建项目失败" >&2
  echo "$CREATE_RESULT" >&2
  exit 1
fi

# 3. 触发生成（POST /api/chat，读取 SSE start 事件中的 runId）
CHAT_BODY=$(python3 -c "
import json, sys
body = {
    'agentId': 'claude',
    'message': sys.argv[1],
    'projectId': sys.argv[2],
    'conversationId': sys.argv[3],
    'skillId': sys.argv[4]
}
print(json.dumps(body))
" "$BRIEF" "$PROJECT_ID" "$CONV_ID" "$SKILL_ID")

RUN_ID=$(curl -sf -N -X POST "$OD_DAEMON_URL/api/chat" \
  -H "Content-Type: application/json" \
  -d "$CHAT_BODY" 2>/dev/null | \
  python3 -c "
import sys
for line in sys.stdin:
    line = line.strip()
    if line.startswith('data:') and '\"runId\"' in line:
        import json
        data = json.loads(line[5:].strip())
        print(data.get('runId',''))
        break
")

if [ -z "$RUN_ID" ]; then
  echo "错误：无法获取 runId" >&2
  exit 1
fi

echo "${PROJECT_ID}:${RUN_ID}"
