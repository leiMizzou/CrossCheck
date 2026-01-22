# 微信朋友圈 Marketing Content

## 完整版

```
🚀 开源了一个小工具：CrossCheck

做 AI 开发的朋友应该都遇到过这个问题：大模型回答得很自信，但你不确定它是不是在一本正经地胡说八道。

于是我做了这个工具 —— 让 Claude、Codex、Gemini 三个模型互相"对质"：

【工作原理】
Round 1: 三个模型独立回答同一问题
Round 2: 每个模型审查另外两个的答案，找错误和盲点
Round 3: 综合所有意见，输出最终结论

【亮点】
• 智能短路：答案一致时跳过审查，省时省钱
• 容错机制：一个模型挂了，剩下两个继续
• 自动日志：方便追溯决策依据

【适用场景】
技术选型、架构评审、复杂问题求证……任何你需要"第二意见"的时候。

一行命令安装，开箱即用 👇
github.com/leiMizzou/CrossCheck

用 AI 监督 AI，以毒攻毒 😄
```

---

## 简短版

```
开源了一个让 Claude、Codex、Gemini 互相"对质"的工具，三轮交叉验证减少 AI 幻觉。

用 AI 监督 AI，以毒攻毒 🔍

👉 github.com/leiMizzou/CrossCheck
```

---

## 技术圈版（适合技术群/公众号）

```
【开源项目】CrossCheck - 多模型交叉验证工具

解决痛点：单一大模型容易产生幻觉，无法自我纠错

技术方案：
• 并行调用 Claude + Codex + Gemini
• 3 轮交叉验证（独立回答 → 互相审查 → 综合结论）
• 基于 Claude Code MCP 协议实现

特性：
✅ 智能短路 - 高共识时跳过审查轮次
✅ 容错降级 - 支持 2/3 模型运行
✅ 版本锁定 - 依赖可复现
✅ 结构化输出 - Mode/Status 状态追踪

安装：
git clone https://github.com/leiMizzou/CrossCheck
cd CrossCheck && ./install.sh

GitHub: github.com/leiMizzou/CrossCheck
```
