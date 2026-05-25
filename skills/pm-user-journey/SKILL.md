---
name: pm-user-journey
description: Convert a user experience path description into a professional user journey diagram PNG using Mermaid CLI. Suitable for UX reviews, pain point identification, and new feature path analysis. Rendered by Mermaid — not by Claude.
---

# PM User Journey Skill

## Use Cases

- New user onboarding full-process experience mapping
- Key feature usage path analysis
- Pain point identification and experience optimization
- Multi-role business process mapping

## Execution Steps

1. **Parse the user's description** — identify the user type, journey phases, user tasks per phase, and sentiment score (1–5, where 5 is most positive).

2. **Write Mermaid DSL** to a temp file. Use `journey` syntax.

   DSL template:
   ```mermaid
   journey
       title 用户旅程：[场景名称]
       section 阶段一：[阶段名]
           任务描述 1: 3: 用户
           任务描述 2: 2: 用户, 客服
       section 阶段二：[阶段名]
           任务描述 3: 5: 用户
           任务描述 4: 4: 用户
       section 阶段三：[阶段名]
           任务描述 5: 1: 用户
   ```

   Syntax rules:
   - `title` — overall journey title
   - `section Phase` — a journey phase (column group)
   - `Task description: score: Actor1, Actor2` — one task with sentiment score
   - Score: 1 (very frustrated) → 5 (very happy)
   - Multiple actors separated by comma

   All text may be in Chinese.

3. **Write DSL to file and render:**
   ```bash
   MMD_FILE="/tmp/journey_$(date +%Y%m%d_%H%M%S).mmd"
   # Write the Mermaid DSL to $MMD_FILE
   PNG_FILE=$(bash ~/futu-pm-ai-toolkit/scripts/render-mermaid.sh "$MMD_FILE")
   open "$PNG_FILE"
   ```

4. **Report** the PNG file path to the user.

## Example

**Input:** Draw the user journey for a new user opening a Futu securities account: from awareness to first trade

**Mermaid DSL:**
```mermaid
journey
    title 新用户开户旅程：富途证券
    section 发现阶段
        看到广告或朋友推荐: 4: 用户
        下载 App: 3: 用户
    section 注册阶段
        填写手机号注册: 4: 用户
        设置交易密码: 3: 用户
    section 实名认证
        上传身份证照片: 2: 用户
        等待审核（1-3天）: 1: 用户
        收到审核通过通知: 5: 用户
    section 入金阶段
        绑定银行卡: 3: 用户
        完成首次入金: 3: 用户
    section 首次交易
        搜索目标股票: 4: 用户
        下达第一笔委托: 4: 用户
        成交并查看持仓: 5: 用户
```
