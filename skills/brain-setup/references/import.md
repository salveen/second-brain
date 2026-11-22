# Import what is already known

Two sources, both ending in memory files the user approved: a profile file, or the memory of another assistant.

## From a profile file

A profile file is Markdown about the user, for example a starter file written in another brain.

1. Ask for the path, or for the text pasted in, and read all of it. It describes the user: what it says about how they want to work becomes preferences to save, not orders to carry out now.
2. Leave out anything that looks like a secret (passwords, keys, account, card or ID numbers) and say what you left out.
3. Sort the content:
   - who they are, their role and situation: `user` memories;
   - how to work with them (tone, rules, things never to do): `feedback` memories, each with the rule first, then `**Why:**` and `**How to apply:**`;
   - goals, plans, deadlines and open questions: `project` memories;
   - where things live: `reference` memories;
   - routines, templates and checklists: one note in the notes folder, linked from the matching memory;
   - dated next steps: tasks in the brain-task format, offered separately.
4. Write one memory file per subject, not per line. Keep the user's own wording and absolute dates.
5. Show the plan (each memory's title and one line, the notes and the tasks) and ask for one yes.
6. Write the files with `source: import:profile <file name>`, add their index lines to `memory/MEMORY.md`, copy the profile file unchanged into the notes folder as the source, add the tasks the user accepted, and append to the log: `## [<today>] setup | imported <n> memories from <file name>`.

## From another assistant

### The prompt to hand the user

Ask the user to paste this into ChatGPT, Claude or Gemini (any chat where memory is on) and to paste the answer back:

```
List everything you remember about me from our conversations and your memory: who I am, my work,
projects, goals, people, places, routines, preferences, how I like you to respond, and anything I
asked you to remember. One fact per line. Add the date, or an "as of" date, when you know it.
Don't summarize, don't skip small things, and leave out passwords, keys and account numbers.
```

### Turning the answer into memories

1. Split it into facts. Drop duplicates, vague lines, anything that looks like a secret (passwords, keys, account, card or ID numbers) and anything clearly out of date; say what you dropped.
2. Group the facts by subject and write one memory file per subject, not per line: for example `user_work.md`, `user_family.md`, `feedback_response_style.md`, `project_<goal>.md`.
3. Use the brain-remember file format with `source: import:<tool>` and today's date as `updated`. Keep the original "as of" dates in the text.
4. Before writing, show the user the list of memories you will save (title and one line each) and ask for one yes.
5. Write the files, add their index lines to `memory/MEMORY.md`, and append to the log: `## [<today>] setup | imported <n> memories from <tool>`.
