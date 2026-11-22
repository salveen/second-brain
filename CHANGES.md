# Changes

## 2.0 (2026-11-22)

Simpler, plus the daily and weekly review rituals. The vault format (tasks, memory, day files, log) is unchanged, so an existing vault keeps working.

Removed
- Windows support: `install.ps1` and the PowerShell steps in every skill. The kit is macOS and Linux only.
- The optional heartbeat schedule (launchd, cron, desktop routines), the schedule question and the "scheduled runs" sections in brain-heartbeat and brain-tidy. Nothing runs on its own.
- Layout switching (PARA and others) in brain-setup. Moving the vault to another folder stays.
- Codex and Gemini specifics. Any tool that reads Agent Skills still works through `~/.agents/skills`.
- `adapters/`. Its Obsidian notes moved into the README.
- The Claude Code version check in Doctor; current versions read `AGENTS.md` themselves.

Changed
- brain-setup 2.0: the interview has at most 3 questions. Tools are detected and connected on one yes instead of a question.
- brain-heartbeat 1.1: when yesterday's day file has a daily line, the reply starts with it ("For your daily").
- brain-tidy 1.1: no scheduled-run mode, and memory overlap is spelled out: a fact that another file already states counts as a duplicate.
- brain-remember 1.1 and brain-capture 1.1: a "today is" date in the prompt wins over the clock, as in the other skills.
- Vault scaffold 2: AI-made notes start with `-C-`, open with a source line and end with `## Related`; the day template has a `## Daily line` section.

Added
- brain-review 1.0: the daily line, daily prep, the weekly update for a 1:1 or status email, the 45-minute think block, and monthly and quarterly reviews. It drafts and saves; it never sends.
- Profile import in brain-setup: start a new brain from a profile file, for example a starter file written in another brain.

Fixed
- A personal example in brain-capture is now generic.
- `tests/check-skills.sh` no longer fails when the shell locale is not UTF-8.
- The "today is" rule now says plainly that a date given in the prompt wins over the clock, so test runs with a fixed date stay deterministic.

## 1.0 (2026-10-25)

Six skills (setup, task, heartbeat, remember, capture, tidy), the vault scaffold, installers and tests.
