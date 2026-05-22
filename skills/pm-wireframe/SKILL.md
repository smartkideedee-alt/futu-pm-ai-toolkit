---
name: pm-wireframe
description: 将页面结构描述转换为高保真 HTML 线框图（open-design frontend-design），适用于需求评审原型、UI 结构讨论等场景。
---

# PM 线框图 Skill

## 适用场景

- 需求评审前的快速原型
- 页面结构与布局讨论
- 新功能 UI 方案验证
- 移动端 / PC 端页面框架设计

## 执行步骤

1. 确定平台（mobile/PC）、页面名称、核心组件和布局结构
2. 将描述转换为英文 brief：
   ```
   Create a [mobile/desktop] wireframe for: [页面名称]
   
   Layout:
   - Header: [顶部内容，如导航栏、标题]
   - Main area:
     - [组件1]: [描述]
     - [组件2]: [描述]
   - Footer/Actions: [底部按钮或导航]
   
   Style: clean wireframe, focus on layout structure.
   Chinese text for all labels.
   ```
3. 执行生成（frontend-design 提供更高保真度）：
   ```bash
   RESULT=$(bash ~/futu-pm-ai-toolkit/scripts/od-generate.sh \
     "frontend-design" "线框图_$(date +%m%d_%H%M)" "$BRIEF")
   PROJECT_ID=$(echo "$RESULT" | cut -d: -f1)
   RUN_ID=$(echo "$RESULT" | cut -d: -f2)
   STATUS=$(bash ~/futu-pm-ai-toolkit/scripts/od-status.sh "$RUN_ID" 900)
   HTML_FILE=$(bash ~/futu-pm-ai-toolkit/scripts/od-export.sh "$PROJECT_ID" html)
   open "$HTML_FILE"
   ```

## 备注

如果 `frontend-design` 失败，改用 `hand-drawn-diagrams` 作为备用。
