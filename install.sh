#!/usr/bin/env bash
# Link the second-brain skills into each AI tool's skills folder.
#   ./install.sh              link them; run it again after adding or removing a skill
#   ./install.sh --uninstall  remove the links
set -euo pipefail

kit="$(cd "$(dirname "$0")" && pwd -P)"

# Copilot reads ~/.copilot/skills, Codex and other tools ~/.agents/skills, Claude Code ~/.claude/skills.
targets=("$HOME/.copilot/skills" "$HOME/.agents/skills")
if [ -d "$HOME/.claude" ]; then targets+=("$HOME/.claude/skills"); fi

for t in "${targets[@]}"; do
  # First remove every link into this kit, so a deleted skill leaves no dead link.
  for link in "$t"/brain-*; do
    if [ -L "$link" ]; then
      case "$(readlink "$link")" in "$kit"/skills/*) rm "$link" ;; esac
    fi
  done
  if [ "${1:-}" = "--uninstall" ]; then echo "removed links from $t"; continue; fi

  # Then link every skill the kit has now.
  mkdir -p "$t"
  for skill in "$kit"/skills/brain-*/; do
    name="$(basename "$skill")"
    if [ -e "$t/$name" ] && [ ! -L "$t/$name" ]; then
      echo "skipped $t/$name: a real folder with that name is in the way"
      continue
    fi
    ln -sfn "$kit/skills/$name" "$t/$name"
    echo "linked $t/$name"
  done
done

if [ "${1:-}" != "--uninstall" ]; then echo "Done. In Claude Code or Copilot, say: set up my brain (or: update my brain)"; fi
