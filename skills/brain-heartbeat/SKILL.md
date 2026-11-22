---
name: brain-heartbeat
description: Generate today's day file in the user's second brain (~/.brain/days/YYYY-MM-DD.md) from their tasks - what is due or overdue, what they are waiting on, what is coming up, and one nudge - after syncing boxes they ticked in earlier day files back into tasks.md. Use when the user says "heartbeat", "what's today", "what's on today", "plan my day", "morning brief", "daily brief", "what should I do today". Safe to run several times a day; the user's own notes in the day file are kept.
metadata:
  version: "1.1"
---

# brain-heartbeat

Builds the day file, the one place to look each day. It reads the task list, never invents tasks, and writes only inside its own block.

## Start

1. The brain is at `~/.brain`. If that does not exist, stop and suggest the brain-setup skill.
2. Read the Map in `~/.brain/AGENTS.md` unless it is already in context: tasks file, days folder, day template, inbox, log, areas and MITs per day (default 3).
3. Get today's date and weekday from the system clock: `date '+%F %A'`. If the prompt explicitly says "today is <date>", use that date even when the clock differs. Never guess the date.

## 1. Sync ticked boxes

Open today's day file (if it exists) and the newest earlier day file. Between `<!-- heartbeat:start -->` and `<!-- heartbeat:end -->`, find every ticked `- [x]` line. For each, find the same open line in the tasks file (compare the text before the first emoji, ignoring case) and mark it done the brain-task way: `[x]`, append `✅ <today>`, move it to the top of `## Done`, and add the next occurrence if it has 🔁. If no line clearly matches, do not guess; mention it in the nudge. Unticked or deleted lines mean nothing.

## 2. Collect

From the tasks file:
- **Overdue:** lines in `## Open` with a 📅 date before today; note how many days late.
- **Due today:** lines in `## Open` with today's date.
- **Waiting:** every line in `## Waiting`; those dated today or earlier are follow-ups due.
- **Coming up:** lines in `## Open` dated within the next 7 days.

Also count the files in the inbox, and for each task count its `task | moved "<text>"` lines in the log from the last 30 days.

## 3. Pick

- Due = Overdue + Due today. If there are more than the MIT cap, choose that many as today's picks: ⏫ first, then most days late, then nearest date, then whatever fits the user's current focus in memory. The rest go into a sub-list "Also due".
- If fewer than 3 lines are due, add up to 2 undated `## Open` lines that fit the current focus, each marked `(could do)`.

## 4. Nudge

One line, or nothing. Use the first that applies:
1. A task moved 3 or more times in 30 days: name it and ask "do it today, hand it off, or drop it?"
2. Something overdue by more than 7 days.
3. A Waiting follow-up due today: "chase <who> today".
4. A ticked box that matched no task (from step 1).
5. A focus area from memory with no open task.
6. More than 10 items in the inbox: suggest "tidy".

Use the tone the user asked for in memory. No filler.

## 5. Write the day file

Path: `<days folder>/<today>.md`. If it does not exist, create it from the day template and replace `{{date}}` and `{{weekday}}`.

Replace only the text between the two markers. Keep the template's headings and their order, and fill them:
1. first heading: today's picks, then "Also due"
2. second heading: Waiting lines, follow-ups due first
3. third heading: Coming up, by date
4. fourth heading: the nudge

Copy task lines exactly as they are in the tasks file; the sync in step 1 depends on it. An empty section gets `_(nothing)_`. Never change anything outside the markers. If an existing day file has no markers, insert the block right under its title.

## 6. Log and reply

- Append to the log: `## [<today>] heartbeat | due=<n> overdue=<n> waiting=<n>`.
- If the newest earlier day file has a `## Daily line` with text under it, start the reply with `For your daily: <that line>`.
- Reply with today's picks as bullets with their dates, the follow-ups due and the nudge, in at most 12 lines. Follow the user's format rules from memory. If nothing is due, say so and name the next dated task.
