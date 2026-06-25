---
type: Folder Contract
title: config/ contract
description: 'Rails configuration conventions: routes, locales, production DB.'
tags: [agents, dox, config]
timestamp: '2026-06-11T07:19:49Z'
---

# Purpose

Rails configuration.

# Local Contracts

- Routes use `param: :slug` for users (not `:id`). Users nested: `/u/:slug/`.
- Two locales: `en` (default), `pt-BR`. Add keys to both when adding user-facing text.
- Production DB: `/var/data/production.sqlite3` (Render persistent disk).
- Phlex autoload path registered in `initializers/phlex.rb`.
