# Purpose

Full-page Phlex view classes rendered by controllers.

# Local Contracts

- Namespace: `Views::{Controller}::{Action}` (e.g., `Views::Users::ShowOwner`)
- Views compose UI fragments and components — no complex logic.
- Initialized with keyword args from controller (the data they need to render).
- One `.text.erb` template exists: `trades/comparison` for clipboard text export.
- `Views::Trades::Show` renders the trade negotiation page: four zones (give/pool per user), sticker chips with add/remove forms, status badges, receipt confirmation section, accept/cancel actions.
- `Views::Trades::Index` renders the user's pending trades dashboard.
- `Views::AnonymousTrades::New` renders the form for recording trades with non-users (one-sided bookkeeping).
- Turbo Frame IDs are defined in the controller and passed to the view as keyword args (e.g., `receipt_frame_id:`, `results_frame_id:`). Views never construct frame IDs themselves — they use the injected value with `turbo_frame(id: @frame_id)`.
