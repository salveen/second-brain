# second-brain

A second brain made of seven small skills and a folder of plain Markdown files: tasks, memory, notes, a daily file and a log, all on your own machine. It works in Claude Code and GitHub Copilot (and any tool that reads Agent Skills), needs no MCP servers, and nothing runs on its own.

## Quick start (macOS)

1. Clone and install the skills:
   ```bash
   git clone https://github.com/<you>/second-brain.git && cd second-brain && ./install.sh
   ```
   `install.sh` links each skill into `~/.claude/skills` (Claude Code) and `~/.agents/skills` (Copilot and other tools). To update later: `git pull`.
2. Open Claude Code, or Copilot in agent mode, and say **"set up my brain"**. It asks where the vault goes (default `~/Brain`), offers to import a profile file, asks at most 3 questions, connects your tools and writes today's file.
3. Optional: open `~/.brain` in Obsidian as a vault. Daily Notes: folder `days`, format `YYYY-MM-DD`, template `templates/day`. The Tasks plugin renders the 📅 dates.

## What you can say

| Say | What happens |
|---|---|
| "remind me next month to renew my ID" | adds `- [ ] Renew ID 📅 <date> #personal` to `tasks.md` and says the date back |
| "done: renew ID", "push the report to Friday", "I'm waiting on Anna for the contract" | updates `tasks.md` |
| "heartbeat" | writes `days/<today>.md`: what is due, what you wait on, what is coming, one nudge |
| "end of day", "prep my daily" | writes or reads the daily line: done, next, blocked |
| "weekly update", "think block", "monthly review" | drafts the weekly update, runs the think block, reviews the month |
| "remember that I ...", "what do you know about me", "forget ..." | edits `memory/` |
| "capture this ...", "file this", "log this" | the inbox, a note, or the log and a project's dev log |
| "tidy" | inbox triage, memory cleanup and archiving; asks before changing anything |
| "brain doctor", "connect Copilot to my brain" | health check and wiring |

## Skills

| Skill | Job |
|---|---|
| `brain-setup` | first run with the quick interview, profile and memory import, connect tools, adopt an existing vault, move, doctor |
| `brain-task` | add, complete, move, drop and list tasks; turns "next month" into a date |
| `brain-heartbeat` | syncs ticked boxes, then writes today's day file |
| `brain-review` | the daily line, the weekly update, the think block, monthly and quarterly reviews |
| `brain-remember` | saves, updates, shows and forgets memories; refuses secrets |
| `brain-capture` | inbox drops, filed notes, log lines and project dev logs |
| `brain-tidy` | the "dream" pass: inbox, memory, archive, links |

## The vault

```
~/.brain -> your vault
├── AGENTS.md            Map (roles to paths), areas, repos, rules
├── tasks.md             every task and reminder, one line each
├── days/YYYY-MM-DD.md   the heartbeat's day file, with the daily line and your notes below its block
├── memory/MEMORY.md     index loaded into every session; one file per memory beside it
├── inbox/  notes/  projects/  archive/
├── log.md               append-only event log
└── templates/day.md     the day file's layout; rename its headings to reshape the heartbeat
```

## How it is built

- **Skills are verbs; the vault holds the nouns.** The skills in `skills/` contain procedures only. Paths, formats and areas live in the vault's `AGENTS.md`, so changing your folder layout means editing a table, not code.
- **One pointer.** `~/.brain` links to your vault. Every skill reads and writes through it, so moving the vault means re-pointing one link.
- **Plain files.** Tasks are lines in `tasks.md`, memory is one small file per fact plus an index, and the log is append-only. Obsidian, VS Code or any editor can open them.
- **Nothing runs on its own.** The heartbeat and the reviews run when you ask. No cron jobs, timers or schedules, and nothing is ever sent anywhere.

## Uninstall

`./install.sh --uninstall` removes the links. Saying "disconnect <tool>" removes that tool's pointer block. Your vault is never touched.

## Develop

Rules for changing the kit are in `AGENTS.md`, and changes are listed in `CHANGES.md`. Check the skills with `tests/check-skills.sh`, and run the scenarios in `tests/scenarios.md` with `tests/run-scenario.sh` or `tests/run-all.sh`.
