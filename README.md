# CrossCheck

Multi-model cross-verification skill for Claude Code. Query Claude, Codex, and Gemini simultaneously, then have them review each other's answers.

## One-Line Install

```bash
git clone https://github.com/your-username/CrossCheck.git && cd CrossCheck && ./install.sh
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
│ Claude + Codex + Gemini    │
└──────────────┬─────────────┘
               ▼
┌────────────────────────────┐
│ Round 2: Cross Review      │
│ Each critiques the others  │
└──────────────┬─────────────┘
               ▼
┌────────────────────────────┐
│ Round 3: Final Conclusion  │
└────────────────────────────┘
```

## Usage

```bash
/crosscheck Do we still need vertical models in the era of LLMs?
/crosscheck What's the best approach for real-time collaboration?
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
curl -sL https://raw.githubusercontent.com/your-username/CrossCheck/main/.claude/skills/crosscheck/SKILL.md \
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
