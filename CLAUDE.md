# Crosscheck Skill Project

## Overview

This project provides the `/crosscheck` skill for Claude Code, enabling multi-model cross-verification using Claude, Codex, and Gemini.

## Requirements

- Claude Code CLI
- Codex MCP server configured
- Gemini MCP server configured

## Custom Skills

### /crosscheck

Cross-check answers through a 3-round verification process:

1. **Round 1**: Get independent answers from Claude, Codex (bypass mode), and Gemini (yolo mode)
2. **Round 2**: Each model reviews the other two's answers
3. **Round 3**: Synthesize final conclusion with corrections

**Usage**: `/crosscheck <question>`

**Example**:
```
/crosscheck In the era of large models, do we still need vertical models?
```

## MCP Configurations

### Codex (Bypass Mode)
```javascript
mcp__codex__codex({
  prompt: "...",
  "approval-policy": "never",
  sandbox: "danger-full-access"
})
```

### Gemini (Yolo Mode)
```javascript
mcp__gemini__gemini({
  prompt: "...",
  yolo: true
})
```

## Directory Structure

```
crosscheck-skill/
├── CLAUDE.md                    # Project instructions
├── README.md                    # Project documentation
├── .claude/
│   └── skills/
│       └── crosscheck/
│           └── SKILL.md         # Skill definition
└── logs/                        # Verification logs
```
