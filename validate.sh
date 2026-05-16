#!/usr/bin/env bash
# validate.sh — validate the claudekit plugin
#
# Usage: bash plugins/validate.sh
# Or via Make: make plugin-validate
#
# Requires the Claude Code CLI (`claude`) to be installed and on PATH.
# The `claude plugin validate` command checks:
#   - plugin.json schema and required fields
#   - skill/agent/command frontmatter
#   - hooks/hooks.json syntax (if present)
#
# Exit 0 = valid. Non-zero = validation errors printed to stdout.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="${SCRIPT_DIR}/claudekit"
MARKETPLACE_DIR="${SCRIPT_DIR}"

if ! command -v claude &>/dev/null; then
  echo "ERROR: 'claude' CLI not found. Install Claude Code and ensure 'claude' is on PATH."
  echo "       Download: https://claude.ai/download"
  exit 1
fi

echo "Validating claudekit plugin at: ${PLUGIN_DIR}"
claude plugin validate "${PLUGIN_DIR}"
echo "plugin validate (plugin): PASSED"

echo ""
echo "Validating marketplace at: ${MARKETPLACE_DIR}"
claude plugin validate "${MARKETPLACE_DIR}"
echo "plugin validate (marketplace): PASSED"
