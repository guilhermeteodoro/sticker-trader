---
name: adr-workflow
description: Create and manage Architecture Decision Records for documenting significant technical decisions
---

## When to Create an ADR

All three must be true:

1. **Hard to reverse** — the cost of changing your mind later is meaningful
2. **Surprising without context** — a future reader will wonder "why did they do it this way?"
3. **The result of a real trade-off** — there were genuine alternatives and you picked one for specific reasons

If any is missing, skip the ADR.

## Before Implementing

Check existing ADRs:

```bash
adr list
```

Read any that relate to your work area. Verify your implementation aligns.

## Commands

```bash
adr list                    # List all ADRs
adr new "Title"             # Create new ADR
adr new -s N "Title"        # Create ADR that supersedes ADR N
```

## Format

ADRs are lightweight. A title and one to three sentences is enough:

```markdown
# Short title of the decision

{1-3 sentences: what's the context, what did we decide, and why.}
```

### Optional sections

Only include when they add genuine value:

- **Status** (`proposed | accepted | deprecated | superseded by ADR-NNNN`) — when decisions are revisited
- **Considered Options** — only when rejected alternatives are worth remembering
- **Consequences** — only when non-obvious downstream effects need calling out

## Location

`docs/adr/` — numbered sequentially (e.g., `0006-title.md`).

## What Qualifies

- Technology choices that carry lock-in
- Integration patterns between systems
- Deliberate deviations from the obvious path
- Boundary and scope decisions
- Constraints not visible in the code
- Rejected alternatives when the rejection is non-obvious

## What Doesn't Qualify

- Easy-to-reverse decisions (just reverse them)
- Obvious choices with no real alternative
- Implementation details (those go in code comments)
- Domain language (that goes in CONTEXT.md)
