---
name: writing-style
description: Apply shared prose tone and publication-readiness rules across docs and instruction files. Use when drafting or editing RFCs, specs, wiki pages, guides, or other authored content.
---

# Writing Style

Use this skill for authored prose across markdown documentation and instruction files.

## Core writing rules

- Use plain language and domain terms your readers already know; avoid unnecessary jargon.
- Prefer concise, self-evident wording; remove unnecessary meta-commentary and filler.
- Keep terminology consistent within a document and across related documents; choose one term and reuse it.
- Capitalize organization, team, and program names when used as proper nouns; use lowercase forms when used as generic concepts.
- Preserve exact casing for schema/model names, field names, and constants, and wrap those terms in single backticks in prose and tables.
- Use fenced code blocks with explicit language identifiers for structured examples (for example `json`, `yaml`, `graphql`, and `bash`).
- Keep documents publish-ready by default: remove internal process notes, agent-session artifacts, and other draft-only content from final document bodies.
- Keep operational behavior directives in instruction files (for example `AGENTS.md` and skill `SKILL.md`) instead of reader-facing document bodies.
- In reader-facing docs, use references the intended audience can actually access. If a public or published URL is not available yet, mark it as pending publication instead of linking private local-only paths.

## Publication-facing tone

- Keep tone constructive and forward-looking.
- Describe current-state limitations factually and briefly.
- Emphasize desired outcomes, user value, and actionable next steps.

## Cross-references

- For markdown syntax and structure conventions, follow the `markdown` skill.
