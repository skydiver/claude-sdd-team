#!/usr/bin/env bash
# PreToolUse hook for Bash. Blocks high-risk commands unless security mode is unguarded.
set -euo pipefail
input="$(cat)"
cmd="$(printf '%s' "$input" | python3 -c 'import sys,json; d=json.load(sys.stdin); print(d.get("tool_input",{}).get("command",""))' 2>/dev/null || true)"
mode_file="${CLAUDE_PROJECT_DIR:-$(pwd)}/.claude/.security-mode"
mode="$(cat "$mode_file" 2>/dev/null || echo guarded)"

# High-risk patterns ported from child-guardrails.ts
patterns='rm[[:space:]]+-rf|git[[:space:]]+reset[[:space:]]+--hard|git[[:space:]]+clean[[:space:]]+-fd|dd[[:space:]]+if=|mkfs|:\(\)\s*\{\s*:\|:\s*&\s*\};:'

if printf '%s' "$cmd" | grep -Eq "$patterns"; then
  if [ "$mode" != "unguarded" ]; then
    echo "blocked high-risk command in guarded mode: $cmd" >&2
    exit 2
  fi
fi
exit 0
