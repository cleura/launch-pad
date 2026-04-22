# AGENTS.md — terse agent index (routing + gotchas)

Agents: explore the repo directly; this file routes, it does not teach.

See [DEVELOPMENT.md](DEVELOPMENT.md) for contributor information, style guide, and tests.

**Session memory:** Write plans, notes, and ephemeral files to `.ai/` (gitignored).
Prefer `.ai/tmp/` over the system temp directory.

**When planning**, read these to understand dependencies and tooling:

- `tox.ini`
- `requirements.txt`

## Tooling

- **Tests**: Entry point is **`tox`**.

- **Hooks**: `pre-commit` (lint only) and `pre-push` (functional test) hooks are stored in `.githooks`.

- **Review**: Series are always **unsquashed**; each commit must be independently testable and correct.

- **Git**: Read-only operations (`git log`, `git diff`, `git status`) are fine.
  Any mutating git operation (add, commit, reset, checkout, push, stash, merge, branch, etc.) requires explicit user approval.
  All modifications require a topic branch.
  Do not, under any circumstances, allow commits to the `master` or `main` branch.
  Refactoring tasks must always create a *new* topic branch.
  Always declare the AI tool and the employed model, by including `Assisted-By: <tool>/<model>` in the commit message.
  Never include emoji in commit messages.
