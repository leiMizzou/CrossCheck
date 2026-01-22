# CrossCheck

Multi-model cross-verification skill for Claude Code using Claude, Codex, and Gemini.

## Skill: /crosscheck

3-round verification process:
1. **Round 1**: Independent answers from Claude, Codex, Gemini (parallel)
2. **Round 2**: Each model reviews the other two
3. **Round 3**: Synthesize final conclusion

**Usage**: `/crosscheck <question>`

## MCP Tool Calls

```javascript
// Codex (bypass mode)
mcp__codex__codex({ prompt: "...", "approval-policy": "never", sandbox: "danger-full-access" })

// Gemini (yolo mode)
mcp__gemini__gemini({ prompt: "...", yolo: true })
```

## Structure

```
.claude/skills/crosscheck/SKILL.md  # Skill definition
logs/                               # Verification logs
```
