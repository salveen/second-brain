---
name: brain-review
description: Keep work visible with small fixed rituals in the user's second brain (~/.brain) - the daily line (done, next, blocked) for a standup, the weekly update for a 1:1 or status email, a weekly think block, and monthly or quarterly reviews. Use when the user says "end of day", "daily line", "log off", "wrap up my day", "prep my daily", "standup", "weekly update", "prep my 1:1", "status update", "think block", "friday review", "weekly review", "monthly review" or "quarterly review". Drafts from the day files and tasks, never sends anything, and saves only what the user approved.
---

# brain-review

Small, fixed rituals that make work visible: one line a day, one update a week, one think block a week, one review a month. The brain drafts; the user decides what goes out. Nothing is ever sent from here.

## Start

1. The brain is at `~/.brain`. If that does not exist, stop and suggest the brain-setup skill.
2. Read the Map in `~/.brain/AGENTS.md` unless it is already in context: tasks file, days folder, day template, notes folder, log and the naming rules.
3. Get today's date and weekday from the system clock: `date '+%F %A'`. Never guess the date.
4. Read the memory index for tone and format preferences, and for anything the user tracks (goals, or signals agreed with someone).

## Pick the mode

| The user says | Mode |
|---|---|
| "end of day", "daily line", "log off", "wrap up my day" | Daily line |
| "prep my daily", "standup", "what do I say at the daily" | Daily prep |
| "weekly update", "prep my 1:1", "status update" | Weekly update |
| "think block", "friday review", "weekly review" | Think block |
| "monthly review", "quarterly review" | Review |

## Daily line

1. Collect today: lines ticked in today's day file, tasks with `✅ <today>`, and what the user said. If the user names an open task as finished, mark it done the brain-task way: keep the whole line, change `[ ]` to `[x]`, append `✅ <today>` and move it to the top of `## Done`. Do not re-date other tasks from what the user intends next; offer the move instead.
2. If something is missing, ask one question: "What did you finish, what do you intend to do next, and is anything blocked?" On a slow day, naming the blocker is a good answer.
3. Write one line under `## Daily line` in today's day file. If the day file is missing, create it from the day template; if the heading is missing, add it right after the heartbeat block. Replace an earlier line for today.
   `Done: <outcomes> | Next: I intend to <1-2 small things> | Blocked: <who or what, or nothing>`
4. Outcomes, not activity. Keep "Next" small enough to finish the next workday.
5. Append to the log: `## [<today>] review | daily line`. Reply with the line.

## Daily prep

Find the newest day file before today with text under `## Daily line`. Reply with it as three short spoken sentences: what got done, what I intend to do today, what blocks me. If there is none, say so and offer a line drafted from yesterday's ticked tasks. This mode only reads: no file changes and no log line.

## Weekly update

1. Period: since the last weekly update note, or the last 7 days.
2. Gather the daily lines in that period, the tasks done in it (by ✅ date), the open tasks dated in the next 7 days, and the Waiting lines.
3. Draft at most five short parts:
   - Done: 2-4 outcomes
   - Next week, I intend to: 2-4 items, each with a day
   - Risks or blockers: what could slip, and what is being done about it
   - Asks: decisions or help needed, and from whom
   - One bigger item: ask the user for it (an idea, a feedback question, a career point), or leave it out
4. Show the draft. After the user's yes or edits, save it in the notes folder as `weekly-update-<today>.md`, with the prefix and source line the vault's naming rules ask for.
5. Append to the log: `## [<today>] review | weekly update`. Reply with the final text, ready to paste. The user sends it, never this skill.

## Think block

45 minutes in three parts. Ask one part at a time and write down the user's own words.

1. Direction, 20 minutes: "What will matter in 3 months, and what could you improve?"
2. Proposal, 15 minutes: turn one answer into problem, recommendation and value (what it improves, in plain business words), plus the first step.
3. System check, 10 minutes: count this week's workdays with a daily line, and whether this week has a weekly update note. If either is short, ask what broke and fix the ritual, not the person: make it smaller or move it to a better moment. Never redesign the whole system.

Save it in the notes folder as `think-block-<today>.md` (prefix and source line as the naming rules say). Offer the first step as a task in the brain-task format. Log `review | think block`.

## Review

- **Monthly, 30 minutes:** what shipped (tasks done this month, the weekly update notes), what moved on the user's focus or tracked signals, and one thing to change.
- **Quarterly, 90 minutes:** the monthly questions, plus where the user's work is going in 6 to 12 months, the one area they want to be known for, and the skill they will build for it. It ends in a one-page note.

Save as `review-<YYYY-MM>.md` or `review-<YYYY>-Q<n>.md` in the notes folder. A change of goals becomes a memory update through brain-remember, after a yes. Log `review | monthly` or `review | quarterly`.

## Never

- Send, post or email anything. Drafts stay in the vault until the user copies them.
- Invent work that is not in the day files, the tasks or the user's words.
- Turn a missed ritual into blame. Name it once, then fix the ritual.
