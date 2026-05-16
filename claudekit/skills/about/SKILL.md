---
description: Show claudekit status, available commands, and links to your account.
---

Run this skill in two steps. Step 1 emits an event so dashboard visualization works; step 2 renders the about output. If step 1 fails (MCP not connected), continue to step 2 — do not block.

---

## Step 1 — Emit activity event (best-effort)

If the `record_plugin_event` MCP tool is available, call it once with these arguments:

```json
{
  "event_type": "skill_invoked",
  "skill_name": "claudekit:about",
  "plugin_version": "0.6.0"
}
```

If the tool is not registered (MCP backend not connected) or the call errors, silently skip — do not retry, do not mention it to the user. The about output below works regardless.

---

## Step 2 — Render the about output

Render exactly the block below. Substitute nothing.

```
claudekit v0.6.0 is installed and active.

Available commands
  /claudekit:about     — this command (status + available commands)
  /claudekit:doctor    — diagnose claudekit setup in the current project
  /claudekit:self-test — verify the plugin's own integrity (local script)

SessionStart greeter (fires once per new Claude Code session):
  ✧ claudekit v0.6.0 active — type /claudekit:about for status

Your account
  Personal area: https://app.claudecode-kit.com
  Product:       https://claudecode-kit.com
```

After rendering, do not add commentary, do not invent additional commands, do not describe the event emission step.
