---
description: Set security mode — /security-mode passive|active
allowed-tools: Bash(bash:*)
---

The user asked to set the security mode to: $ARGUMENTS

First validate the value. It must be exactly `passive` or `active`. If it is
empty or anything else, do NOT run any command — tell the user the correct
usage: `/security-mode passive|active`.

If the value is valid, run the setter, substituting the validated literal
(`passive` or `active`) for MODE. Never pass `$ARGUMENTS` to the shell directly:

`bash "${CLAUDE_PLUGIN_ROOT}/hooks/set-security-mode.sh" MODE`

If it switched to active, remind the user that active mode permits high-risk
commands for the hacker role.
