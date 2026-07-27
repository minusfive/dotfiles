---
name: critique-workflow
description: Run critique, review, and audit workflows with finding clustering, status-token verdicts, decision logs, and terminal critique gates. Use when I ask for a critique or audit, or when deterministic critique routing is needed.
---

# Critique Workflow

Use this skill for critique, review, and audit tasks.

## Mode Selection

Choose exactly one mode and follow that mode file end-to-end:

- Use [`assets/human-walkthrough.md`](assets/human-walkthrough.md) when I explicitly ask for interactive walkthrough critique with decision gates.
- Use [`assets/autonomous-cycle.md`](assets/autonomous-cycle.md) for deterministic unattended critique/review/audit cycles.
- Default to autonomous mode unless I explicitly ask for interactive walkthrough mode.

Do not mix steps across modes. The selected mode file is the full executable procedure.
