# marketplace

Official Claude Code plugin marketplace for **claudekit** — the safety + project-memory plugin for Claude Code.

## Install

Inside any Claude Code session:

```
/plugin marketplace add claudecode-kit/marketplace
/plugin install claudekit@marketplace
/reload-plugins
```

Greeter fires on next session start. Three skills available immediately:

| Skill | What it does |
|---|---|
| `/claudekit:about` | Status + available commands |
| `/claudekit:doctor` | Diagnose project setup (filesystem checks, no MCP needed) |
| `/claudekit:self-test` | Validate the plugin's own integrity (local script) |

Plus a `SessionStart` hook that prints a one-line greeter when the plugin is active.

## What lands on your disk

- `~/.claude/plugins/cache/claudekit/` — plugin payload
- Nothing in your projects until you opt in via `/claudekit:onboard` (planned skill)

## Free vs Pro

Everything in this marketplace is **free**. Pro features (Live Control Graph, recovery snapshots, project brain sync) connect to the hosted backend at [claudecode-kit.com](https://claudecode-kit.com) — separately, after install.

## Safety

- Existing `.claude/` configuration is reconciled, never overwritten.
- Every change is backed up to `.claudekit/backups/<timestamp>/`.
- Disable any time: `/plugin disable claudekit@marketplace`
- Uninstall any time: `/plugin uninstall claudekit@marketplace`
- No source code or secrets uploaded. Credentials (when used) travel in the `Authorization` header, never in URLs.

## Versions

Current: `v0.5.1` — free skills + local self-test, no backend required.

See [`claudekit/.claude-plugin/plugin.json`](claudekit/.claude-plugin/plugin.json) for the manifest.

## Reporting issues

Open an issue at [github.com/claudecode-kit/marketplace/issues](https://github.com/claudecode-kit/marketplace/issues).

## License

Proprietary. See the main product at [claudecode-kit.com](https://claudecode-kit.com).
