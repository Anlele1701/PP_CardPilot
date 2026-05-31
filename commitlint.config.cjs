/**
 * Commit message convention: Conventional Commits.
 * Docs: docs/GIT_COMMIT_CONVENTIONS.md
 */
module.exports = {
  extends: ['@commitlint/config-conventional'],
  // Keep it pragmatic: enforce structure, but don't over-restrict scope naming.
  rules: {
    'scope-case': [2, 'always', ['kebab-case']],
  },
};

