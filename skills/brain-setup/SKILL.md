---
name: brain-setup
description: Set up, connect, move or check the user's second brain at ~/.brain. Use when the user says "set up my brain", "install brain", "connect Claude Code / Copilot to my brain", "disconnect", "move my brain", "interview me", "update my profile", "import my profile", "import my ChatGPT memory", "adopt my vault", "brain doctor" or "check my brain", or when another brain skill finds that ~/.brain does not exist. Runs a quick interview (3 questions at most), can import a profile file or what ChatGPT, Claude or Gemini already know about the user, and can adopt an existing notes folder.
metadata:
  version: "2.0"
---

# brain-setup

The second brain is a folder of plain files (the vault) reached through the link `~/.brain`. Skills hold the procedures; the vault's `AGENTS.md` holds paths, formats and rules. This skill creates and maintains that wiring.

## Before you start

- Get today's date from the system clock: `date '+%F %A'`.
- This skill's folder (the one holding this file) contains `assets/vault/` (the scaffold) and `references/`.
- Ask one question at a time. Use the tool's question UI if it has one, otherwise plain text. Every question states its default, and "skip" takes it.
- Never overwrite or delete the user's files without a yes. Never add a git remote to the vault or push it.

## Pick the mode

| The user wants | Mode |
|---|---|
| a first setup, or `~/.brain` is missing | First run |
| "connect X", "I installed X", "disconnect X" | Connect |
| to bring in an existing notes folder or vault | Adopt: follow `references/adopt.md` |
| "import my profile", "import my ChatGPT / Claude / Gemini memory" | Import: follow `references/import.md` |
| "move my brain" | Move |
| "interview me", "update my profile" | Interview |
| "brain doctor", "check my brain" | Doctor |

## First run

1. Ask where the vault should live. Default: `~/Brain`. If that folder (or the one the user names) already holds notes, for example an Obsidian vault, switch to Adopt.
2. Create the folder, then the link: `ln -s "<vault>" ~/.brain`. If `~/.brain` already exists and points somewhere else, stop and ask.
3. Copy everything in `assets/vault/` into the vault, keeping subfolders. Skip files that already exist and list them. Create the empty folders `days`, `inbox`, `notes`, `projects` and `archive`.
4. Ask: "Do you have a profile file to start from (for example a starter file from another brain), or should I import what ChatGPT, Claude or Gemini know about you? Default: neither." If yes, follow `references/import.md`.
5. Run the Interview.
6. Detect the installed tools (`references/tools.md`), say which you found, and connect them all on one yes.
7. If git is installed and the vault is not a repository yet, run `git init` in it. Local only.
8. Run the brain-heartbeat skill once, so the user sees today's file.
9. Show this card:
   ```
   Your brain is at ~/.brain. In any connected tool you can say:
   - "remind me next month to ..."      adds a dated task
   - "heartbeat"                         writes today's file in days/
   - "done: ...", "push ... to Friday"   updates tasks
   - "end of day", "weekly update"       the daily line and the weekly update
   - "remember that I ...", "what do you know about me"
   - "capture this ...", "file this", "log this"
   - "tidy"                              inbox, memory and archive cleanup
   ```
10. Append to the log: `## [<today>] setup | brain set up at <vault>`.

## Interview

At most 3 questions. First read `memory/MEMORY.md` and anything imported: skip what is already known, and offer a proposed answer to confirm instead of an open question when you can.

1. "What should I call you, and what are you focused on for the next 3 months?" Write `memory/user_profile.md` and `memory/project_focus.md`.
2. "How should I talk to you: blunt, balanced or gentle? Anything I must never do?" Default: balanced. Write `memory/feedback_communication.md`.
3. "Your work and life seem to split into these areas: <proposal>. Change anything?" Default: `#work #health #personal`. Write them on the `Areas:` line in the vault's `AGENTS.md`.

Memory files use the brain-remember format (`name`, `description`, `type`, `updated`, `source: setup`); add one index line per file to `memory/MEMORY.md`. Replace `{{name}}` in the vault's `AGENTS.md` with the user's name. Everything else the brain learns later, as the user works.

## Connect

Follow `references/tools.md`: link every `brain-*` skill folder into the tool's skills folder, then write the pointer block into the tool's instructions file. Disconnect removes those two things and nothing else. Report one line per tool.

## Move

Move the vault folder (or copy it if the user wants a fallback), re-point the link with `ln -sfn "<new>" ~/.brain`, then run Doctor.

## Doctor

Check each item and print one line per item: ok, or the problem and its fix. Offer the fixes and apply them only on yes.

- `~/.brain` resolves to a folder that contains `AGENTS.md`.
- Every path in the Map exists.
- `tasks.md` has `## Open`, `## Waiting`, `## Someday` and `## Done`, and every task line is `- [ ]` or `- [x]` with dates written as `YYYY-MM-DD`.
- `memory/MEMORY.md` is under 150 lines, every link in it points to an existing file, and no memory file is missing from it.
- For each connected tool (see `references/tools.md`): the skill links resolve and the pointer block is present.
- The `<!-- brain-vault: N -->` marker in the vault's `AGENTS.md` matches the one in `assets/vault/AGENTS.md`. If the vault is older or has no marker, list what the newer scaffold adds and offer to add it. Version 2 adds the `-C-` naming rule for AI-made notes and a `## Daily line` section in the day template.
- Nothing from the brain runs on a schedule (macOS: `launchctl list | grep -i brain` is empty).
