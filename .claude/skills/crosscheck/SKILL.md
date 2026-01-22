---
name: crosscheck
description: Cross-check answers from Claude, Codex, and Gemini through a 3-round verification process. Use when you need reliable answers for complex questions, code review, or technical decisions.
argument-hint: <question>
---

# /crosscheck - Multi-Model Cross Verification

Cross-check answers from Claude, Codex, and Gemini through a 3-round verification process to get more reliable conclusions.

## Execution Process

Execute the following 3-round verification process:

### Round 1: Independent Answers

Simultaneously query three models with the same question:

1. **Claude Code** (main model): Think and answer independently
2. **Codex MCP**: Call with bypass mode
   ```javascript
   mcp__codex__codex({
     prompt: "<question>\n\nPlease analyze from technical and business perspectives, provide your view with specific examples.",
     "approval-policy": "never",
     sandbox: "danger-full-access"
   })
   ```
3. **Gemini MCP**: Call with ask-gemini
   ```javascript
   mcp__gemini__ask-gemini({
     prompt: "<question>\n\nPlease analyze from technical and business perspectives, provide your view with specific examples."
   })
   ```

**IMPORTANT**: Call Codex and Gemini in parallel (single message with both tool calls).

Collect all three answers before proceeding to Round 2.

### Round 2: Cross Review

Each model reviews the other two models' answers. Execute these two calls in parallel:

1. **Codex reviews Claude + Gemini**:
   ```javascript
   mcp__codex__codex({
     prompt: `You are a strict reviewer. Below are two answers about "<question>".

Please review and identify:
1. Points you agree with
2. Points you disagree with or find problematic
3. Important points they missed
4. Any factual errors

---
【Claude's Answer】
<claude_answer>
---
【Gemini's Answer】
<gemini_answer>
---

Please provide your detailed review.`,
     "approval-policy": "never",
     sandbox: "danger-full-access"
   })
   ```

2. **Gemini reviews Claude + Codex**:
   ```javascript
   mcp__gemini__ask-gemini({
     prompt: `You are a strict reviewer. Below are two answers about "<question>".

Please review and identify:
1. Points you agree with
2. Points you disagree with or find problematic
3. Important points they missed
4. Any factual errors

---
【Claude's Answer】
<claude_answer>
---
【Codex's Answer】
<codex_answer>
---

Please provide your detailed review.`
   })
   ```

3. **Claude reviews Codex + Gemini**: Claude (main model) also reviews the other two answers.

### Round 3: Synthesize Conclusion

Based on all reviews, produce:

1. **Consensus points**: What all three models agree on
2. **Disputed points**: Where models disagree and why
3. **Corrections**: Revisions to original answers based on reviews
4. **Final conclusion**: Synthesized, more accurate and nuanced conclusion

## Output Format

Display results in this structure:

```markdown
## Cross-Check Results: <question>

### Round 1: Independent Answers

| Model | Core View | Key Points |
|-------|-----------|------------|
| Claude | ... | ... |
| Codex | ... | ... |
| Gemini | ... | ... |

### Round 2: Cross Review

#### Codex's Review of Claude + Gemini
- **Agrees**: ...
- **Disagrees**: ...
- **Missing**: ...
- **Errors**: ...

#### Gemini's Review of Claude + Codex
- **Agrees**: ...
- **Disagrees**: ...
- **Missing**: ...
- **Errors**: ...

#### Claude's Review of Codex + Gemini
- **Agrees**: ...
- **Disagrees**: ...
- **Missing**: ...
- **Errors**: ...

### Round 3: Final Conclusion

#### Consensus (All Agree)
- ...

#### Corrections Made
| Original Statement | Corrected To |
|-------------------|--------------|
| ... | ... |

#### Final Answer
...
```

## Logging

After completing the verification, save all intermediate results to:
```
logs/{date}_{topic-slug}.md
```

The log file must include:
- Metadata (date, question ID, consistency rating)
- Model configurations used
- All original answers with thread IDs
- All review comments with thread IDs
- Final synthesized conclusion

## Example Usage

```
/crosscheck In the era of large models, do we still need to train vertical/domain-specific models?
```

```
/crosscheck What's the best approach for implementing real-time collaboration in a web app?
```

```
/crosscheck Review this code architecture - is microservices the right choice here?
```
