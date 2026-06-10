# Purpose

Database schema, migrations, and seed data.

# Local Contracts

- Catalog is immutable at runtime (ADR-0001). Seeds load 994 stickers across 49 countries.
- Migrations are append-only in production.
- Test suite shares seeded catalog via transactional rollback.
- All tables have `deleted_at` column for soft deletion (discard gem, `default_scope -> { kept }` in ApplicationRecord).
- `user_stickers.state` is a string column (`glued`, `duplicate`, `to_be_glued`). No DB-level default — model owns defaults.
- Partial unique index `index_user_stickers_unique_glued` on `[user_id, sticker_id] WHERE state = 'glued' AND deleted_at IS NULL` prevents double-glue.
- Schema conventions: models own defaults and validations; DB constraints only for race conditions and data integrity (see root AGENTS.md).
