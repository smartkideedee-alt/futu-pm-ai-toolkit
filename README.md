# futu-pm-ai-toolkit

A collection of Claude Code Skills for PM diagramming. Clone the repo, open it in Claude Code, and use natural language to generate diagrams directly in your terminal.

## Skills

| Slash Command | 图类型 | 输出格式 |
|---|---|---|
| `/pm-diagram-router` | 自动识别类型并路由 | — |
| `/pm-flowchart` | 流程图 | PNG (Mermaid) |
| `/pm-sequence` | 时序图 | PNG (Mermaid) |
| `/pm-er-diagram` | ER 图 | PNG (Mermaid) |
| `/pm-user-journey` | 用户旅程图 | PNG (Mermaid) |
| `/pm-architecture` | 架构图 | PNG (Mermaid) |
| `/pm-mind-map` | 思维导图 | PNG (Mermaid) |
| `/pm-wireframe` | 线框图 | HTML (Claude 直接生成) |

## Quick Start

### 1. 安装 Mermaid CLI

```bash
npm install -g @mermaid-js/mermaid-cli
mmdc --version
```

### 2. Clone 本仓库并在 Claude Code 中打开

```bash
git clone https://github.com/smartkideedee-alt/futu-pm-ai-toolkit.git
cd futu-pm-ai-toolkit
claude  # 打开 Claude Code
```

Skills 会自动加载，无需额外配置。

### 3. 使用

直接在 Claude Code 中输入 Slash Command：

```
/pm-flowchart 用户开户流程：注册 → KYC → 审核 → 开户成功

/pm-sequence 前端下单时序：前端 → API 网关 → 订单服务 → 数据库

/pm-er-diagram 股票交易数据模型：用户、账户、订单、持仓

/pm-mind-map 行情页 2.0 功能拆解

/pm-wireframe 移动端股票详情页，包含 K 线区、基本信息、资讯列表
```

不确定类型时用 `/pm-diagram-router`，会自动识别并路由到对应 Skill。

## Rendering Pipeline

**6 种图表（流程图 / 时序图 / ER / 旅程图 / 架构图 / 思维导图）：**
1. Claude 根据描述生成 Mermaid DSL，写入 `/tmp/diagram.mmd`
2. `scripts/render-mermaid.sh` 调用 `mmdc` 渲染为 PNG
3. 输出到 `/tmp/pm-diagrams/`，自动 `open` 预览

**线框图：**
- Claude 直接生成自包含 HTML 文件，写入 `/tmp/pm-diagrams/`，自动用浏览器打开

## Project Structure

```
futu-pm-ai-toolkit/
├── skills/
│   ├── pm-diagram-router/   # 主路由，自动识别图类型
│   ├── pm-flowchart/
│   ├── pm-sequence/
│   ├── pm-er-diagram/
│   ├── pm-user-journey/
│   ├── pm-wireframe/
│   ├── pm-architecture/
│   └── pm-mind-map/
├── scripts/
│   └── render-mermaid.sh    # Mermaid DSL → PNG
└── CLAUDE.md                # Claude Code 项目配置
```

## Dependencies

- [Claude Code](https://claude.ai/code) — Skills 运行环境
- [mermaid-js/mermaid-cli](https://github.com/mermaid-js/mermaid-cli) — 图表渲染引擎
