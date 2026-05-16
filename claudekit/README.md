# claudekit plugin for Claude Code

The Claude Code safety plugin: guardrails, project memory, recovery, and live agent state.

## What this is

claudekit is a Claude Code plugin that installs directly into your editor via `/plugin install`. The free tier gives you guardrails and project memory immediately. Pro adds the Live Control Graph, project brain sync, and disaster recovery snapshots.

The plugin is the product. The SaaS at `app.claudecode-kit.com` is the control plane for Pro entitlement, billing, projects, and history.

## Status: Phase 1 step 3

`/claudekit:self-test` skill added. Plugin-to-MCP-server-to-validate loop is now closeable end-to-end.

Phase 1 step 3 ships:
- `plugin.json` manifest (v0.4.0)
- `hooks/hooks.json` — SessionStart greeter confirms plugin is active on session start
- `/claudekit:about` skill
- `/claudekit:doctor` skill — diagnose claudekit setup, detect missing kit pieces and hooks, suggest next actions
- `/claudekit:self-test` skill — invoke the `self_test` MCP tool; render typed pass/fail per layer

Not yet in Phase 1 step 3 (coming in Phase 1+):
- Agents (`agents/`)
- Bundled MCP server (`scripts/`, `.mcp.json`)
- Additional skills (`/claudekit:onboard`, `/claudekit:activate`, `/claudekit:recover`)

## Hooks

claudekit ships a `hooks/hooks.json` file that fires on Claude Code lifecycle events.

| Event | Matcher | What fires |
|---|---|---|
| `SessionStart` | `startup` | One-line greeter confirming claudekit is active. Prints to session output. No side effects. |

The greeter fires on fresh session start only (`startup` matcher). It does NOT fire on `/clear` or `/compact`.

Manual test: install the plugin, start a new Claude Code session, verify you see:

```
✧ claudekit v0.4.0 active — type /claudekit:about for status
```

See `__plan/_decisions/2026-05-12-plugin-pivot-canonical-spec.md` for the full roadmap.

## Install (local dev)

The marketplace lives at `plugins/` in the repo root. The plugin lives at `plugins/claudekit/`.

Inside Claude Code (interactive), run these commands in sequence:

```
/plugin marketplace add /Applications/MAMP/htdocs/prj01-claudecode-kit.com/plugins
/plugin install claudekit@claudekit-marketplace
/reload-plugins
/claudekit:about
```

If your repo is at a different path, substitute the absolute path to the `plugins/` directory.

To install via the CLI instead of inside Claude Code:

```bash
claude plugin marketplace add /Applications/MAMP/htdocs/prj01-claudecode-kit.com/plugins
claude plugin install claudekit@claudekit-marketplace
```

Then restart Claude Code (or run `/reload-plugins` inside it) to activate.

## Validate the plugin manifest

```bash
make plugin-validate
```

This runs `claude plugin validate` from the plugin directory. Expected output: no errors.

Alternatively, inside Claude Code:

```
/plugin validate
```

## Available commands today

| Command | What it does |
|---|---|
| `/claudekit:about` | Show plugin status, available commands, and account links |
| `/claudekit:doctor` | Diagnose claudekit setup: detect missing kit pieces, missing hooks, missing config; suggest next actions |
| `/claudekit:self-test` | Run the self-test harness via MCP; render typed pass/fail per layer (requires MCP connection — see below) |

## MCP server setup

`/claudekit:self-test` requires the claudekit MCP server to be connected. This is a one-time setup per machine.

**Local dev** (after `make dev`):

```bash
claude mcp add claudekit --header "Authorization: Bearer <credential>" http://localhost:8000/mcp
```

**Production:**

```bash
claude mcp add claudekit --header "Authorization: Bearer <credential>" https://mcp.claudecode-kit.com/mcp
```

Replace `<credential>` with your license credential from https://app.claudecode-kit.com/account/license.

After running `claude mcp add`, restart Claude Code (or run `/reload-plugins`) so the new MCP connection is active.

The bundled MCP setup (no manual `claude mcp add` required) ships in Phase 1 step 4.

## Roadmap

See `__plan/_decisions/2026-05-12-plugin-pivot-canonical-spec.md` for the full Phase 1–5 build plan.
