# Git Commit Conventions

We use **Conventional Commits** to make history readable and to enable reliable changelogs/releases.

## Format

```text
<type>(<scope>)!: <subject>

<body>

<footer>
```

Notes:
- `<scope>` is optional, but recommended.
- `!` is optional and marks a breaking change.
- Keep the first line <= ~72 chars when possible.

## Types

Use one of:
- `feat`: New user-facing behavior or capability
- `fix`: Bug fix
- `refactor`: Code change that neither fixes a bug nor adds a feature
- `perf`: Performance improvement
- `test`: Add/update tests
- `build`: Build system changes (Nx, tsconfig, tooling)
- `ci`: CI pipeline changes
- `docs`: Documentation only
- `style`: Formatting only (no logic changes)
- `chore`: Maintenance tasks (deps, scripts, cleanup)
- `revert`: Revert a previous commit

## Scope

Scope describes *where* the change happens. Use **kebab-case**.

Examples:
- `backend`, `mobile`, `infra`, `docs`, `tools`
- A module name: `auth`, `cards`, `users`
- An Nx project name if it maps cleanly

## Subject

Rules:
- Use imperative mood: "add", "fix", "remove", "bump"
- No trailing period
- Describe *what* changed, not *how*

## Breaking Changes

Use either:
- `!` in the header: `feat(api)!: ...`
- Or a footer:

```text
BREAKING CHANGE: describe what breaks and what to do
```

## Examples

```text
feat(backend): add card search endpoint
```

```text
fix(auth): handle expired refresh tokens
```

```text
refactor(cards): split validation into pure helpers
```

```text
chore(deps): bump @nestjs/core to 11.1.0
```

## Enforcement (Husky + Commitlint)

This repo enforces commit messages via a git hook:
- Hook: `.husky/commit-msg`
- Config: `commitlint.config.cjs`

If your commit is rejected, rewrite the message and try again.

