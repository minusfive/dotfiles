---
name: pr-guidelines
description: Push branches and keep an open pull request's title and body in sync. Use when preparing a branch for review, updating PR metadata after a push, or opening a PR with linked issues.
---

# Pull Request Guidelines

- Complete `commit-guidelines` skill (including hook policy, branch creation, and commits) before proceeding

## 1: Push

- Push the branch to the remote repository
- Verify the push succeeded before opening a pull request

## 2: Pull Request

- PR title and message formatting **MUST** follow the same guidelines as commits
- If the branch already has an open pull request, update the title and body after each push.
- Keep the title and body aligned with the latest changes.
- The pull request body should include a brief summary of the changes and any relevant context or notes for the reviewer
- **MUST NOT** include commit messages in the pull request body — these are clear from the PR's commit history and will quickly become stale
- Reference any related issues or pull requests where relevant
- Request explicit approval before opening the pull request, never auto-open without user confirmation
