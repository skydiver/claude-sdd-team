---
description: Show orchestrator and security-mode status.
allowed-tools: Bash(cat:*)
---

Report current multi-team SDD status:

- Security mode: !`cat "${CLAUDE_PROJECT_DIR:-.}/.claude/.security-mode" 2>/dev/null || echo "passive (default)"`
- Specialist agents are provided by the claude-sdd-team plugin (explorer,
  documentator, planner, implementer, tester-reviewer, hacker).

Summarize these for the user in two or three lines.
