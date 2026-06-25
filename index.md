---
okf_version: "0.1"
---

This bundle is the Sticker Trader project's knowledge corpus — the docs an agent or human reads to understand the app, its conventions, and its history. Format follows [OKF v0.1](https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/main/okf/SPEC.md).

# Start here

* [Sticker Trader](README.md) — what the app does, tech stack, how to run it.
* [Agent instructions](AGENTS.md) — project-wide conventions and safety rules for AI coding agents. Always read first.
* [Domain glossary](CONTEXT.md) — terms and components defining the Sticker Trader domain language.

# Planning & operations

* [Implementation task plan](TASKS.md) — living phase checklist.
* [Operational safety rules](RULES.md) — destructive-command rules.

# Architecture decisions

* [docs/adr/](docs/adr/) — every hard-to-reverse decision, grouped by area.

# Folder contracts

Co-located `AGENTS.md` files describe the local rules of each source folder ([ADR-0007](docs/adr/0007-adapted-dox-mirror-tree.md)).

* [app/](app/AGENTS.md) — application source code (Rails layout with `app/ui/`).
* [app/models/](app/models/AGENTS.md) — domain entities, soft delete, trade lifecycle invariants.
* [app/services/](app/services/AGENTS.md) — service objects for multi-step operations.
* [app/controllers/](app/controllers/AGENTS.md) — HTTP handlers, auth, trade and receipt lifecycle.
* [app/views/](app/views/AGENTS.md) — full-page Phlex view classes.
* [app/ui/](app/ui/AGENTS.md) — Phlex presentation layer (components, fragments, layouts).
* [app/ui/components/](app/ui/components/AGENTS.md) — generic reusable UI atoms.
* [app/ui/fragments/](app/ui/fragments/AGENTS.md) — domain-aware UI compositions.
* [config/](config/AGENTS.md) — Rails configuration (routes, locales, production DB).
* [db/](db/AGENTS.md) — schema, migration, and seed conventions.
* [test/](test/AGENTS.md) — Minitest suite conventions.

# Reference data

* [docs/groups/](docs/groups/) — sticker catalog group listings (per-team rosters used during seed maintenance).
