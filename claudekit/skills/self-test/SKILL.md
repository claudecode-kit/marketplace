---
description: "Run claudekit's local self-test — validates plugin integrity. No backend required."
---

Run the claudekit local self-test. No MCP connection needed — the script lives inside the plugin and validates the plugin's own payload.

---

## Step 1 — Run the bundled self-test script

Use the Bash tool to execute:

```
bash "$CLAUDE_PLUGIN_ROOT/scripts/self-test.sh"
```

Set `CLAUDE_PLUGIN_ROOT` to the plugin's installed location if the environment variable is not already exported. Capture both stdout and the exit code.

If the script is not found or not executable, tell the user:

> Plugin payload appears corrupted. Try `/plugin uninstall claudekit@marketplace` followed by `/plugin install claudekit@marketplace`.

Stop here if the script is missing. Do not fabricate output.

---

## Step 2 — Render the output

The script's stdout is already formatted for human reading. Pass it through unchanged inside a fenced code block.

**Symbol legend — these appear in the script output:**

- `✓` = pass
- `✗` = fail

**Expected output shape (real values come from the script):**

```
claudekit self-test (<ISO 8601 UTC timestamp> · local)
plugin v<version> · <pass_count>/<total> checks pass

  ✓ manifest present
  ✓ manifest valid JSON
  ✓ manifest has name
  ...

Result: PASS
```

---

## Step 3 — Close

If the script exited 0 (PASS): close with one line —

> All checks passed. Plugin is healthy.

If the script exited non-zero (FAIL): close with —

> Plugin integrity check failed. Run `/claudekit:doctor` for a project-level diagnostic, or reinstall via `/plugin uninstall` + `/plugin install`.

Do not invent diagnoses beyond what the script reported.
