---
okf_version: "0.1"
---

# Project knowledge

* [Sticker Trader](README.md) - Web app for World Cup 2026 sticker collectors to find and record trades with friends.
* [Domain glossary](CONTEXT.md) - Domain language for the Sticker Trader project: terms, components, and example dialogue.
* [Task plan](TASKS.md) - Living checklist of implementation phases with per-task completion status.
* [Operational rules](RULES.md) - Safety rules agents must follow when operating on this codebase.

# Agent instructions and folder contracts

* [Root agent instructions](AGENTS.md) - Project-wide DOX rail and required checks.
* [app/](app/AGENTS.md) - Application source code conventions and child DOX index.
* [app/services/](app/services/AGENTS.md) - Service object conventions for multi-step operations.
* [app/models/](app/models/AGENTS.md) - Domain entity conventions: associations, soft delete, trade lifecycle.
* [app/controllers/](app/controllers/AGENTS.md) - HTTP request handler conventions.
* [app/ui/](app/ui/AGENTS.md) - Phlex presentation layer conventions.
* [app/ui/fragments/](app/ui/fragments/AGENTS.md) - Domain-specific composable UI pieces.
* [app/ui/components/](app/ui/components/AGENTS.md) - Generic reusable UI atoms.
* [app/views/](app/views/AGENTS.md) - Full-page Phlex view class conventions.
* [test/](test/AGENTS.md) - Test suite conventions (Minitest).
* [config/](config/AGENTS.md) - Rails configuration conventions.
* [db/](db/AGENTS.md) - Database schema, migration, and seed conventions.

# Documentation

* [docs/adr/](docs/adr/) - Architecture Decision Records.
* [docs/groups/](docs/groups/) - Sticker catalog group listings.
