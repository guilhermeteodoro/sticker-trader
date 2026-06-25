---
type: Architecture Decision Record
title: 'ADR-0007: Co-located AGENTS.md as folder contracts'
description: Each governed source folder carries an AGENTS.md describing its local contract; the file lives alongside the code so agents always discover it.
tags: [adr, agents, docs, accepted]
timestamp: '2026-06-25T00:00:00Z'
---

# 7. Co-located AGENTS.md as folder contracts

Date: 2026-06-10 (updated 2026-06-25)

## Status

Accepted. Originally framed as a DOX-framework convention; reframed under [ADR-0009](0009-okf-as-documentation-format.md) as an OKF `Folder Contract` concept — the co-location rule itself is unchanged.

## Context

An earlier adaptation kept folder contracts in a hidden `.agents/dox/` mirror tree. Hidden directories don't appear in workspace listings, so agents consistently skipped the "read folder docs before editing" step — they never encountered the files during normal navigation.

The upstream convention (co-located `AGENTS.md` inside each governed folder) solves this: agents see the file every time they `read` a directory before editing files in it.

## Decision

Folder-contract docs are co-located `AGENTS.md` files inside the source folders they govern:

- `app/controllers/AGENTS.md` governs `app/controllers/`
- `app/ui/fragments/AGENTS.md` governs `app/ui/fragments/`

The root `AGENTS.md` carries project-wide conventions and is the entry point.

## Consequences

- **Discoverable**: agents see `AGENTS.md` in every directory listing — impossible to miss.
- **One extra file per governed folder**: minimal visual noise (one markdown file alongside source).
- **No path transform needed**: the file is where it governs.
- **Renames track automatically**: moving a folder moves its `AGENTS.md` with it.
- **Harness-compatible**: `AGENTS.md` is auto-loaded by common agent harnesses (Claude Code, Cursor) as project context.
