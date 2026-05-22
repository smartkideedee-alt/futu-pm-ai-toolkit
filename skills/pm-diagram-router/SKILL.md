---
name: pm-diagram-router
description: 富途 PM 画图主入口。当用户描述任何画图需求时自动触发，识别图类型并路由到对应专项 Skill。基于 open-design 生成手绘风格交互图表（HTML）。
---

# PM 画图路由 Skill

## 职责

识别用户的自然语言画图需求，判断图类型，调用对应专项 Skill。

## 前置：检查 open-design 状态

```bash
curl -sf http://127.0.0.1:55850/api/health | python3 -c "
import sys,json; r=json.load(sys.stdin)
print('✅ open-design 运行中 (v' + r.get('version','?') + ')' if r.get('ok') else '❌ 未运行')
" || echo "❌ open-design daemon 未运行

启动命令：
cd ~/open-design
PATH=\"/Users/admin/.node24/bin:\$PATH\" pnpm tools-dev start"
```

## 图类型识别规则

| 关键词 | 调用 Skill | open-design Skill ID |
|--------|-----------|---------------------|
| 流程、步骤、审批、购买、注册 | pm-flowchart | `hand-drawn-diagrams` |
| 时序、API、接口、调用链、前后端 | pm-sequence | `hand-drawn-diagrams` |
| ER、实体、数据库、表结构 | pm-er-diagram | `hand-drawn-diagrams` |
| 旅程、体验、UX、路径、痛点 | pm-user-journey | `hand-drawn-diagrams` |
| 线框、原型、页面、UI、布局 | pm-wireframe | `frontend-design` |
| 架构、系统、组件、层次 | pm-architecture | `hand-drawn-diagrams` |
| 思维导图、脑图、大纲 | pm-mind-map | `hand-drawn-diagrams` |

## 执行步骤

1. 分析用户输入，判断图类型（用户明确指定时直接使用，否则按关键词匹配）
2. 无法判断时默认使用 pm-flowchart
3. 调用对应专项 Skill，传入完整用户描述

## 输出说明

所有图表生成后输出：
- HTML 文件路径（浏览器可直接预览，支持交互）
- 打开命令：`open <html_file>`
- open-design 项目 ID（可在 http://127.0.0.1:55857 继续编辑）
