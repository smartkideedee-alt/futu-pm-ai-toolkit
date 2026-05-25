# Futu PM AI Toolkit

## Overview

AI-powered diagramming toolkit for Futu product managers. Claude acts as the orchestrator; Mermaid CLI does all the rendering — no second AI call, no external service dependency.

- **Primary entry:** Feishu bot (@PM Assistant + natural language)
- **Secondary entry:** Claude Code Skills (`/pm-flowchart`, `/pm-sequence`, etc.)

## Skills

| Skill | Purpose | Renderer |
|-------|---------|---------|
| `pm-diagram-router` | Auto-detect type and route | — |
| `pm-flowchart` | Business process flowcharts | Mermaid CLI |
| `pm-sequence` | API / microservice sequence diagrams | Mermaid CLI |
| `pm-er-diagram` | Entity-relationship diagrams | Mermaid CLI |
| `pm-user-journey` | User journey maps | Mermaid CLI |
| `pm-architecture` | System architecture diagrams | Mermaid CLI |
| `pm-mind-map` | Mind maps | Mermaid CLI |
| `pm-wireframe` | HTML wireframes | Claude (generates HTML directly) |

## Rendering Architecture

**Diagrams (6 types):** Claude Code generates Mermaid DSL → `mmdc` renders PNG
- Single AI call, ~5–15 seconds total
- Deterministic, professional output
- No external service required

**Wireframes:** Claude Code generates a self-contained HTML file directly
- No external service required
- Opens in browser immediately

## Primary Rendering Engine: Mermaid CLI

`mmdc` is installed at `/Users/admin/.node24/bin/mmdc` (v11.15.0).

Rendering script: `scripts/render-mermaid.sh`

```bash
PNG_FILE=$(bash ~/futu-pm-ai-toolkit/scripts/render-mermaid.sh /tmp/diagram.mmd)
open "$PNG_FILE"
```

Output saved to `/tmp/pm-diagrams/`.

## No External Service Required

All diagram types work without any running daemon or server.
The only dependency is `mmdc` (globally installed) and Claude Code itself.

## Feishu Integration

Configure `nexu-config/feishu.json` with real bot credentials.
Use `scripts/push-to-feishu-whiteboard.sh` to push Mermaid diagrams to Feishu whiteboards.
