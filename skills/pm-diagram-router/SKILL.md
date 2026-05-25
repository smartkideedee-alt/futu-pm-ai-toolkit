---
name: pm-diagram-router
description: Main entry point for PM diagramming. Auto-detects diagram type from natural language and routes to the correct specialized skill. Uses Mermaid CLI as the rendering engine — no second AI call, consistent professional output.
---

# PM Diagram Router

## Responsibility

Detect the diagram type from the user's natural language input, then invoke the matching specialized skill.

## Diagram Type Detection

| Keywords (Chinese or English) | Skill to invoke | Renderer |
|-------------------------------|----------------|---------|
| 流程 / 步骤 / 审批 / flowchart / process / approval | pm-flowchart | Mermaid CLI |
| 时序 / API / 接口 / sequence / API call / microservice | pm-sequence | Mermaid CLI |
| ER / 实体 / 数据库 / 表结构 / entity / database / schema | pm-er-diagram | Mermaid CLI |
| 旅程 / 体验 / UX / journey / experience / pain point | pm-user-journey | Mermaid CLI |
| 线框 / 原型 / 页面 / UI / wireframe / prototype / layout | pm-wireframe | open-design (frontend-design) |
| 架构 / 系统 / 组件 / architecture / system / component | pm-architecture | Mermaid CLI |
| 思维导图 / 脑图 / 大纲 / mind map / mindmap / outline | pm-mind-map | Mermaid CLI |

Default when ambiguous: invoke **pm-flowchart**.

## Execution Steps

1. Analyze the user's input and determine the diagram type.
   - If the user explicitly names a type, use it directly.
   - If ambiguous, pick the best match from the table above.
2. Invoke the matching specialized skill with the full user description as input.
3. For wireframe only: verify open-design daemon is running first:
   ```bash
   curl -sf http://127.0.0.1:55850/api/health || echo "⚠️  open-design daemon not running. Start it: cd ~/open-design && PATH=\"/Users/admin/.node24/bin:\$PATH\" pnpm tools-dev start"
   ```

## Output

All non-wireframe diagrams return a PNG file path rendered by Mermaid CLI.
Wireframe returns an HTML file rendered by open-design.
