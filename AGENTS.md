# second-brain kit: rules for working on it

This repo is the code of a portable second brain: seven Agent Skills plus a vault scaffold. It holds no personal data. The user's data lives in their vault, reached through `~/.brain`.

## Rules

- **Simple first.** A new mode, option or file needs a real use. When in doubt, leave it out.
- **Agent Skills spec only.** Frontmatter: `name`, `description`, `metadata.version`. `name` equals the folder name: lowercase letters, digits and single hyphens, at most 64 characters. `description` is at most 1024 characters, with trigger phrases first.
- **Short skills.** `SKILL.md` stays under 150 lines (aim for 120). Detail goes into `references/`, one level deep.
- **Tool-neutral.** No hooks, MCP servers, tool-only frontmatter or tool-only features as requirements.
- **macOS and Linux.** Shell commands are plain POSIX shell. Windows is not supported.
- **Verbs, not nouns.** Skills never hardcode vault folders except as defaults behind the Map in the vault's `AGENTS.md`.
- **Same start in every skill:** check `~/.brain`, read the Map, take the date from the system clock.
- **Nothing runs on its own** and nothing is sent anywhere: no schedules, timers or background jobs.
- **No personal data** in skills, references, assets or tests. Use placeholders (`{{name}}`) and the fictional Alex in `tests/fixture-vault/`.
- **No em or en dashes**, anywhere.
- **Version bumps.** Change `metadata.version` when a skill's behavior changes, and add a line to `CHANGES.md`. Change `<!-- brain-vault: N -->` in `skills/brain-setup/assets/vault/AGENTS.md` when the scaffold changes, and tell Doctor in brain-setup what the new version adds.

## Before committing

1. `tests/check-skills.sh` passes.
2. The scenarios in `tests/scenarios.md` that the change touches pass (`tests/run-scenario.sh`).
3. Never commit or push without the owner's go-ahead.
