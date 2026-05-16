#!/usr/bin/env bash
# claudekit self-test — local plugin integrity check.
#
# Runs against the plugin's own payload at $CLAUDE_PLUGIN_ROOT. No backend
# required. Validates that the installed plugin is structurally healthy:
#   - manifest is present and valid JSON
#   - all declared skills have description frontmatter
#   - hooks.json is valid JSON with the expected shape
#   - SessionStart greeter is registered
#
# Output: machine-readable text matching the Self-Test Harness vocabulary
# (✓ pass / ~ partial / ✗ fail). Exit code 0 on PASS, 1 on FAIL.
#
# Invoked by the /claudekit:self-test skill. Future bundled-MCP integration
# will return typed JSON; this shell version is the no-deps Phase 1 path.

set -u

ROOT="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"
PASS=0
FAIL=0
LINES=()

check() {
    local description="$1"
    local condition="$2"
    if eval "$condition" >/dev/null 2>&1; then
        LINES+=("  ✓ $description")
        PASS=$((PASS + 1))
    else
        LINES+=("  ✗ $description")
        FAIL=$((FAIL + 1))
    fi
}

PLUGIN_JSON="$ROOT/.claude-plugin/plugin.json"
HOOKS_JSON="$ROOT/hooks/hooks.json"

check "manifest present" "[ -f '$PLUGIN_JSON' ]"
check "manifest valid JSON" "command -v jq >/dev/null && jq -e . '$PLUGIN_JSON'"
check "manifest has name" "jq -e -r '.name' '$PLUGIN_JSON' | grep -q claudekit"
check "manifest has version" "jq -e -r '.version' '$PLUGIN_JSON' | grep -q '\\.'"

for skill in "$ROOT/skills"/*/SKILL.md; do
    [ -f "$skill" ] || continue
    name=$(basename "$(dirname "$skill")")
    check "skill '$name' has description" "head -20 '$skill' | grep -qE '^description:'"
done

check "hooks.json present" "[ -f '$HOOKS_JSON' ]"
check "hooks.json valid JSON" "jq -e . '$HOOKS_JSON'"
check "SessionStart greeter registered" "jq -e '.hooks.SessionStart' '$HOOKS_JSON'"

VERSION=$(jq -r '.version' "$PLUGIN_JSON" 2>/dev/null || echo "unknown")
TS=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
TOTAL=$((PASS + FAIL))

echo "claudekit self-test ($TS · local)"
echo "plugin v$VERSION · $PASS/$TOTAL checks pass"
echo ""
printf '%s\n' "${LINES[@]}"
echo ""
if [ "$FAIL" -eq 0 ]; then
    echo "Result: PASS"
    exit 0
else
    echo "Result: FAIL ($FAIL check(s) failed)"
    exit 1
fi
