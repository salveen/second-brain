---
name: brain-setup
description: Set up, update, connect, move or check the user's second brain at ~/.brain. Use when the user says "set up my brain", "install brain", "update my brain", "upgrade my brain", "adopt my vault", "connect Claude Code / Copilot to my brain", "disconnect", "move my brain", "interview me", "update my profile", "import my profile", "import my ChatGPT memory", "brain doctor" or "check my brain", or when another brain skill finds that ~/.brain does not exist. Looks at what is already there first: sets up a new brain, updates an older one, or adopts an existing notes folder or another AI brain after a backup, never changing the user's own notes. Runs a quick interview (3 questions at most) and can import what ChatGPT, Claude or Gemini already know about the user.
metadata:
  version: "3.1"
---

# brain-setup

The second brain is a folder of plain files. The brain folder (default `~/Brain`) holds the user's own notes and, inside it, the vault `brain_vault` with the AI's files, reached through the link `~/.brain`. Skills hold the procedures; the vault's `AGENTS.md` holds paths, formats and rules. This skill creates and maintains that wiring.

## Before you start

- Get today's date from the system clock: `date '+%F %A'`.
- This skill's folder (the one holding this file) contains `assets/vault/` (the scaffold) and `references/`.
- Ask one question at a time. Use the tool's question UI if it has one, otherwise plain text. Every question states its default, and "skip" takes it.
- Never overwrite or delete the user's files without a yes. Never delete the user's own notes at all: they delete their own files themselves. Never add a git remote to the brain or push it.

## Pick the mode

| The user wants | Mode |
|---|---|
| "set up my brain", "update my brain", "adopt my vault", or `~/.brain` is missing | Look first |
| "connect X", "I installed X", "disconnect X" | Connect |
| "import my profile", "import my ChatGPT / Claude / Gemini memory" | Import: follow `references/import.md` |
| "move my brain" | Move |
| "interview me", "update my profile" | Interview |
| "brain doctor", "check my brain" | Doctor |

## Look first

Change nothing yet.

1. Find the brain folder with `readlink ~/.brain`. If it points to a folder named `brain_vault`, its parent is the brain folder; if it points anywhere else, that folder is the brain folder. If `~/.brain` is missing, ask where the brain should live, or where the user's existing notes are. Default: `~/Brain`. Look only at the brain folder found this way.
2. Read the marker `<!-- brain-vault: N -->` in `<brain>/brain_vault/AGENTS.md`, or in `<brain>/AGENTS.md` (older brains kept the vault in the brain folder itself). The kit's version is the marker in this skill's `assets/vault/AGENTS.md`.
3. Pick the path and say it in one line:

| What is there | Path |
|---|---|
| no folder, or one with only hidden files | New: First run |
| a marker equal to the kit's | Current: run Doctor. If the user asked to update, say the brain already matches this kit; a newer kit comes from `git pull` and `./install.sh` in the kit folder (default `~/.second-brain`) |
| a marker lower than the kit's | Older: Update |
| no marker: notes, other files or another AI system's files | Existing: Adopt, following `references/adopt.md` |

If `~/.brain` points to a folder without a marker, ask whether that is the folder to adopt.

## Backup

Before Update or Adopt changes anything:

1. Say the brain folder's size (`du -sh "<brain>"`), then copy all of it next to itself: `cp -a "<brain>" "<brain>-backup-<today>"`. Add `-2`, `-3` if that name is taken.
2. Check that both folders hold the same number of files: `find "<folder>" -type f | wc -l`.
3. If the copy fails or the counts differ, stop: no backup, no changes.
4. Tell the user where the backup is, and that they can delete it once they are happy.

## First run

1. The AI's files go in `<brain>/brain_vault` (the vault). Everything else in `<brain>` is the user's own notes, which tidy files into the vault.
2. Create `<brain>/brain_vault`, then point the link at it: `ln -sfn "<brain>/brain_vault" ~/.brain`.
3. Copy everything in `assets/vault/` into the vault, keeping subfolders. Skip files that already exist and list them. Put its `.gitignore` in the brain folder instead, unless one is already there. Create the empty folders `days`, `inbox`, `notes`, `projects` and `archive`.
4. Ask: "Do you have a profile file to start from (for example a starter file from another brain), or should I import what ChatGPT, Claude or Gemini know about you? Default: neither." If yes, follow `references/import.md`.
5. Run the Interview.
6. Detect the installed tools (`references/tools.md`), say which you found, and connect them all on one yes.
7. If git is installed and the brain folder is not a repository yet, run `git init` in it. Local only.
8. Run the brain-heartbeat skill once, so the user sees today's file.
9. Show this card:
   ```
   Your brain is <brain>. Write your own notes anywhere in it; my files are in
   <brain>/brain_vault (~/.brain). In any connected tool you can say:
   - "remind me next month to ..."      adds a dated task
   - "heartbeat"                         writes today's file in days/
   - "done: ...", "push ... to Friday"   updates tasks
   - "end of day", "weekly update"       the daily line and the weekly update
   - "remember that I ...", "what do you know about me"
   - "capture this ...", "file this", "log this"
   - "tidy"                              files what is new in your notes, cleans up
   ```
