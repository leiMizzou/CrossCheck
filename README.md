# CrossCheck

**Reduce AI hallucinations through multi-model consensus.**

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

## Usage

```bash
/crosscheck Do we still need vertical models in the era of LLMs?
/crosscheck What's the best approach for real-time collaboration?
/crosscheck Is microservices the right architecture for this project?
```

## Output Example

```markdown
## Cross-Check Results

### Round 1: Independent Answers
| Model  | Core View | Key Points |
|--------|-----------|------------|
| Claude | Yes, for regulated industries | Data privacy, compliance |
| Codex  | Depends on scale | Cost vs accuracy tradeoff |
| Gemini | Hybrid approach | Combine general + specialized |

### Round 2: Cross Review
- Codex found Claude overstated compliance requirements
- Gemini caught Codex's cost estimates were outdated
- Claude identified missing edge cases in both

### Round 3: Final Conclusion
✓ Consensus: Vertical models valuable for healthcare, finance
✓ Correction: Training costs dropped 60% since 2024
✓ Final: Hybrid approach recommended for most use cases
```

## Manual Install

<details>
<summary>Click to expand</summary>

```bash
# 1. Install CLIs
npm install -g @openai/codex @google/gemini-cli

# 2. Add MCP servers
claude mcp add codex -- codex mcp-server
claude mcp add gemini -- npx -y gemini-mcp-tool

# 3. Copy skill
mkdir -p .claude/skills/crosscheck
curl -sL https://raw.githubusercontent.com/leiMizzou/CrossCheck/main/.claude/skills/crosscheck/SKILL.md \
  -o .claude/skills/crosscheck/SKILL.md

# 4. Login & restart
codex && gemini && echo "Now run /exit to restart Claude Code"
```

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

## License

MIT
