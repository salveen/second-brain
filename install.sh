#!/usr/bin/env bash
# Link the second-brain skills into each AI tool's personal skills folder.
#   ./install.sh              link them
#   ./install.sh --uninstall  remove only the links that point into this kit
# Then open any AI tool and say: "set up my brain".
set -euo pipefail

kit="$(cd "$(dirname "$0")" && pwd -P)"

# ~/.agents/skills is read by Codex, GitHub Copilot and Gemini CLI.
# Claude Code reads only ~/.claude/skills, so it gets its own links when installed.
targets=("$HOME/.agents/skills")
[ -d "$HOME/.claude" ] && targets+=("$HOME/.claude/skills")

if [ "${1:-}" = "--uninstall" ]; then
  for t in "${targets[@]}"; do
    for link in "$t"/brain-*; do
      [ -L "$link" ] || continue
      case "$(readlink "$link")" in
        "$kit"/skills/*) rm "$link" && echo "removed $link" ;;
      esac
    done
  done
  exit 0
fi

for t in "${targets[@]}"; do
  mkdir -p "$t"
  for skill in "$kit"/skills/brain-*/; do
    name="$(basename "$skill")"
    dest="$t/$name"
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
      echo "skipped $dest: a real folder with that name is in the way"
      continue
    fi
    ln -sfn "$kit/skills/$name" "$dest"
    echo "linked $dest"
  done
done

echo
echo "Done. Open Claude Code (or Copilot) and say: set up my brain"
