# Rails App — Task Plan

> **Note to agents/bots:** Update this file as you complete tasks (check them off) or
> change the plan (add/remove/reorder tasks). This is the living source of truth for
> implementation progress.

## Phase 1: Project setup
- [ ] Generate Rails 8 app (PostgreSQL, skip test for now, skip Action Mailer)
- [ ] Install and configure Phlex
- [ ] Install and configure RubyUI + Tailwind CSS
- [ ] Set up base layout (Phlex component with RubyUI)
- [ ] Configure Render deployment (render.yaml, Dockerfile or buildpack)

## Phase 2: Sticker catalog
- [ ] Create `stickers` migration (team, number, category enum, position)
- [ ] Create `Sticker` model with validations
- [ ] Write seed file with all 994 stickers (team order, FWC 00–19, CC 1–14, teams 1–20)
- [ ] Add category logic (shiny/coke/normal classification)
- [ ] Verify seed: `Sticker.count == 994`, category counts match (69/14/911)

## Phase 3: Users + collections
- [ ] Create `users` migration (slug, name)
- [ ] Create `User` model with slug generation
- [ ] Create `user_stickers` migration (user_id, sticker_id, copies, unique index)
- [ ] Create `UserSticker` model
- [ ] Implement session-based auth (cookie login on account creation)
- [ ] Build registration flow controller + views

## Phase 4: Import parsers
- [ ] Build dump parser service (`DumpParser`) — parse `SA26|1|...|...` into owned IDs + duplicate counts
- [ ] Build manual parser service (`ManualParser`) — parse missing text + duplicates text
- [ ] Build import service (`CollectionImporter`) — takes parsed data, wipes + recreates `user_stickers` rows
- [ ] Wire parsers to registration form (choose input method, paste, submit)

## Phase 5: Collection pages
- [ ] Build public collection page `/u/:slug` (stats + duplicates grouped by team)
- [ ] Build logged-in view of own collection (stats + update button)
- [ ] Build update flow (re-import form, same parsers, wipe + replace)

## Phase 6: Trade comparison
- [ ] Build `TradeComparer` service — takes two users, returns structured result (a_gives_b, b_gives_a by category)
- [ ] Build `BalancedTradeBuilder` — computes balanced suggestion + leftovers
- [ ] Build trade comparison view (shown on `/u/:slug` when logged in as different user)
- [ ] Group output by team, separate sections: full diff, balanced suggestion, leftovers

## Phase 7: Polish + deploy
- [ ] Landing page (explain what the app does, CTA to register)
- [ ] Error handling (invalid dump format, empty paste, etc.)
- [ ] Mobile-friendly layout (sticker trading happens on phones)
- [ ] Deploy to Render (web service + Postgres + seed)
- [ ] Smoke test with real dumps
