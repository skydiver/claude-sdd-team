---
description: Set security mode — /sdd-security-mode guarded|unguarded
allowed-tools: Bash(bash:*)
---

The user asked to set the security mode to: $ARGUMENTS

First validate the value. It must be exactly `guarded` or `unguarded`. If it is
empty or anything else, do NOT run any command — tell the user the correct
usage: `/sdd-security-mode guarded|unguarded`.

If the value is valid, run the setter, substituting the validated literal
(`guarded` or `unguarded`) for MODE. Never pass `$ARGUMENTS` to the shell directly:

`bash "${CLAUDE_PLUGIN_ROOT}/hooks/set-security-mode.sh" MODE`

If it switched to unguarded, remind the user that unguarded mode permits high-risk
commands for the hacker role.
