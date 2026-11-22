#!/usr/bin/env bash
# Run one scenario with Claude Code against a fresh copy of the fixture vault.
#   tests/run-scenario.sh "<prompt>" [repo]
# With "repo" as the second argument the prompt runs inside /tmp/brain-demo-repo
# (the fixture's Repos table points there); otherwise inside the vault copy.
# ~/.brain points at the copy for the run and is restored afterwards.
# Prints the reply, then every change the run made to the vault.
# Env: BRAIN_TEST_MODEL (default sonnet), BRAIN_TEST_KEEP=1 keeps the copy.
set -euo pipefail

kit="$(cd "$(dirname "$0")/.." && pwd -P)"
prompt="$1"
work="$(mktemp -d)"
vault="$work/vault"
cp -R "$kit/tests/fixture-vault" "$vault"

cwd="$vault"
if [ "${2:-}" = "repo" ]; then
  cwd="/tmp/brain-demo-repo"
  [ -d "$cwd/.git" ] || git init -q "$cwd"
fi

old=""
if [ -L "$HOME/.brain" ]; then
  old="$(readlink "$HOME/.brain")"
elif [ -e "$HOME/.brain" ]; then
  echo "~/.brain exists and is not a link; refusing to touch it" >&2
  exit 1
fi
restore() {
  if [ -n "$old" ]; then ln -sfn "$old" "$HOME/.brain"; else rm -f "$HOME/.brain"; fi
  if [ "${BRAIN_TEST_KEEP:-0}" = 1 ]; then echo "kept $work"; else rm -rf "$work"; fi
}
trap restore EXIT
ln -sfn "$vault" "$HOME/.brain"

# User settings are skipped on purpose: personal hooks must not change the results.
(
  cd "$cwd"
  claude -p "$prompt" \
    --model "${BRAIN_TEST_MODEL:-sonnet}" \
    --setting-sources project,local \
    --add-dir "$kit" --add-dir "$vault" \
    --permission-mode acceptEdits \
    --allowedTools "Read" "Write" "Edit" "Glob" "Grep" "Skill" \
      "Bash(date:*)" "Bash(ls:*)" "Bash(mkdir:*)" "Bash(mv:*)" "Bash(cp:*)" \
      "Bash(wc:*)" "Bash(grep:*)" "Bash(rg:*)" "Bash(find:*)" "Bash(cat:*)" "Bash(head:*)" "Bash(tail:*)"
) || echo "(claude exited with an error)"

echo
echo "===== changes in the vault ====="
diff -ru "$kit/tests/fixture-vault" "$vault" || true
