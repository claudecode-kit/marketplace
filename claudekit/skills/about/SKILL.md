---
description: Show claudekit status, available commands, and links to your account.
---

claudekit v0.4.0 is installed and active.

**Available commands**

- `/claudekit:about` — this command (show status and available commands)
- `/claudekit:doctor` — diagnose claudekit setup in the current project; detect missing kit pieces, hooks, and config; suggest next actions
- `/claudekit:self-test` — run the claudekit self-test harness against the installed kit; render typed pass/fail per layer (requires MCP server connection — see below)

More commands are shipping in Phase 1+: `/claudekit:onboard`, `/claudekit:activate`, and `/claudekit:recover`.

**Active hooks**

claudekit fires a SessionStart greeter when you open a new Claude Code session (fresh start only, not on /clear or /compact). You will see:

```
✧ claudekit v0.4.0 active — type /claudekit:about for status
```

If you do not see this line, the plugin hook system may not be active. Run `/claudekit:doctor` to diagnose.

**Your account**

- Personal area (license, projects, billing): https://app.claudecode-kit.com
- Product and docs: https://claudecode-kit.com

**What claudekit does**

claudekit installs guardrails, project memory, and recovery tooling directly into Claude Code. The safety floor is free. Upgrade to Pro for the Live Control Graph, project brain sync, and disaster recovery snapshots.
