---
name: brain-remember
description: Save, update, forget or show what the user's second brain knows about them (~/.brain/memory/). Use when the user says "remember", "remember that", "note that I", "keep in mind", "from now on", "always", "never", "I prefer", "forget", "that's wrong, it's", "what do you know about me", "update my profile", or states a lasting fact, preference, correction or decision that should carry across sessions and tools. Keeps one fact per file plus a short MEMORY.md index that every session loads. Refuses to store secrets.
metadata:
  version: "1.1"
---

# brain-remember

Memory is a folder of small files, one per fact or rule, plus an index (`MEMORY.md`) that every session loads. This skill is the only writer.

## Start

1. The brain is at `~/.brain`. If that does not exist, stop and suggest the brain-setup skill.
2. Read the Map in `~/.brain/AGENTS.md` unless it is already in context. It names the memory folder (default `memory/`) and the log.
3. Get today's date from the system clock: `date '+%F %A'`. If the prompt explicitly says "today is <date>", use that date even when the clock differs. Never guess the date.

## What to keep

- **Keep:** who the user is (role, people, places, routines); how they want to be worked with (rules, corrections, approaches they confirmed); what they are working toward (focus, goals, deadlines, decisions); where things live (tools, accounts, repos, folders).
- **Skip:** anything already in `AGENTS.md` or a project note, details that only matter in this chat, guesses.
- **Never:** passwords, API keys, tokens, bank, card or IBAN numbers, ID or passport numbers. Answer: "I won't store that. Keep it in your password manager." Store health, beliefs or relationships only when the user explicitly asks you to remember them.

## Types and files

| type | holds | file |
|---|---|---|
| user | who they are | `user_<slug>.md` |
| feedback | how to work with them | `feedback_<slug>.md` |
| project | focus, goals, deadlines, decisions | `project_<slug>.md` |
| reference | where things are | `reference_<slug>.md` |

```
---
name: <Short title>
description: <one line that states the fact itself>
type: <user | feedback | project | reference>
updated: YYYY-MM-DD
source: <chat | setup | import:<tool> | a file path>
until: YYYY-MM-DD        (only for temporary facts, such as a trip)
---
<The fact in plain words, with absolute dates.>
```

A feedback memory starts with the rule, then a `**Why:**` line and a `**How to apply:**` line.

## Save

1. Search the memory folder (names, descriptions, text) for the same subject.
2. Found: update that file and its `updated` date. When a fact changes, keep a short trail: `Changed <date>: was <old>.`
3. Not found: create a new file.
4. Turn relative dates into absolute ones.
5. Update `MEMORY.md`: one line per file under its type's heading, `- [Title](file.md) - <hook>`. Keep it under 150 lines; past 130, merge or shorten lines and say so.
6. Append to the log: `## [<today>] memory | saved <file>`.
7. Reply in one line: `Saved to memory: <fact>`.

When the user explicitly says "remember" or "from now on", save. When you only infer a rule from a correction, ask first in one line: "Save as a rule: <rule>?" The user's own feedback memories about saving override this.

## Show

"What do you know about me": read the index and the files, then answer with short bullets grouped as About you, How you like to work, Current focus and Where things are. Offer to correct anything.

## Forget

Find the memory (ask if several match), delete its file and its index line, log `memory | forgot <file>`, and confirm in one line.
