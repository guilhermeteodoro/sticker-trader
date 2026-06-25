---
type: Folder Contract
title: app/ui/ conventions
description: Phlex-based presentation layer with components (domain-free atoms), fragments (domain-aware compositions), and layouts (page shells).
tags: [agents, ui, phlex]
timestamp: '2026-06-25T00:00:00Z'
---

# Purpose

Phlex-based presentation layer. Replaces `app/views/` for component rendering ([ADR-0006](../../docs/adr/0006-presentation-layer-organization.md)).

# Ownership

- `components/` — generic reusable atoms (no domain knowledge).
- `fragments/` — domain-aware composable pieces.
- `layouts/` — page wrappers (application layout).

This doc owns `layouts/`. Components and fragments have their own `AGENTS.md`.

# Local Contracts

- Namespace: `UI::Components::`, `UI::Fragments::`, `UI::Layouts::`.
- Components are domain-free. If it needs sticker/trade knowledge → fragment.
- Fragments receive pre-loaded data (arrays, objects) — they don't execute queries.
- Full-page views live in `app/views/` under `Views::` — they compose fragments.

# Work Guidance

- Test rendering via `ComponentTestHelper` — assert HTML with Nokogiri.
- i18n: use relative keys per [ADR-0004](../../docs/adr/0004-i18n-relative-keys-phlex.md).

# Mobile UX

- `touch-action: manipulation` is set globally on `<html>` (in `app/assets/stylesheets/application.css`) to prevent double-tap-to-zoom. Pinch-zoom remains available. Do not remove — album card +/− buttons trigger accidental zoom otherwise.
