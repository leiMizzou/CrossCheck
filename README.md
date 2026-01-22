# Crosscheck Skill

Multi-model cross-verification skill for Claude Code using Claude, Codex, and Gemini.

## What is this?

A Claude Code skill that queries multiple AI models and has them review each other's answers to produce more reliable conclusions.

## Process Flow

```
/crosscheck <question>
       │
       ▼
┌──────────────────────────────────────┐
│ Round 1: Parallel Independent Answers │
│ • Claude (main model)                 │
│ • Codex (bypass mode)                 │
│ • Gemini (yolo mode)                  │
└──────────────────┬───────────────────┘
                   ▼
┌──────────────────────────────────────┐
│ Round 2: Cross Review                 │
│ • Codex reviews Claude + Gemini       │
│ • Gemini reviews Claude + Codex       │
│ • Claude reviews Codex + Gemini       │
└──────────────────┬───────────────────┘
                   ▼
┌──────────────────────────────────────┐
│ Round 3: Synthesize Conclusion        │
│ • Consensus points                    │
│ • Disputed points                     │
│ • Corrections                         │
│ • Final answer                        │
└──────────────────────────────────────┘
```

## Requirements

- [Claude Code](https://claude.ai/claude-code) CLI installed
- Codex MCP server configured
- Gemini MCP server configured

## Installation

1. Clone this repo or copy the `.claude/skills/crosscheck/` directory to your project
2. Ensure Codex and Gemini MCP servers are configured in Claude Code

## Usage

```bash
# In Claude Code
/crosscheck Do we still need vertical models in the era of large language models?
```

## Output

The skill produces:
- A structured comparison table of all three models' answers
- Cross-review comments from each model
- A synthesized final conclusion with corrections
- A log file saved to `logs/` directory

## License

MIT
