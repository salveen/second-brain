#!/usr/bin/env bash
# Run the automated scenarios from scenarios.md one after another.
#   tests/run-all.sh            run all of them
#   tests/run-all.sh 01 03 11b  run only these
# Each result (reply plus vault changes) goes to tests/results/<id>.txt.
set -u
here="$(cd "$(dirname "$0")" && pwd -P)"
out="$here/results"
mkdir -p "$out"

run() {  # run <id> <prompt> [repo]
  if [ "${#picked[@]}" -gt 0 ] && ! printf '%s\n' "${picked[@]}" | grep -qx "$1"; then return; fi
  echo "== $1: $2"
  "$here/run-scenario.sh" "$2" "${3:-}" > "$out/$1.txt" 2>&1
}

picked=("$@")
run 01  "Today is 2026-10-25. Remind me next month to renew my ID card."
run 02a "Today is 2026-10-25. Remind me in a month to call grandma."
run 02b "Today is 2026-10-25. Remind me Friday to send the invoice."
run 02c "Today is 2026-10-25. Add a task for next week: back up the laptop."
run 02d "Today is 2026-10-25. Remind me 3 days before the 30th to prepare the workshop slides."
run 02e "Today is 2027-01-31. Remind me in a month to renew the domain."
run 03  "Today is 2026-10-25. heartbeat"
run 05  "Today is 2026-10-25. Done: pay rent."
run 06  "Today is 2026-10-25. I'm waiting on Marta to send the brand files, chase her on Thursday."
run 07a "Today is 2026-10-25. Remember that I take magnesium in the evening."
run 07b "What do you know about me?"
run 07c "Today is 2026-10-25. Forget the Porto trip."
run 08  "Remember that my IBAN is PT50 0002 0123 1234 5678 9015 4."
run 09  "Today is 2026-10-25. Capture this, I want to read it later: https://example.com/portfolio-tips"
run 10  "Today is 2026-10-25. Log this: deployed the portfolio preview to staging." repo
run 11a "Today is 2026-10-25. tidy"
run 11b "Today is 2026-10-25. tidy, and apply everything you propose without asking me."
run 15a "Today is 2026-10-25. End of day: I bought Anna's present and booked the dentist. Tomorrow I intend to send the quarterly report. Nothing is blocked."
run 15b "Today is 2026-10-25. Prep my daily."
run 15c "Today is 2026-10-25. Weekly update."
echo "done; results in $out"
