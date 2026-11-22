# Adopt an existing notes folder

Bring an existing vault into the brain without losing anything, and without changing the original until the user says so.

## 1. Pick the strategy

- **Fresh vault plus import (default):** create a new vault from the scaffold and copy the content in. The old folder stays untouched as a fallback.
- **In place:** work inside the old folder. First make a local git commit or a zip backup so everything can be undone.
- **Map only:** keep the folder names and write a Map in `AGENTS.md` that points at them.

## 2. Scan (read only)

List the top-level folders with file counts, then find:
- tasks: one file per task (frontmatter such as `status` or `due`) or checkbox lists (`- [ ]`);
- facts about the user: root instruction files (`CLAUDE.md`, `AGENTS.md`), memory folders, profile or goals notes;
- projects, notes, an inbox or raw folder, journals or daily notes, logs;
- leftovers of other systems to leave behind: skills folders, hooks, MCP configs, caches, plugin data.

## 3. Propose the mapping

Show a table: old location, new location, file count and the conversion rule for each row. Ask for one yes before copying anything.

## 4. Conversion rules

- **One file per task** becomes one line in `tasks.md`:
  - status todo or doing goes to `## Open`; blocked or waiting goes to `## Waiting`; done goes to `<archive>/tasks-YYYY-MM.md` as `- [x] <title> ✅ <done date>`; killed or cancelled goes there with `(dropped)` added.
  - `due` becomes `📅`. For waiting items: `<who> - <what> (since <created>) 📅 <follow-up date>`.
  - The highest priority (for example `mit`, `high`) becomes `⏫`. Area, arm or project becomes a `#tag`.
  - The title comes from the H1 or the file name.
  - A body longer than 3 lines is copied to `notes/tasks/<title>.md` with a source line and linked from the task line as `[[<title>]]`.
- **Memory files** go to `memory/` in the brain-remember format. Files that only describe the old system's wiring are not carried over.
- **The root instruction file** is split:
  - facts about the user become `user` memories;
  - rules about talking and working become `feedback` memories;
  - rules about the vault go into the `AGENTS.md` Rules;
  - goals become a `project` memory;
  - the rest is copied to `<archive>/legacy/`.
- **Projects** go to `projects/` unchanged. A project's `CLAUDE.md` is renamed `AGENTS.md`.
- **Notes** go to `notes/`; the inbox or raw folder goes to `inbox/`. Daily notes named `YYYY-MM-DD` go to `days/`; other journals go to `notes/journal/`.
- **Old generated reports** (daily briefs, reviews) go to `<archive>/`.
- **Logs** are appended to `log.md` as they are; new lines use the brain format.
- **Other systems' files** (skills, hooks, MCP configs, caches) are not copied.
- **`.obsidian`:** copy the app settings, but leave community plugins switched off for the user to re-enable.

## 5. Verify and report

- Compare counts per row (old and new). Open tasks and memory files must match one for one.
- List anything that was not mapped.
- Spot-check that 5 `[[links]]` still resolve.
- Write the report to `<archive>/import-report-<today>.md`, show the summary, and append to the log: `## [<today>] setup | adopted <old path>`.
