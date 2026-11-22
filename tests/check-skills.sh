#!/usr/bin/env bash
# Check every skill against the Agent Skills spec and this kit's own rules.
# Usage: tests/check-skills.sh
set -u
kit="$(cd "$(dirname "$0")/.." && pwd -P)"
fail=0
bad() { echo "FAIL $1"; fail=1; }

for dir in "$kit"/skills/*/; do
  skill="$(basename "$dir")"
  file="${dir}SKILL.md"
  [ -f "$file" ] || { bad "$skill: no SKILL.md"; continue; }
  [ "$(head -1 "$file")" = "---" ] || bad "$skill: frontmatter must start on line 1"

  front="$(awk 'NR==1{next} /^---$/{exit} {print}' "$file")"
  for key in $(printf '%s\n' "$front" | grep -E '^[A-Za-z-]+:' | cut -d: -f1); do
    case "$key" in
      name|description|license|compatibility|metadata|allowed-tools) ;;
      *) bad "$skill: frontmatter key '$key' is not in the spec" ;;
    esac
  done

  name="$(printf '%s\n' "$front" | sed -n 's/^name:[[:space:]]*//p')"
  desc="$(printf '%s\n' "$front" | sed -n 's/^description:[[:space:]]*//p')"
  [ "$name" = "$skill" ] || bad "$skill: name '$name' must equal the folder name"
  printf '%s' "$name" | grep -Eq '^[a-z0-9]+(-[a-z0-9]+)*$' || bad "$skill: name must be lowercase letters, digits and single hyphens"
  [ "${#name}" -le 64 ] || bad "$skill: name is longer than 64 characters"
  [ -n "$desc" ] || bad "$skill: description is missing"
  [ "${#desc}" -le 1024 ] || bad "$skill: description is ${#desc} characters (max 1024)"
  case "$desc" in *": "*|*" #"*) bad "$skill: description contains ': ' or ' #', which breaks plain YAML" ;; esac
  grep -q '^metadata:' <<<"$front" && grep -q '^  version:' <<<"$front" || bad "$skill: metadata.version is missing"

  lines="$(wc -l < "$file" | tr -d ' ')"
  [ "$lines" -le 150 ] || bad "$skill: SKILL.md has $lines lines (max 150)"

  for ref in $(grep -oE '(references|assets)/[A-Za-z0-9._/-]*[A-Za-z0-9/]' "$file" | sort -u); do
    [ -e "$dir$ref" ] || bad "$skill: mentions $ref, which does not exist"
  done

  echo "ok   $skill: $lines lines, description ${#desc} characters"
done

for file in "$kit"/skills/*/SKILL.md; do
  skill="$(basename "$(dirname "$file")")"
  if python3 -c 'import yaml' 2>/dev/null; then
    python3 - "$file" <<'PY' || bad "$skill: frontmatter is not valid YAML"
import sys, yaml
front = open(sys.argv[1], encoding="utf-8").read()[4:].split("\n---\n", 1)[0]
data = yaml.safe_load(front)
assert isinstance(data, dict) and data.get("name") and data.get("description")
PY
  elif command -v ruby >/dev/null 2>&1; then
    ruby -ryaml -e 'f = File.read(ARGV[0], encoding: "UTF-8")[4..].split("\n---\n", 2)[0]; d = YAML.safe_load(f); exit(d.is_a?(Hash) && d["name"] && d["description"] ? 0 : 1)' "$file" \
      || bad "$skill: frontmatter is not valid YAML"
  else
    echo "note no YAML parser (PyYAML or Ruby); skipped the parse check for $skill"
  fi
done

dashes="$(printf '\xe2\x80\x94|\xe2\x80\x93')"
if grep -rnIE --exclude-dir=results "$dashes" "$kit/skills" "$kit/tests" "$kit"/*.md "$kit/install.sh"; then
  bad "em or en dash found above (use a normal hyphen)"
fi

if grep -rniIE --exclude-dir=results --exclude=check-skills.sh "salveen|/Users/[a-z]" "$kit/skills" "$kit/tests" "$kit"/*.md "$kit/install.sh"; then
  bad "personal data or a user path found above (the kit must stay generic)"
fi

[ "$fail" = 0 ] && echo "all checks passed"
exit "$fail"
