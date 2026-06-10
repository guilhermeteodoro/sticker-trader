# Purpose

Domain entities. Thin models — associations, validations, scopes, computed attributes.

# Local Contracts

- `UserSticker` row exists = owned. No row = missing. `copies` field tracks extras (see CONTEXT.md).
- `Trade` links two users (`user_a`/`user_b`) — order is arbitrary (initiator is `user_a`).
- `TradeSticker` records direction: `giver` and `receiver` per sticker.
- `TradeParticipation` is virtual (ActiveModel, no table) — built by `User#trade_history` from Trade records.
- Sticker catalog is seeded, immutable at runtime (ADR-0001).
- `position` (1–994) is the internal sequential ID used by dump format. `number` is the per-country display number.
