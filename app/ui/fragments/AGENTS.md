# Purpose

Domain-specific composable UI pieces.

# Local Contracts

- `StickerList` — groups stickers by country, renders as monospace `CODE: 1, 2, 3`. Optional `copyable: true` for clipboard button.
- `AlbumGrid` — interactive card grid. Each card is a wrapper with two layers: a placeholder (always present, shows sticker slot) and a top card (colored, visible when owned). Uses `album-card` Stimulus controller for click-to-glue, +/- copies, and state transitions. Split click zones: top-right quarter creates `to_be_glued`, elsewhere creates `glued`. To-be-glued cards show a folded corner with rotation/offset over their placeholder.
- `CollectionImporter` — shared between registration and collection edit. Contains combobox (import method), textareas, and video tutorial dialog.
- Fragments receive data, don't query. Compose RubyUI components internally.
