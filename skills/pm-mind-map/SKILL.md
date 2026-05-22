---
name: pm-mind-map
description: 将主题和要点转换为手绘风格思维导图（open-design），适用于需求头脑风暴、PRD 大纲整理、功能拆解、问题分析。
---

# PM 思维导图 Skill

## 适用场景

- PRD 功能结构大纲梳理
- 需求讨论头脑风暴整理
- 竞品分析维度梳理
- 项目范围 / 边界讨论

## 执行步骤

1. 确定中心主题和主要分支，展开子节点
2. 将描述转换为英文 brief：
   ```
   Create a hand-drawn style mind map for: [中心主题]
   
   Main branches:
   - [分支1]: [子节点1-1], [子节点1-2], [子节点1-3]
   - [分支2]: [子节点2-1], [子节点2-2]
   - [分支3]: [子节点3-1], [子节点3-2]
   
   Use Chinese labels for all nodes. Make central node prominent.
   ```
3. 执行生成：
   ```bash
   RESULT=$(bash ~/futu-pm-ai-toolkit/scripts/od-generate.sh \
     "hand-drawn-diagrams" "思维导图_$(date +%m%d_%H%M)" "$BRIEF")
   PROJECT_ID=$(echo "$RESULT" | cut -d: -f1)
   RUN_ID=$(echo "$RESULT" | cut -d: -f2)
   STATUS=$(bash ~/futu-pm-ai-toolkit/scripts/od-status.sh "$RUN_ID" 900)
   HTML_FILE=$(bash ~/futu-pm-ai-toolkit/scripts/od-export.sh "$PROJECT_ID" html)
   open "$HTML_FILE"
   ```
