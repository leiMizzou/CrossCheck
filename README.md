# CrossCheck

**Reduce AI hallucinations through multi-model consensus.**

English | [中文](README.zh-CN.md)

> **Part of [CC Suite](https://github.com/leiMizzou/CC-Suite)** - The Standard Library for Claude Code Workflows

A Claude Code skill that queries Claude, Codex, and Gemini simultaneously, then has each model critique the others' answers to produce more reliable conclusions.

## Why CrossCheck?

| Problem | Solution |
|---------|----------|
| Single AI models hallucinate | 3 models cross-verify each other |
| No way to know if answer is wrong | Disagreements surface errors |
| Blind spots in reasoning | Different models catch different issues |

**Result**: Higher confidence answers for critical decisions.

## One-Line Install

```bash
git clone https://github.com/leiMizzou/CrossCheck.git && cd CrossCheck && ./install.sh
```

> **Tip**: Use `./install.sh --force` to reinstall/update CLIs if you have older versions.

Then login and restart:
```bash
codex        # Login to OpenAI (first time only)
gemini       # Login to Google (first time only)
/exit        # Restart Claude Code to load MCP tools
```

## How It Works

```
/crosscheck <question>
       │
       ▼
┌────────────────────────────┐
│ Round 1: Independent       │
│ Claude + Codex + Gemini    │  ← 3 models answer independently
└──────────────┬─────────────┘
               │
       ┌───────┴───────┐
       │ High Consensus?│  ← Smart Short-Circuit
       └───────┬───────┘
          No   │   Yes → Fast Consensus Mode (skip R2/R3)
               ▼
┌────────────────────────────┐
│ Round 2: Cross Review      │  ← Each critiques the other two
│ Find errors & blind spots  │
└──────────────┬─────────────┘
               ▼
┌────────────────────────────┐
│ Round 3: Final Conclusion  │  ← Synthesize consensus + corrections
└────────────────────────────┘
```

## Key Features

| Feature | Description |
|---------|-------------|
| **Smart Short-Circuit** | Skip Round 2/3 when all models agree (saves time & cost) |
| **Fault Tolerance** | Continues with 2 models if one fails (degraded mode) |
| **Structured Output** | Clear tables with model status and verification mode |
| **Auto Logging** | Saves results to `logs/` for audit trail |

## Usage

```bash
/crosscheck Do we still need vertical models in the era of LLMs?
/crosscheck What's the best approach for real-time collaboration?
/crosscheck Is microservices the right architecture for this project?
```

## Output Example

```markdown
## Cross-Check Results: Do we still need vertical models?

**Mode**: Full Verification

### Round 1: Independent Answers
| Model  | Status | Core View | Key Points |
|--------|--------|-----------|------------|
| Claude | OK | Yes, for regulated industries | Data privacy, compliance |
| Codex  | OK | Depends on scale | Cost vs accuracy tradeoff |
| Gemini | OK | Hybrid approach | Combine general + specialized |

### Round 2: Cross Review
- Codex found Claude overstated compliance requirements
- Gemini caught outdated cost assumptions in Codex's answer
- Claude identified missing edge cases in both

### Round 3: Final Conclusion
| Consensus | All agree vertical models valuable for healthcare, finance |
| Corrections | Updated cost analysis based on reviews |
| Final | Hybrid approach recommended for most use cases |
```

## Manual Install

<details>
<summary>Click to expand</summary>

```bash
# 1. Install CLIs (with version pinning)
npm install -g @openai/codex@0.1 @google/gemini-cli@0.1

# 2. Add MCP servers
claude mcp add codex -- codex mcp-server
claude mcp add gemini -- npx -y gemini-mcp-tool@0.1.8

# 3. Copy skill
mkdir -p .claude/skills/crosscheck
curl -sL https://raw.githubusercontent.com/leiMizzou/CrossCheck/main/.claude/skills/crosscheck/SKILL.md \
  -o .claude/skills/crosscheck/SKILL.md

# 4. Login & restart
codex && gemini && echo "Now run /exit to restart Claude Code"
```

**Note**: Requires Node.js and Claude Code CLI installed.

</details>

## Verify

```bash
claude mcp list
# codex: codex mcp-server - ✓ Connected
# gemini: npx -y gemini-mcp-tool - ✓ Connected
```

## Troubleshooting

| Problem | Solution |
|---------|----------|
| MCP "Failed to connect" | Run `codex` or `gemini` to login first |
| Tool not available | Restart Claude Code: `/exit` then `claude` |

## Links

- [Codex CLI](https://developers.openai.com/codex/cli/)
- [Gemini CLI](https://github.com/google-gemini/gemini-cli)
- [gemini-mcp-tool](https://github.com/jamubc/gemini-mcp-tool)

## Community

Questions or suggestions? Join our WeChat group:

<table>
  <tr>
    <td align="center">
      <img src="./assets/wechat-group.jpg" width="200" alt="WeChat Group"/>
      <br/>
      <b>Scan to Join Group</b>
    </td>
    <td align="center">
      <img src="./assets/wechat-helper.jpg" width="200" alt="WeChat Helper"/>
      <br/>
      <b>Add Helper if QR Expired</b>
    </td>
  </tr>
</table>

## License

MIT
