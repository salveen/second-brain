# second-brain

A second brain made of small skills and "~/Brain" folder of Markdown files: tasks, memory, notes, a daily file and a log, all on your own machine. It works in Claude Code and GitHub Copilot.

## Setup (macOS)

1. Open the Terminal app, paste this and press Enter:
   ```bash
   git clone https://github.com/salveen/second-brain.git ~/.second-brain && ~/.second-brain/install.sh
   ```
   This puts the skills in a hidden folder, `~/.second-brain`. Keep it: deleting it turns the skills off. Your notes live in a separate folder (`~/Brain` by default). To update later, run `cd ~/.second-brain && git pull && ./install.sh`, then say **"update my brain"**.
2. Open Claude Code, or Copilot in agent mode, and say **"set up my brain"**. It asks a few questions and does the rest. Already have notes, or another AI brain? Name that folder: it makes a backup, asks which files you write by hand (those stay as they are) and files the rest.
3. Write your own notes anywhere in `~/Brain`. The AI keeps its files in `~/Brain/brain_vault` and never changes yours; say **"tidy"** and it files what is new in your notes into its vault.

## What you can say

| Say | What happens |
|---|---|
| "remind me next month to renew my ID" | adds a dated task |
| "done: renew ID", "push the report to Friday" | updates the task |
| "plan my day", "heartbeat" | your morning brief: what is due today, what you are waiting on, what is coming up |
| "end of day", "prep my daily" | writes or reads the daily line: done, next, blocked |
| "weekly update", "think block", "monthly review" | drafts the update, runs the block, reviews the month |
| "remember that I ...", "what do you know about me" | saves or shows memory |
| "capture this ...", "log this" | saves a note or a log line |
| "tidy" | files what is new in your notes, cleans up the inbox, memory and archive; asks first |
