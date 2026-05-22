---
name: pm-er-diagram
description: 将数据实体描述转换为手绘风格 ER 图（open-design），适用于数据库设计评审、产品数据模型沟通等场景。
---

# PM ER 图 Skill

## 适用场景

- 产品需求中的数据实体关系
- 数据库表结构设计评审
- 新功能数据模型沟通
- 第三方数据接入结构梳理

## 执行步骤

1. 识别所有实体、关键属性和关系（1:1 / 1:N / M:N）
2. 将描述转换为英文 brief：
   ```
   Create a hand-drawn style ER diagram for: [系统名称]
   
   Entities and attributes:
   - [实体1]: [属性1], [属性2(PK)], [属性3]
   - [实体2]: [属性1(PK)], [属性2(FK)]
   
   Relationships:
   - [实体1] has many [实体2] (via [外键])
   - [实体2] belongs to [实体3]
   
   Use Chinese labels for entity and attribute names.
   ```
3. 执行生成：
   ```bash
   RESULT=$(bash ~/futu-pm-ai-toolkit/scripts/od-generate.sh \
     "hand-drawn-diagrams" "ER图_$(date +%m%d_%H%M)" "$BRIEF")
   PROJECT_ID=$(echo "$RESULT" | cut -d: -f1)
   RUN_ID=$(echo "$RESULT" | cut -d: -f2)
   STATUS=$(bash ~/futu-pm-ai-toolkit/scripts/od-status.sh "$RUN_ID" 900)
   HTML_FILE=$(bash ~/futu-pm-ai-toolkit/scripts/od-export.sh "$PROJECT_ID" html)
   open "$HTML_FILE"
   ```
