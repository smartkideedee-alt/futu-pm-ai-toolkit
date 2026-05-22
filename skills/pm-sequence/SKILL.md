---
name: pm-sequence
description: 将系统交互描述转换为手绘风格时序图（open-design），适用于 API 交互、微服务调用链、前后端通信等场景。
---

# PM 时序图 Skill

## 适用场景

- 前后端 API 接口交互
- 微服务调用链路
- 用户 ↔ 系统 ↔ 第三方交互
- 支付、认证、通知等关键链路

## 执行步骤

1. 识别所有参与方（Participants）和消息流
2. 将描述转换为英文 brief：
   ```
   Create a hand-drawn style sequence diagram for: [功能名称]
   
   Participants: [角色1], [角色2], [角色3]
   
   Sequence:
   1. [角色A] → [角色B]: [请求描述]
   2. [角色B] → [角色C]: [调用描述]
   3. [角色C] → [角色B]: [响应]
   4. [角色B] → [角色A]: [最终响应]
   
   Include error flows. Use Chinese labels.
   ```
3. 执行生成：
   ```bash
   RESULT=$(bash ~/futu-pm-ai-toolkit/scripts/od-generate.sh \
     "hand-drawn-diagrams" "时序图_$(date +%m%d_%H%M)" "$BRIEF")
   PROJECT_ID=$(echo "$RESULT" | cut -d: -f1)
   RUN_ID=$(echo "$RESULT" | cut -d: -f2)
   STATUS=$(bash ~/futu-pm-ai-toolkit/scripts/od-status.sh "$RUN_ID" 900)
   HTML_FILE=$(bash ~/futu-pm-ai-toolkit/scripts/od-export.sh "$PROJECT_ID" html)
   open "$HTML_FILE"
   ```
