# CrossCheck

**Reduce AI hallucinations through multi-model consensus.**

## Skill: /crosscheck

3-round verification process:
1. **Round 1**: Independent answers from Claude, Codex, Gemini (parallel)
2. **Round 2**: Each model reviews the other two
3. **Round 3**: Synthesize final conclusion with corrections

**Usage**: `/crosscheck <question>`

## Value

- Surfaces hallucinations through cross-verification
- Catches blind spots via diverse model perspectives
- Produces higher-confidence answers for critical decisions

## MCP Tools

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
install.sh                          # One-line installer
```
