---
name: mise-tasks
description: Create, update, run, or debug mise tasks (file tasks and TOML tasks), including task interfaces, usage directives, and output behavior. Use when working on a mise-managed task workflow.
---

# Mise Tasks

Use this skill when adding, modifying, or invoking [mise](https://mise.jdx.dev/) tasks in any project that adopts mise as its task runner.

This skill complements the `scripts` skill (broader script authoring, testing, and integration workflow). When both apply, prefer the more specific rule here for task-runner specifics and defer to `scripts` for general script structure.

## Discovery and Execution

- Prefer CLI for discovery/help: list tasks with [`mise tasks`](https://mise.jdx.dev/cli/tasks.html) (alias `mise tasks ls`) and inspect a task with `mise tasks info <task>`.
- Treat the `mise-run_task` MCP tool as execution-only; pass a task name and do not use it for `mise` subcommands such as `mise tasks`.
- Execute tasks by invoking the task runner directly (prefer the `mise-run_task` MCP tool when available; otherwise use `mise run <task>`).
- Render task help with `mise run <task> --help` (or `-h`). See [`mise run`](https://mise.jdx.dev/cli/run.html) and [running tasks](https://mise.jdx.dev/tasks/running-tasks.html).
- When your harness exposes direct MCP resource reads and you need structured metadata, read `mise://tasks` (for example, `source`, `config_sources`, and dependency fields).

## MCP Limitations and Fallbacks

- Treat `mise-install_tool` as optional; some mise versions report it as not implemented. When that happens, use the repository's normal CLI installation flow instead.
- During portability checks, confirm task origin from `mise://tasks` metadata or `mise tasks info` so you can distinguish repository tasks from user-global tasks.

## Authoring Conventions

Mise supports two task styles. Detect the style the project already uses and match it; do not introduce a second style without a clear reason.

### File tasks

See [file tasks](https://mise.jdx.dev/tasks/file-tasks.html).

- Place file tasks in the project's configured tasks directory; refer to the docs for the supported defaults and how `task_config.includes` overrides them.
- Make the file executable; mise auto-registers executable files in the tasks directory.
- Use a file extension that matches the task language/interpreter (for example `.zsh`, `.sh`, `.js`, `.ts`).
- Keep files named `_default` extensionless; mise default-task resolution breaks when `_default` has an extension.
- Before authoring a file task, assess whether any of its logic should be reusable across other tasks or scripts. When it should, extract the reusable code into a directory outside the mise-detected tasks directory and import it from the task file. Keep the task namespace populated only by tasks; let shared logic live alongside the project's other source code for clearer separation of concerns.

### TOML tasks

See [TOML tasks](https://mise.jdx.dev/tasks/toml-tasks.html).

- Define TOML tasks as `[tasks.<name>]` tables (one table per task) in `mise.toml` or `.mise.toml`.
- Configure metadata (`description`, `depends`, `env`, `sources`, `outputs`, `dir`, `usage`, `quiet`, etc.) per [task configuration](https://mise.jdx.dev/tasks/task-configuration.html).

## Usage and Help

- Prefer mise's [usage](https://usage.jdx.dev/) feature for argument parsing, option configuration, defaults, validation, and help on file tasks. Let usage own the task's interface; keep in-script code focused on the task's behavior rather than reimplementing argument parsing.
- Define the task interface with mise's usage directives appropriate to the task's language. Examples: `#USAGE` for shell file tasks, `//USAGE` for TypeScript file tasks, and the `usage` field on TOML tasks. See the [Arguments section](https://mise.jdx.dev/tasks/file-tasks.html#arguments) of the file-tasks docs.
- Rely on mise's native help rendering; do not implement custom help printing inside task scripts.
- Treat unknown or incomplete options as explicit errors.

## Output

- Set tasks to `quiet` by default so mise does not prefix task output with `[task-name]`. Use `quiet = true` for TOML tasks and the equivalent `#MISE quiet=true` directive for file tasks (or whichever directive syntax the task's language uses, per [task configuration](https://mise.jdx.dev/tasks/task-configuration.html)).
