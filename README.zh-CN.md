# CrossCheck

**通过多模型共识减少 AI 幻觉**

[English](README.md) | 中文

一个 Claude Code 技能，同时查询 Claude、Codex 和 Gemini，然后让每个模型互相审查对方的答案，以产生更可靠的结论。

## 为什么选择 CrossCheck？

| 问题 | 解决方案 |
|------|----------|
| 单一 AI 模型会产生幻觉 | 3 个模型互相交叉验证 |
| 无法判断答案是否错误 | 分歧会暴露错误 |
| 推理存在盲点 | 不同模型能发现不同问题 |

**结果**：为关键决策提供更高置信度的答案。

## 一键安装

```bash
git clone https://github.com/leiMizzou/CrossCheck.git && cd CrossCheck && ./install.sh
```

> **提示**：如果已安装旧版本，使用 `./install.sh --force` 强制重新安装/更新 CLI。

然后登录并重启：
```bash
codex        # 登录 OpenAI（仅首次需要）
gemini       # 登录 Google（仅首次需要）
/exit        # 重启 Claude Code 以加载 MCP 工具
```

## 工作原理

```
/crosscheck <问题>
       │
       ▼
┌────────────────────────────┐
│ Round 1: 独立回答          │
│ Claude + Codex + Gemini    │  ← 3 个模型独立回答
└──────────────┬─────────────┘
               │
       ┌───────┴───────┐
       │ 高度共识？     │  ← 智能短路
       └───────┬───────┘
          否   │   是 → 快速共识模式（跳过 R2/R3）
               ▼
┌────────────────────────────┐
│ Round 2: 交叉审查          │  ← 每个模型审查另外两个
│ 找出错误和盲点             │
└──────────────┬─────────────┘
               ▼
┌────────────────────────────┐
│ Round 3: 最终结论          │  ← 综合共识与修正
└────────────────────────────┘
```

## 核心特性

| 特性 | 描述 |
|------|------|
| **智能短路** | 当所有模型一致时跳过 Round 2/3（节省时间和成本） |
| **容错机制** | 一个模型失败时继续运行（降级模式） |
| **结构化输出** | 清晰的表格展示模型状态和验证模式 |
| **自动日志** | 结果保存到 `logs/` 以便审计追溯 |

## 使用方法

```bash
/crosscheck 在大模型时代，我们还需要训练垂直领域模型吗？
/crosscheck 实现实时协作的最佳方案是什么？
/crosscheck 这个项目适合用微服务架构吗？
```

## 输出示例

```markdown
## 交叉验证结果：在大模型时代还需要垂直模型吗？

**模式**：完整验证

### Round 1: 独立回答
| 模型   | 状态 | 核心观点 | 关键点 |
|--------|------|----------|--------|
| Claude | OK | 是的，适用于监管行业 | 数据隐私、合规性 |
| Codex  | OK | 取决于规模 | 成本与准确性权衡 |
| Gemini | OK | 混合方案 | 结合通用与专用模型 |

### Round 2: 交叉审查
- Codex 发现 Claude 夸大了合规要求
- Gemini 指出 Codex 的成本假设已过时
- Claude 发现两者都遗漏了边界情况

### Round 3: 最终结论
| 共识 | 三方一致认为垂直模型在医疗、金融领域仍有价值 |
| 修正 | 根据审查更新了成本分析 |
| 结论 | 大多数场景推荐混合方案 |
```

## 手动安装

<details>
<summary>点击展开</summary>

```bash
# 1. 安装 CLI（锁定版本）
npm install -g @openai/codex@0.1 @google/gemini-cli@0.1

# 2. 添加 MCP 服务
claude mcp add codex -- codex mcp-server
claude mcp add gemini -- npx -y gemini-mcp-tool@0.1.8

# 3. 复制技能文件
mkdir -p .claude/skills/crosscheck
curl -sL https://raw.githubusercontent.com/leiMizzou/CrossCheck/main/.claude/skills/crosscheck/SKILL.md \
  -o .claude/skills/crosscheck/SKILL.md

# 4. 登录并重启
codex && gemini && echo "现在运行 /exit 重启 Claude Code"
```

**注意**：需要预先安装 Node.js 和 Claude Code CLI。

</details>

## 验证安装

```bash
claude mcp list
# codex: codex mcp-server - ✓ Connected
# gemini: npx -y gemini-mcp-tool - ✓ Connected
```

## 常见问题

| 问题 | 解决方案 |
|------|----------|
| MCP "Failed to connect" | 先运行 `codex` 或 `gemini` 登录 |
| 工具不可用 | 重启 Claude Code：`/exit` 然后 `claude` |

## 相关链接

- [Codex CLI](https://developers.openai.com/codex/cli/)
- [Gemini CLI](https://github.com/google-gemini/gemini-cli)
- [gemini-mcp-tool](https://github.com/jamubc/gemini-mcp-tool)

## 许可证

MIT
