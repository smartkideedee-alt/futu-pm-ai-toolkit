# 富途 PM AI 工具包

基于 [nexu-io](https://github.com/nexu-io) 开源生态构建，为富途产品经理提供 AI 驱动的画图 & 设计能力。

## 使用方式

### 主入口：飞书机器人（零门槛）

在飞书中 @PM助理，用自然语言描述你的需求：

```
@PM助理 帮我画一个用户开户流程图，包含注册、KYC、审核、开户成功四个阶段

@PM助理 画一个前后端下单时序图，前端→API网关→订单服务→数据库

@PM助理 帮我整理新版行情页的功能思维导图

@PM助理 画一个股票详情页的线框图，移动端
```

机器人会自动识别图类型，生成图片并写入飞书画板（可继续编辑）。

### 副入口：Claude Code Skill Club

在 Claude Code 中直接调用：

```bash
/pm-flowchart 描述你的流程...
/pm-sequence 描述交互时序...
/pm-er-diagram 描述数据实体...
/pm-mind-map 主题和要点...
```

## 支持的图表类型

| Skill | 图类型 | 典型场景 |
|-------|--------|---------|
| `pm-flowchart` | 流程图 | 用户操作流程、审批流程 |
| `pm-sequence` | 时序图 | API交互、微服务调用链 |
| `pm-er-diagram` | ER图 | 数据模型、表结构设计 |
| `pm-user-journey` | 用户旅程图 | UX评审、痛点分析 |
| `pm-wireframe` | 线框图 | 需求评审原型、UI结构 |
| `pm-architecture` | 架构图 | 技术方案、系统边界 |
| `pm-mind-map` | 思维导图 | 需求头脑风暴、PRD大纲 |

## 快速部署

### 1. 安装依赖

```bash
# 安装 Mermaid CLI（渲染引擎）
npm install -g @mermaid-js/mermaid-cli

# 验证
mmdc --version
```

### 2. 安装 nexu（飞书集成运行时）

下载 nexu desktop：https://github.com/nexu-io/nexu/releases

双击安装，无需配置开发环境。

### 3. 配置飞书机器人

1. 访问[飞书开放平台](https://open.feishu.cn)，创建企业自建应用
2. 开启「机器人」能力
3. 配置事件订阅：`im.message.receive_v1`（接收消息）
4. 填写 `nexu-config/feishu.json` 中的 App ID / App Secret 等凭证
5. 在 nexu desktop 中：添加频道 → 飞书 → 导入配置文件

### 4. 注册 Skills 到 Skill Club

```bash
# 将 skills/ 目录路径配置到团队 CLAUDE.md 或 Skill Club 平台
# Claude Code 用户：把本仓库 clone 到本地，Skills 自动可用
git clone <本仓库地址> futu-pm-ai-toolkit
cd futu-pm-ai-toolkit
# 打开 Claude Code，Skills 即可使用
```

## 项目结构

```
futu-pm-ai-toolkit/
├── skills/                    # Claude Code SKILL.md 文件
│   ├── pm-diagram-router/     # 主路由（自动识别图类型）
│   ├── pm-flowchart/          # 流程图
│   ├── pm-sequence/           # 时序图
│   ├── pm-er-diagram/         # ER 图
│   ├── pm-user-journey/       # 用户旅程图
│   ├── pm-wireframe/          # 线框图
│   ├── pm-architecture/       # 架构图
│   └── pm-mind-map/           # 思维导图
├── nexu-config/
│   └── feishu.json            # 飞书频道配置模板
├── scripts/
│   ├── render-mermaid.sh      # Mermaid → PNG 渲染
│   └── push-to-feishu-whiteboard.sh  # 写入飞书画板
└── CLAUDE.md                  # Claude Code 项目配置
```

## 开源依赖

- [nexu-io/nexu](https://github.com/nexu-io/nexu) — 飞书集成运行时
- [nexu-io/open-design](https://github.com/nexu-io/open-design) — 高级设计生成
- [nexu-io/html-anything](https://github.com/nexu-io/html-anything) — HTML 线框图
- [mermaid-js/mermaid](https://github.com/mermaid-js/mermaid) — 图表渲染引擎
