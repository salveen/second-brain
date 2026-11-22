# Connecting tools

## Where each tool looks

| Tool | Detect | Skills folder | Instructions file | Pointer |
|---|---|---|---|---|
| Claude Code | `claude --version` | `~/.claude/skills/<skill>` | `~/.claude/CLAUDE.md` | import |
| GitHub Copilot (VS Code or CLI) | `~/.copilot` exists, or `copilot --version` | `~/.agents/skills/<skill>` | `~/.copilot/copilot-instructions.md` | read |
| Another tool that reads Agent Skills (for example Codex or Gemini CLI) | ask the user | `~/.agents/skills/<skill>` | the tool's user-level rules file | read |

## Link the skills

`<skills root>` is the folder that holds this `brain-setup` folder and its `brain-*` siblings. Resolve it to a real path first: `cd "<folder>" && pwd -P`.

For each `brain-*` folder in `<skills root>`: `mkdir -p "<skills folder>" && ln -sfn "<skills root>/<skill>" "<skills folder>/<skill>"`

Skip a link that already points to the same place; after `install.sh` they all do. If a real folder with the same name is in the way, stop and ask. Tools that share `~/.agents/skills` need the links only once.

## Write the pointer

Put the block between the markers. Replace an existing block, create the file if it is missing, and never touch text outside the markers.

Import style, for tools that expand `@path` imports:

```
<!-- brain:start -->
## Second brain
My second brain is at ~/.brain: tasks and reminders, memory about me, notes, projects and a log.
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
At the start of every session, read ~/.brain/memory/MEMORY.md: it says who I am and how I like to work.
Use the brain-* skills for tasks, reminders, memory, capture, reviews and the daily heartbeat. Look in ~/.brain before asking me for context.
In the first chat of the day, if today's day file in ~/.brain does not exist yet, offer to run the heartbeat ("plan my day").
<!-- brain:end -->
```

## Disconnect

Remove the `brain-*` links in that tool's skills folder and the marker block in its instructions file, nothing else. If another connected tool still uses `~/.agents/skills`, keep the links there.

## Write access from other projects

Saying "remind me" inside a code repo writes to `~/.brain`, which is outside that repo. Offer these, and apply them only on yes:
- Claude Code: add the vault's real path to `permissions.additionalDirectories` in `~/.claude/settings.json`.
- Copilot CLI: start it with `--add-dir <vault>`, or approve the folder when asked.
