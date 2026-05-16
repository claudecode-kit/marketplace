---
description: "Diagnose claudekit setup in the current project: detect missing kit pieces, missing hooks, missing config; suggest next actions."
---

Run the following diagnostic checks against the current project root. Work through them in order. Do not fetch URLs. Do not install anything. Read only.

**Project root** = the directory containing CLAUDE.md or the nearest ancestor that looks like a project root (has `.git/` or `.claude/`).

---

## Check 1 — `.claude/` directory present

Check whether `.claude/` exists at the project root.

- Pass: directory exists.
- Fail: directory missing.

---

## Check 2 — `CLAUDE.md` present

Check whether `CLAUDE.md` exists at the project root.

- Pass: file exists.
- Fail: file missing.

---

## Check 3 — claudekit rules installed

Check `.claude/rules/` for the following six files. List each as present or missing.

Required files:
1. `git-safety.md`
2. `secret-hygiene.md`
3. `plan-before-build.md`
4. `tdd-loop.md`
5. `session-close.md`
6. `context-discipline.md`

Score: N/6 present.

- Pass (✓): all 6 present.
- Partial (~): 1–5 present — list which are missing.
- Fail (✗): none present.

---

## Check 4 — `.claudekit/` sidecar present

Check whether `.claudekit/manifest.json` exists at the project root.

- Present (✓): file exists — kit was installed via `/claudekit:onboard`.
- Not present (○): file missing — kit has not been installed yet.

This is informational. A missing sidecar is not a failure if the kit was set up manually.

---

## Check 5 — Hook events registered

Read `.claude/settings.json` if it exists. Check whether a `PreToolUse` hook is configured (any matcher, any command).

- Pass (✓): `PreToolUse` key exists and has at least one hook entry.
- Not present (○): `settings.json` missing or `PreToolUse` not configured.

Do not evaluate the hook's command text. Presence is sufficient for this check.

---

## Check 6 — Recovery playbook present

Check whether `__documentation/recovery-playbook.md` exists at the project root.

- Pass (✓): file exists.
- Not present (○): file missing.

This is informational. A missing playbook is not a blocker but is recommended.

---

## Output format

After running all six checks, output the report in exactly this format. Substitute real values. Do not add sections. Do not omit sections.

```
claudekit doctor — <project-root>

Setup
  <symbol> .claude/ directory present
  <symbol> CLAUDE.md present
  <symbol> claudekit rules installed: N/6 rules present
    missing: <file1>, <file2>   ← omit this line if all 6 present
  <symbol> .claudekit/ sidecar <present | not present (kit not yet installed via /claudekit:onboard)>
  <symbol> PreToolUse hook <configured | not configured>
  <symbol> Recovery playbook <present | not present>

Result: N/6 checks passed
Action: <one-line next step, or "No action required." if all checks pass>
```

Symbol legend:
- `✓` pass
- `~` partial (some items present, some missing)
- `○` not present — informational (not a failure)
- `✗` fail (should be present but is not)

**Scoring for "Result: N/6 checks passed":**
- Check 1 (`.claude/`): counts as pass if ✓
- Check 2 (`CLAUDE.md`): counts as pass if ✓
- Check 3 (rules): counts as pass if ✓ (all 6); counts as partial if ~; counts as fail if ✗
- Check 4 (sidecar): always informational — does NOT count toward N/6
- Check 5 (hooks): counts as pass if ✓
- Check 6 (playbook): always informational — does NOT count toward N/6

Maximum scorable: 4/4 (checks 1, 2, 3, 5). Report as "N/4 checks passed".

**Action line guidance:**
- If rules are partial or missing: `run /claudekit:onboard to install the missing kit pieces`
- If `.claude/` or `CLAUDE.md` is missing: `run /claudekit:onboard to initialise claudekit in this project`
- If hooks are not configured: `add a PreToolUse hook in .claude/settings.json (see kit/_shared/full/.claude/settings.json for the template)`
- If all 4 scorable checks pass: `No action required.`
