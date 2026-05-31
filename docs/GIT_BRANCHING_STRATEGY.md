# Git Branching Strategy

This repo uses a lightweight GitFlow-style model to keep `main` stable while enabling parallel feature work.

## Long-Lived Branches

- `main`: Always deployable/stable. Protected branch (PRs only).
- `develop`: Integration branch for upcoming work. Protected branch (PRs only).

## Short-Lived Branches

Create branches from `develop` unless noted.

### Feature

- Naming: `feature/<ticket>-<short-slug>`
- Example: `feature/CP-123-add-card-search`
- Merge target: `develop`

### Fix (non-production)

- Naming: `fix/<ticket>-<short-slug>`
- Example: `fix/CP-221-null-guard`
- Merge target: `develop`

### Hotfix (production)

Create from `main` when you must patch production quickly.

- Naming: `hotfix/<ticket>-<short-slug>`
- Example: `hotfix/CP-301-fix-login-redirect`
- Merge targets:
  1. `main`
  2. `develop` (back-merge to keep branches in sync)

## Pull Requests

Guidelines:
- Prefer small PRs (easy to review, easy to revert).
- Require green CI before merge.
- Use squash merge unless you explicitly need a multi-commit history.
- Title should follow Conventional Commits (same as commit messages).

## Releases

Typical flow:
1. Merge PRs into `develop`
2. When ready, open a PR `develop -> main`
3. Tag the merge commit on `main` (e.g. `v1.2.3`) if/when you introduce versioning

