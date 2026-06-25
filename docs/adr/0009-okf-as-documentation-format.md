---
type: Architecture Decision Record
title: 'ADR-0009: Adopt OKF as the documentation format; retire explicit DOX framework'
description: Consolidate folder-contract docs and project knowledge under OKF v0.1; keep co-location and update discipline, drop the standalone DOX framework explanation.
tags: [adr, docs, okf, accepted]
timestamp: '2026-06-25T00:00:00Z'
---

# 9. Adopt OKF as the documentation format; retire explicit DOX framework

Date: 2026-06-25

## Status

Accepted

## Context

The repository previously used [DOX](https://github.com/agent0ai/dox) as its documentation framework. DOX in this repo did two things:

1. Established a **co-location convention**: each significant source folder carries an `AGENTS.md` describing the local contract (formalized in [ADR-0007](0007-adapted-dox-mirror-tree.md)).
2. Documented a **meta-process** in the root `AGENTS.md` — ~80 lines explaining the framework: read-before-editing, update-after-editing, hierarchy rules, default section templates, closeout checklists, style notes.

Independently, the project adopted [Google's Open Knowledge Format (OKF v0.1)](https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/main/okf/SPEC.md) as the on-disk format for all markdown documentation: YAML frontmatter with `type`, optional `title`/`description`/`tags`/`timestamp`, and reserved `index.md` / `log.md` filenames for progressive disclosure.

OKF and DOX overlap on hierarchy, discoverability, and update discipline. After adoption, much of the DOX framework explanation became a paraphrase of OKF conventions — duplicating navigation rules already implied by the format.

## Decision

Make OKF the documentation format and absorb DOX's still-useful conventions into a short "Knowledge & documentation" section of the root `AGENTS.md`:

- **Format** is OKF (frontmatter + `type` + index.md + cross-links).
- **Folder contracts** remain co-located `AGENTS.md` files of type `Folder Contract` ([ADR-0007](0007-adapted-dox-mirror-tree.md) still stands).
- **Read-before-edit** and **update-after-edit** discipline is preserved as a few-line instruction, not a separate framework chapter.
- **Per-folder "Child DOX Index" sections are dropped** — they restated what `ls` and [index.md](../../index.md) already convey.
- The `DOX` framework name is no longer referenced in repo documentation.

## Consequences

- Root `AGENTS.md` shrinks substantially; the doc reads as project conventions rather than framework documentation.
- One source of truth for navigation: OKF's `index.md` at the bundle root.
- New folders that warrant a contract still get an `AGENTS.md` — naming is unchanged for harness discoverability (Claude Code, Cursor, etc. auto-load `AGENTS.md`).
- Agents that were previously instructed to "read the DOX chain" now read the chain of co-located `AGENTS.md` files; behaviour is identical.
- ADR-0007 (co-located AGENTS.md) is reinforced, not superseded — its rationale (discoverability) carries forward.
