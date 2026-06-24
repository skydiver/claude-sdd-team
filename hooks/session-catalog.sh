#!/usr/bin/env bash
# SessionStart hook: print the subagent catalog as plain text.
set -euo pipefail
agents_dir="${CLAUDE_PLUGIN_ROOT:-.}/agents"
mode_file="${CLAUDE_PROJECT_DIR:-$(pwd)}/.claude/.security-mode"
echo "claude-sdd-team — specialist subagents:"
for f in "$agents_dir"/*.md; do
  [ -e "$f" ] || continue
  name="$(basename "$f" .md)"
  desc="$(grep -m1 '^description:' "$f" | sed 's/^description:[[:space:]]*//')"
  printf '  • %-16s %s\n' "$name" "$desc"
done
echo "Security mode: $(cat "$mode_file" 2>/dev/null || echo 'guarded (default)')"
echo "Enter the SDD flow with: /sdd <task>"