10. Append to the log: `## [<today>] setup | brain set up at <brain>`.

## Update

For a brain whose marker is lower than the kit's. List what will change (below, for each version above the brain's), ask for one yes, then:

1. Run Backup.
2. If the brain has no `brain_vault` yet, create it and move into it `AGENTS.md` and every path the Map names. Hidden files and folders (such as `.obsidian` and `.git`) stay. List any other item at the top of the brain folder: it stays there as the user's own notes unless the user names it to move. Then point the link at the vault: `ln -sfn "<brain>/brain_vault" ~/.brain`.
3. Bring the vault's `AGENTS.md` up to the kit's version: add what each newer version adds and keep everything the user wrote, then set its marker to the kit's. Copy scaffold files the vault lacks, skipping existing ones.
4. If `<brain>/.obsidian/daily-notes.json` or `templates.json` point at folders that moved, put `brain_vault/` in front of those paths.
5. Search the vault, and each connected tool's instructions file outside the markers, for absolute paths to files that moved. Show the lines and fix them on yes.
6. Refresh the pointer block of every connected tool (Connect), since its text may be newer.
7. Run Doctor. Append to the log: `## [<today>] setup | updated the brain from version <old> to <new>`.

What each version adds:
- 2: the `-C-` naming rule for AI-made notes, and a `## Daily line` section in the day template.
- 3: the vault moves into `brain_vault`, with the user's own notes around it. The Map gets the Own files and Tidy copies rows, the Rules get the own-files rule, and `.tidy/` goes in the brain folder's `.gitignore`.

## Interview

At most 3 questions. First read `memory/MEMORY.md` and anything imported: skip what is already known, and offer a proposed answer to confirm instead of an open question when you can.

1. "What should I call you, and what are you focused on for the next 3 months?" Write `memory/user_profile.md` and `memory/project_focus.md`.
2. "How should I talk to you: blunt, balanced or gentle? Anything I must never do?" Default: balanced. Write `memory/feedback_communication.md`.
3. "Your work and life seem to split into these areas: <proposal>. Change anything?" Default: `#work #health #personal`. Write them on the `Areas:` line in the vault's `AGENTS.md`.

Memory files use the brain-remember format (`name`, `description`, `type`, `updated`, `source: setup`); add one index line per file to `memory/MEMORY.md`. Replace `{{name}}` in the vault's `AGENTS.md` with the user's name. Everything else the brain learns later, as the user works.

## Connect

Follow `references/tools.md`: check that the tool's skill links work, then write the pointer block into the tool's instructions file. Never create, change or delete skill links: `install.sh` does that. Disconnect removes the pointer block and nothing else. Report one line per tool.

## Move

Move the whole brain folder (or copy it if the user wants a fallback), re-point the link with `ln -sfn "<new>/brain_vault" ~/.brain`, then run Doctor.

## Doctor

Check each item and print one line per item: ok, or the problem and its fix. Offer the fixes and apply them only on yes.

- `~/.brain` resolves to a folder named `brain_vault` that contains `AGENTS.md`.
- Every path in the Map exists.
- `tasks.md` has `## Open`, `## Waiting`, `## Someday` and `## Done`, and every task line is `- [ ]` or `- [x]` with dates written as `YYYY-MM-DD`.
- `memory/MEMORY.md` is under 150 lines, every link in it points to an existing file, and no memory file is missing from it.
- For each connected tool (see `references/tools.md`): every skill link has a `SKILL.md` behind it, and the pointer block is present. The fix for broken links is running `install.sh` in the kit folder, never linking by hand.
- The `<!-- brain-vault: N -->` marker in the vault's `AGENTS.md` matches the one in `assets/vault/AGENTS.md`. If it is lower or missing, offer Update.
- Nothing from the brain runs on a schedule (macOS: `launchctl list | grep -i brain` is empty).
