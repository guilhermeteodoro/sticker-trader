# Architecture Decision Records

* [ADR-0001](0001-sticker-catalog-as-seeded-table.md) - Why the 994-sticker catalog is a seeded table with a user_stickers pivot rather than arrays on the user row.
* [ADR-0002](0002-trade-comparisons-are-computed.md) - Why trade comparisons are calculated on-the-fly from live user_stickers data rather than persisted in a table.
* [ADR-0003](0003-testing-strategy.md) - Why we use Minitest with seeds, inline setup via real parsers, and rendered Phlex assertions instead of factories.
* [ADR-0004](0004-i18n-relative-keys-phlex.md) - Why all Phlex views and components use class-relative translation keys (`t(".key")`) instead of full paths.
* [ADR-0005](0005-trade-export-is-virtual.md) - Original decision to keep collections unchanged on trade consolidation; superseded by ADR-0008.
* [ADR-0006](0006-presentation-layer-organization.md) - Split presentation into app/views/ for route-backed pages and app/ui/ for components, fragments, and layouts.
* [ADR-0007](0007-adapted-dox-mirror-tree.md) - Co-locate AGENTS.md inside each governed folder so agents always discover the local DOX contract.
* [ADR-0008](0008-sticker-trader-as-source-of-truth.md) - Sticker Trader owns collection state directly; trades mutate user_stickers; the external app is onboarding only.
