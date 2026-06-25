# Architecture Decision Records

Each ADR captures a single hard-to-reverse decision: context, decision, and consequences. Status follows the entry.

# Data model

* [ADR-0001](0001-sticker-catalog-as-seeded-table.md) — _accepted_ — The 994-sticker catalog is a seeded `stickers` table with a `user_stickers` pivot for per-user copies.
* [ADR-0008](0008-sticker-trader-as-source-of-truth.md) — _accepted_ — Sticker Trader owns collection state; trades mutate `user_stickers`. Supersedes ADR-0005.

# Trades

* [ADR-0002](0002-trade-comparisons-are-computed.md) — _accepted_ — Trade comparisons are computed on-the-fly from live `user_stickers`, not persisted.
* [ADR-0005](0005-trade-export-is-virtual.md) — _superseded by ADR-0008_ — Original decision to keep collections unchanged on trade consolidation.

# UI & i18n

* [ADR-0004](0004-i18n-relative-keys-phlex.md) — _accepted_ — All Phlex views/components use class-relative translation keys (`t(".key")`).
* [ADR-0006](0006-presentation-layer-organization.md) — _accepted_ — Split presentation into `app/views/` (route-backed pages) and `app/ui/` (components, fragments, layouts).

# Testing

* [ADR-0003](0003-testing-strategy.md) — _accepted_ — Minitest with seeded catalog, inline setup via real parsers, rendered Phlex assertions; no factories.

# Documentation

* [ADR-0007](0007-adapted-dox-mirror-tree.md) — _accepted_ — Folder-contract docs are co-located `AGENTS.md` files inside the source folders they govern.
* [ADR-0009](0009-okf-as-documentation-format.md) — _accepted_ — Adopt OKF v0.1 as the documentation format; retire the explicit DOX framework while keeping co-location and update discipline.
