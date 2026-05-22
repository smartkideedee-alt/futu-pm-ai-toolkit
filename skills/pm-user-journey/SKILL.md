---
name: pm-user-journey
description: 将用户体验路径描述转换为手绘风格用户旅程图（open-design），适用于 UX 评审、痛点识别、新功能路径梳理等场景。
---

# PM 用户旅程图 Skill

## 适用场景

- 新用户开户全流程体验梳理
- 关键功能使用路径分析
- 痛点识别与体验优化
- 多角色参与的业务流程

## 执行步骤

1. 识别用户类型、旅程阶段、触点、情绪和痛点
2. 将描述转换为英文 brief：
   ```
   Create a hand-drawn style user journey map for: [用户类型] - [场景]
   
   Journey phases:
   1. [阶段1]: [用户行为] | Touchpoint: [触点] | Emotion: happy/neutral/frustrated
   2. [阶段2]: [用户行为] | Touchpoint: [触点] | Pain point: [痛点描述]
   3. [阶段3]: [用户行为] | Touchpoint: [触点] | Emotion: happy
   
   Start: [起点]  End: [终点]
   Use Chinese labels.
   ```
3. 执行生成：
   ```bash
   RESULT=$(bash ~/futu-pm-ai-toolkit/scripts/od-generate.sh \
     "hand-drawn-diagrams" "旅程图_$(date +%m%d_%H%M)" "$BRIEF")
   PROJECT_ID=$(echo "$RESULT" | cut -d: -f1)
   RUN_ID=$(echo "$RESULT" | cut -d: -f2)
   STATUS=$(bash ~/futu-pm-ai-toolkit/scripts/od-status.sh "$RUN_ID" 900)
   HTML_FILE=$(bash ~/futu-pm-ai-toolkit/scripts/od-export.sh "$PROJECT_ID" html)
   open "$HTML_FILE"
   ```
