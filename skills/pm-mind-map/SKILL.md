---
name: pm-mind-map
description: Convert a topic and key points into a professional mind map PNG using Mermaid CLI. Suitable for PRD structure, brainstorming, feature decomposition, and problem analysis. Rendered by Mermaid — not by Claude.
---

# PM Mind Map Skill

## Use Cases

- PRD feature structure outline
- Requirement discussion brainstorm organization
- Competitive analysis dimension breakdown
- Project scope and boundary discussion

## Execution Steps

1. **Parse the user's description** — identify the central topic and the hierarchy of main branches and sub-nodes (2–3 levels deep is ideal).

2. **Write Mermaid DSL** to a temp file. Use `mindmap` syntax.

   DSL template:
   ```mermaid
   mindmap
     root((中心主题))
       分支一
         子节点 1-1
         子节点 1-2
       分支二
         子节点 2-1
         子节点 2-2
         子节点 2-3
       分支三
         子节点 3-1
   ```

   Syntax rules:
   - Indentation defines hierarchy (2 spaces per level)
   - `root((text))` — circular root node
   - `text` — plain branch or leaf
   - `[text]` — rectangle node
   - `(text)` — rounded node
   - `{{text}}` — hexagon node

   All labels may be in Chinese.

3. **Write DSL to file and render:**
   ```bash
   MMD_FILE="/tmp/mindmap_$(date +%Y%m%d_%H%M%S).mmd"
   # Write the Mermaid DSL to $MMD_FILE
   PNG_FILE=$(bash ~/futu-pm-ai-toolkit/scripts/render-mermaid.sh "$MMD_FILE")
   open "$PNG_FILE"
   ```

4. **Report** the PNG file path to the user.

## Example

**Input:** Mind map for a stock trading app PRD

**Mermaid DSL:**
```mermaid
mindmap
  root((股票交易 App PRD))
    账户体系
      注册 / 登录
      实名认证 KYC
      账户余额与充提
    行情功能
      实时报价
      K 线图
      盘口数据
    交易功能
      限价委托
      市价委托
      条件单
      撤单管理
    持仓管理
      当前持仓
      历史成交
      盈亏分析
    通知中心
      成交提醒
      涨跌预警
      系统公告
```
