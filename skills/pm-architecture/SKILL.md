---
name: pm-architecture
description: 将系统架构描述转换为手绘风格架构图（open-design），适用于技术方案沟通、系统边界梳理、微服务架构概览等场景。
---

# PM 架构图 Skill

## 适用场景

- 新功能系统架构方案沟通
- 微服务架构概览
- 数据流向与系统边界梳理
- 与研发对齐技术方案

## 执行步骤

1. 识别系统模块、层次结构和数据流向
2. 将描述转换为英文 brief：
   ```
   Create a hand-drawn style architecture diagram for: [系统名称]
   
   Layers/Components:
   - Layer 1 ([层名]): [组件1], [组件2]
   - Layer 2 ([层名]): [组件3], [组件4]
   - Layer 3 ([层名]): [组件5]
   
   Data flow: [数据源] → [处理层] → [输出层]
   External dependencies: [外部系统]
   
   Use Chinese labels. Show arrows for data flow direction.
   ```
3. 执行生成：
   ```bash
   RESULT=$(bash ~/futu-pm-ai-toolkit/scripts/od-generate.sh \
     "hand-drawn-diagrams" "架构图_$(date +%m%d_%H%M)" "$BRIEF")
   PROJECT_ID=$(echo "$RESULT" | cut -d: -f1)
   RUN_ID=$(echo "$RESULT" | cut -d: -f2)
   STATUS=$(bash ~/futu-pm-ai-toolkit/scripts/od-status.sh "$RUN_ID" 900)
   HTML_FILE=$(bash ~/futu-pm-ai-toolkit/scripts/od-export.sh "$PROJECT_ID" html)
   open "$HTML_FILE"
   ```
