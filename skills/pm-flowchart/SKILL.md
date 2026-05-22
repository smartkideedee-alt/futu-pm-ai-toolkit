---
name: pm-flowchart
description: 将业务流程描述转换为手绘风格流程图（open-design），适用于用户操作流程、审批流程、系统处理逻辑等场景。输出 HTML 可交互版本。
---

# PM 流程图 Skill

## 适用场景

- 用户操作流程（注册、登录、开户、购买）
- 业务审批流程
- 系统处理逻辑
- 功能分支决策树

## 执行步骤

1. 理解用户需求，梳理主流程和所有分支（包括异常路径）
2. 将中文描述转换为清晰的英文 brief，格式：
   ```
   Create a hand-drawn style flowchart for: [业务名称]
   
   Steps:
   - [步骤1]
   - [步骤2] → decision: [条件] → yes: [成功路径] / no: [失败路径]
   
   Include all error paths and retry logic.
   Use Chinese labels for all nodes.
   ```
3. 调用 od-generate.sh 创建项目并触发生成：
   ```bash
   RESULT=$(bash ~/futu-pm-ai-toolkit/scripts/od-generate.sh \
     "hand-drawn-diagrams" \
     "流程图_$(date +%m%d_%H%M)" \
     "$BRIEF")
   PROJECT_ID=$(echo "$RESULT" | cut -d: -f1)
   RUN_ID=$(echo "$RESULT" | cut -d: -f2)
   ```
4. 等待生成完成：
   ```bash
   STATUS=$(bash ~/futu-pm-ai-toolkit/scripts/od-status.sh "$RUN_ID" 900)
   ```
5. 导出 HTML 文件：
   ```bash
   HTML_FILE=$(bash ~/futu-pm-ai-toolkit/scripts/od-export.sh "$PROJECT_ID" html)
   ```
6. 告知用户文件路径，并用以下命令在浏览器预览：
   ```bash
   open "$HTML_FILE"
   ```

## 前置条件

open-design daemon 需正在运行。启动方式：
```bash
cd ~/open-design && PATH="/Users/admin/.node24/bin:$PATH" pnpm tools-dev start
```

## 示例

**输入**：画一个股票购买流程图，包含登录、选股、下单、余额检查、成交

**brief（传给 od-generate.sh）**：
```
Create a hand-drawn style flowchart for: Stock Purchase Process

Steps:
- Start
- User Login → decision: Login success? → yes: Select Stock / no: Retry login
- Select Stock
- Fill Order (quantity, price)
- decision: Balance sufficient? → yes: Confirm Order / no: Show Recharge Prompt → back to Fill Order
- System Matching
- decision: Executed? → fully executed: Update holdings + Send notification → End
                     → partially executed: Update holdings + Continue order
                     → canceled: Return funds → End

Use Chinese labels for all nodes.
```
