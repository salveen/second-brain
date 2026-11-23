---
name: brain-task
description: Add, complete, move, drop or list the user's tasks and reminders in their second brain (~/.brain/tasks.md). Use whenever the user says "remind me", "add a task", "todo", "I need to", "I have to", "don't let me forget", "done", "finished", "push X to Friday", "snooze", "postpone", "drop X", "I'm waiting on X from Y", "follow up with", or asks what is on their plate, what is due, or what they are waiting on. Turns relative dates such as "next month", "in two weeks" or "Friday" into exact dates. A reminder is a dated task that the heartbeat surfaces; this skill never creates cron jobs, timers, alarms or calendar events.
---

# brain-task

All tasks and reminders live in one file, one line per task. The date on a line is the day it should come up.

## Start

1. The brain is at `~/.brain`. If that does not exist, stop and suggest the brain-setup skill.
2. Read the Map in `~/.brain/AGENTS.md` unless it is already in context. It names the tasks file (default `tasks.md`), the areas and the log file.
3. Get today's date and weekday from the system clock: `date '+%F %A'`. Never guess the date.
4. Read the tasks file. If the legend at its top differs from this skill, the legend wins.

## Line format

```
- [ ] <text> [⏫] [📅 YYYY-MM-DD] [🔁 every <rule>] [#area]
- [ ] <who> - <what> (since YYYY-MM-DD) 📅 <follow-up date> #area      in ## Waiting
- [x] <text> ... ✅ YYYY-MM-DD                                           in ## Done
```

- Sections, in this order: `## Open`, `## Waiting`, `## Someday`, `## Done`. Keep Open and Waiting sorted by date, undated lines last.
- Text is a short, specific action: "Call the insurer about the car policy price", not "insurance". No em or en dashes.
- ⏫ only when the user says it is important or urgent.
- Longer context goes into a note, linked from the line: `[[note name]]`.

## Dates

| The user says | Date |
|---|---|
| today, tonight | today |
| tomorrow, day after tomorrow | today + 1, today + 2 |
| Monday ... Sunday | the next such day after today (today's own weekday means 7 days ahead) |
| this weekend | the coming Saturday (today if it is Saturday or Sunday) |
| end of the week | the coming Friday |
| next week | Monday of next week (weeks start on Monday) |
| next month | the 1st of next month |
| in a month, a month from now | the same day next month; if that day does not exist, the month's last day |
| end of the month | the last day of this month |
| in N days / weeks / months / years | today plus N (months clamp to the month's end) |
| the 5th, 5 Nov, 5.11 | that date; if it has passed, the next one |
| early / mid / late November | 1 / 15 / 25 November |
| N days before <date> | <date> minus N; keep "(deadline <D Mon>)" in the text |
| a clock time ("at 3pm") | the date as above; keep "at 15:00" in the text |

If nothing is clear, ask once and offer your best guess. A memory about dates (for example "by next month I mean the 25th") beats this table. Always say the weekday and date back to the user.

## Add

1. Look for an open line about the same thing. If one exists, update it instead of adding a duplicate.
2. Section: Waiting when the user waits on someone else (the date is when to chase; default 3 days from today); Someday for "someday", "maybe", "one day"; otherwise Open.
3. Area: the matching tag from the Map's areas, judged by topic, project or the current repo. Say which tag you chose.
4. "Remind me" without a date: ask "When should it come up?" and suggest tomorrow.
5. Write the line in its place. Append to the log: `## [<today>] task | added "<text>" 📅 <date>`.
6. Reply in one line: `Added: <text> - <Weekday D Mon YYYY> (#area)`.

## Complete, move, drop

Find the line by meaning. If two lines could match, ask which one.

- **Done:** change `[ ]` to `[x]`, append `✅ <today>`, move the line to the top of `## Done`. If it has 🔁, add the next occurrence as a new open line: step the rule forward from the old date until the date is after today. Log `task | done "<text>"`.
- **Move or snooze:** change the 📅 date. Log `task | moved "<text>" to <date>`; the heartbeat counts these lines.
- **Drop:** delete the line. Log `task | dropped "<text>"`.
- **A reply arrived** for a Waiting line: mark it done, or turn it into an Open task when there is a next step.

Reply with one line per change.

## List

For "what's on my plate", "what's due", "what am I waiting on": short bullets grouped as Overdue, Today, Next 7 days and Waiting, each with weekday and date. Include dated `- [ ]` lines from the owner's own files too, marked `(in <file name>)`, as the heartbeat does. Follow the user's format preferences from memory.

## Never

- Create cron jobs, timers, alarms, calendar events or scheduled tasks for reminders.
- Rephrase existing task text unless asked; the heartbeat matches lines by their text.
- Put passwords, keys, bank, card or ID numbers in a task.
