# 富途 PM AI 工具包

## 项目简介

本项目为富途产品经理提供 AI 驱动的画图 & 设计能力：
- **主入口**：飞书机器人对话（@PM助理 + 自然语言描述）
- **副入口**：Claude Code Skill Club（`/pm-flowchart` 等命令）

## Skills 目录

所有 PM Skills 位于 `skills/` 目录，已注册为 Claude Code Skills：

| Skill | 用途 |
|-------|------|
| `pm-diagram-router` | 主路由，自动识别图类型 |
| `pm-flowchart` | 流程图 |
| `pm-sequence` | 时序图 |
| `pm-er-diagram` | ER 图 |
| `pm-user-journey` | 用户旅程图 |
| `pm-wireframe` | 线框图（HTML）|
| `pm-architecture` | 架构图 |
| `pm-mind-map` | 思维导图 |

## 渲染依赖：open-design

所有图表通过本地 open-design daemon 生成（手绘风格 HTML / PNG / PPTX）。

```bash
# 启动 open-design daemon（首次启动或重启后执行）
cd ~/open-design
PATH="/Users/admin/.node24/bin:$PATH" pnpm tools-dev start

# 验证 daemon 状态
curl -sf http://127.0.0.1:55850/api/health

# daemon 默认端口：55850（API）/ 55857（Web UI，可选）
```

集成脚本位于 `scripts/`：
- `od-generate.sh` — 创建项目并触发生成，返回 `project_id:run_id`
- `od-status.sh`  — 轮询运行状态至完成（默认超时 300s）
- `od-export.sh`  — 下载生成文件（html / png / pptx）

## 飞书配置

见 `nexu-config/feishu.json`（需填入真实 Bot Token）。

## 快速开始

1. 安装 nexu desktop（https://github.com/nexu-io/nexu）
2. 配置 `nexu-config/feishu.json`
3. 在 nexu 中添加 Feishu 频道
4. 在飞书中 @PM助理 发送任意画图需求
