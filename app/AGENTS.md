---
type: Folder Contract
title: app/ conventions
description: Application source code conventions; standard Rails layout with UI components under app/ui/.
tags: [agents, app, rails]
timestamp: '2026-06-25T00:00:00Z'
---

# Purpose

Application source code. Standard Rails layout with one deviation: UI components live in `app/ui/` ([ADR-0006](../docs/adr/0006-presentation-layer-organization.md)).

# Ownership

All runtime application code. This doc covers the folders without their own `AGENTS.md`: `app/helpers/`, `app/assets/`, `app/javascript/`, `app/jobs/`. Sibling subdirectories with dedicated `AGENTS.md` (models, services, controllers, ui, views) own their local rules.

## JavaScript Controllers (`app/javascript/controllers/`)

- `ui_state_controller.js` — generalized `sessionStorage` persistence. Manages a boolean `open` state with a `toggle` action. Exposes static `read(key, name)` / `write(key, name, value)` so other controllers reuse it without mounting.
- Other controllers needing persistence import and use `UiStateController.read/write` rather than touching `sessionStorage` directly.
- Stimulus registration lives in `index.js` — keep alphabetical-ish, one `import`+`register` pair per controller.

# Local Contracts

- No business logic in controllers — delegate to services or models.
- Services are the boundary for multi-step operations.
- UI layer uses Phlex exclusively (no ERB for components).
