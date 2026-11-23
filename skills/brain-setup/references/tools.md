# Connecting tools

## Where each tool looks

| Tool | Detect | Skills folder | Instructions file | Pointer |
|---|---|---|---|---|
| Claude Code | `claude --version` | `~/.claude/skills/<skill>` | `~/.claude/CLAUDE.md` | import |
| GitHub Copilot (VS Code or CLI) | `~/.copilot` exists, or `copilot --version` | `~/.agents/skills/<skill>` | `~/.copilot/copilot-instructions.md` | read |
| Another tool that reads Agent Skills (for example Codex or Gemini CLI) | ask the user | `~/.agents/skills/<skill>` | the tool's user-level rules file | read |

## Check the skills

`install.sh` in the kit folder makes the skill links. This skill never creates, changes or deletes them.

Check that every `brain-*` entry in the tool's skills folder has a `SKILL.md` inside: `ls "<skills folder>"/brain-*/SKILL.md`. If the folder has no `brain-*` entries, or one of them has no `SKILL.md`, stop and tell the user to run `install.sh` in the folder they cloned the kit into (default `~/.second-brain`), then connect again.

## Write the pointer

Put the block between the markers. Replace an existing block, create the file if it is missing, and never touch text outside the markers.

Import style, for tools that expand `@path` imports:

```
<!-- brain:start -->
## Second brain
My second brain is at ~/.brain: tasks and reminders, memory about me, notes, projects and a log.
My own notes are the other files in the folder around it: read them when useful, change them only when I ask.
Use the brain-* skills for tasks, reminders, memory, capture, reviews and the daily heartbeat. Look in ~/.brain before asking me for context.
In the first chat of the day, if today's day file in ~/.brain does not exist yet, offer to run the heartbeat ("plan my day").
@~/.brain/memory/MEMORY.md
<!-- brain:end -->
```

Read style, for every other tool:

```
<!-- brain:start -->
## Second brain
My second brain is at ~/.brain: tasks and reminders, memory about me, notes, projects and a log.
My own notes are the other files in the folder around it: read them when useful, change them only when I ask.
At the start of every session, read ~/.brain/memory/MEMORY.md: it says who I am and how I like to work.
Use the brain-* skills for tasks, reminders, memory, capture, reviews and the daily heartbeat. Look in ~/.brain before asking me for context.
In the first chat of the day, if today's day file in ~/.brain does not exist yet, offer to run the heartbeat ("plan my day").
<!-- brain:end -->
```

## Disconnect

Remove the marker block in that tool's instructions file, nothing else. The skill links stay; `install.sh --uninstall` in the kit folder removes them.

## Write access from other projects

Saying "remind me" inside a code repo writes to `~/.brain`, which is outside that repo. Offer these, and apply them only on yes:
- Claude Code: add the vault's real path to `permissions.additionalDirectories` in `~/.claude/settings.json`.
- Copilot CLI: start it with `--add-dir <vault>`, or approve the folder when asked.
