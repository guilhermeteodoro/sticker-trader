# Render Deployment

Check deploy status, view logs, and troubleshoot the sticker-trader service on Render.

## Prerequisites

The Render CLI must be installed and authenticated (`render login`).

## Setup

Before any command, ensure the workspace is set:

```bash
render workspace set tea-d8evfmegvqtc738ngbt0
```

If you get "no workspace set" errors, run this first.

## Service Reference

| Name | ID | URL |
|------|-----|-----|
| sticker-trader | `srv-d8gp0md8nd3s7398tpt0` | https://stickertrader.onrender.com |

The service has a 1GB persistent disk mounted at `/var/data/` where the production SQLite database lives (`/var/data/production.sqlite3`).

## Common Operations

### Check latest deploy status

```bash
render deploys list srv-d8gp0md8nd3s7398tpt0 -o json
```

Status values: `created`, `build_in_progress`, `update_in_progress`, `live`, `deactivated`, `build_failed`, `update_failed`, `canceled`, `pre_deploy_in_progress`, `pre_deploy_failed`.

A successful deploy shows `"status": "live"`.

### View recent logs

```bash
render logs -r srv-d8gp0md8nd3s7398tpt0 --limit 50 -o text
```

### Tail logs (live streaming)

```bash
render logs -r srv-d8gp0md8nd3s7398tpt0 --tail -o text
```

### Filter logs by time window

```bash
render logs -r srv-d8gp0md8nd3s7398tpt0 --start "2026-06-04T15:00:00Z" --end "2026-06-04T15:10:00Z" -o text
```

### Trigger a manual deploy

```bash
render deploys create srv-d8gp0md8nd3s7398tpt0 --confirm -o json
```

### SSH into the running instance

```bash
render ssh srv-d8gp0md8nd3s7398tpt0
```

### Run a one-off command (e.g., rake task, rails console)

```bash
render ssh srv-d8gp0md8nd3s7398tpt0 --ephemeral
# Then inside:
cd /opt/render/project/src
bundle exec rails console
```

## Troubleshooting Deploy Failures

1. **Check deploy status** — is it `build_failed` or `update_failed`?
2. **Check logs** — filter around the deploy's `finishedAt` timestamp
3. **Common issues:**
   - `ConcurrentMigrationError` → db operations must run at startup, not build (already fixed)
   - `Gem::Ext::BuildError` → missing native libs in Render's build environment
   - Asset compilation errors → check `bin/render-build.sh`
   - App boot errors → check `bin/render-start.sh` and startup logs

## Architecture

- **Build phase** (`bin/render-build.sh`): installs gems, node packages, compiles assets. No database access.
- **Start phase** (`bin/render-start.sh`): runs `db:prepare`, `db:seed`, then boots Puma. Database is available here because the disk is mounted.
- Auto-deploys on push to `main`.
