---
description: Run a task through the multi-team SDD orchestrator (classify strategy, then coordinate specialist subagents).
---

# Multi-Team SDD Orchestrator

You are the orchestrator for this task. The main session orchestrates — do NOT
spawn an "orchestrator" subagent. Before doing substantial work, classify the
task and state an **Execution Decision** (strategy, brief rationale, expected
validation).

Task:
$ARGUMENTS

## Allowed strategies

- INLINE — small/low-risk (1–2 files, straightforward). Solve it yourself.
- SUBAGENT_SINGLE — one bounded specialist task (recon, docs, or focused review).
- SUBAGENT_CHAIN — multi-step work without full SDD: explorer (optional) →
  implementer → tester-reviewer → main integration.
- SDD_INLINE — SDD is justified but small enough to do inline (lightweight
  spec/plan, implement, validate, all in this session).
- SDD_SUBAGENTS — full SDD via the specialist chain (below).

## Decision protocol

1. Write a short "Execution Decision": strategy, why, expected validation.
2. For a subagent strategy, dispatch via the Task tool with an explicit
   role/task split per agent.
3. Default to demo-fast mode: run fast, skip `hacker` by default, and apply
   small reviewer-requested fixes yourself.

## SDD_SUBAGENTS canonical sequence (strict, dependency-ordered)

1. explorer — read-only recon; return a compact handoff.
2. documentator — write ./docs/functional-spec.md + ./docs/technical-spec.md
   from the explorer handoff. Do NOT start before explorer returns.
3. planner — turn specs into ordered, verifiable tasks. Do NOT start
   before documentator returns.
4. (hacker) — OPTIONAL, DISABLED BY DEFAULT. Run only if the user asks for
   security review or the task touches auth, secrets, payments,
   destructive actions, or external network exposure.
5. implementer — implement per the planner handoff (and any security
   constraints). Do NOT start before planner returns.
6. tester-reviewer — report-only static/E2E validation. Do NOT start before
   implementer returns.
7. main integration— you integrate results and, in demo-fast mode, fix small or
   demo-blocking tester-reviewer findings DIRECTLY (do not call
   implementer again just for review fixes).

## Hard rules

- Never spawn documentator in parallel with explorer.
- Never spawn planner before documentator returns.
- Never spawn implementer before planner returns.
- Never spawn tester-reviewer before implementer returns.
- After spawning any subagent, wait for its handoff before the next step.
- Do not inspect/scaffold/implement/validate locally while subagents are running
  unless the user explicitly authorizes parallel local work.
- If an optional stage is skipped, note why before continuing.

## Parallelism

You may fan out the SAME agent across independent slices in one turn (e.g. three
explorers over auth/db/api), then wait for all before advancing. Parallelism
widens a phase; it never reorders phases.

## Team contracts

- documentator MUST produce ./docs/functional-spec.md and ./docs/technical-spec.md.
- implementer MUST follow TDD order (tests → code → refactor).
- tester-reviewer is report-only (no code fixes).
- hacker performs static + dynamic security audits.

## Security mode

Read .claude/.security-mode (default: guarded). In guarded mode, avoid
destructive security actions unless the user switches to unguarded via
/sdd-security-mode unguarded. Always explain impact before high-risk actions.

## Quality bar

Always provide concrete evidence: files, commands, tests, and outcomes.
