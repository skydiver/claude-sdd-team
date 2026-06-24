#!/usr/bin/env bash
# Validates and persists the security mode used by bash-guard.sh.
set -euo pipefail
mode="${1:-}"
if [ "$mode" != "passive" ] && [ "$mode" != "active" ]; then
  echo "Usage: /sdd-security-mode passive|active" >&2
  exit 1
fi
dir="${CLAUDE_PROJECT_DIR:-$(pwd)}/.claude"
mkdir -p "$dir"
printf '%s\n' "$mode" > "$dir/.security-mode"
echo "Security mode set to $mode"
