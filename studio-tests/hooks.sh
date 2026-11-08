#!/usr/bin/env bash
# Behavioural tests for .claude/hooks/*. Builds a throwaway project, feeds each
# hook a realistic JSON payload and checks the exit code / output.
set -u
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
T="$(mktemp -d)"; trap 'rm -rf "$T"' EXIT
cp -R "$REPO/.claude" "$T/.claude"; cp "$REPO/project.yaml" "$T/"
cd "$T" && git init -q && git config user.email t@t && git config user.name t
export CLAUDE_PROJECT_DIR="$T"
pass=0; fail=0
j() { python3 -c 'import json,sys; print(json.dumps(json.loads(sys.argv[1])))' "$1"; }
# expect <exit> <hook> <json> <description> [grep-in-output]
expect() {
  local want="$1" hook="$2" json="$3" desc="$4" pat="${5:-}" out code
  out="$(printf '%s' "$json" | bash ".claude/hooks/$hook" 2>&1)"; code=$?
  if [ "$code" = "$want" ] && { [ -z "$pat" ] || printf '%s' "$out" | grep -qE "$pat"; }; then
    pass=$((pass+1))
  else
    fail=$((fail+1)); echo "FAIL [$hook] $desc (exit $code, want $want)"; printf '%s\n' "$out" | head -5 | sed 's/^/    /'
  fi
}
w() { printf '{"tool_name":"Write","tool_input":{"file_path":"%s/%s","content":%s}}' "$T" "$1" "$(python3 -c 'import json,sys;print(json.dumps(sys.argv[1]))' "$2")"; }
b() { printf '{"tool_name":"Bash","tool_input":{"command":%s}}' "$(python3 -c 'import json,sys;print(json.dumps(sys.argv[1]))' "$1")"; }
mk() { mkdir -p "$(dirname "$1")"; printf '%s\n' "$2" > "$1"; }

# validate-write
expect 2 validate-write.sh "$(w .env 'A=1')" "blocks .env"
expect 0 validate-write.sh "$(w .env.example 'STRIPE_SECRET_KEY=sk_test_xxx')" "allows .env.example"
expect 2 validate-write.sh "$(w src/a.ts 'const k = "sk_live_'"$(printf 'a%.0s' {1..24})"'"')" "blocks live Stripe key"
expect 2 validate-write.sh "$(w src/a.ts 'const k = "AKIA'"ABCDEFGHIJKLMNOP"'"')" "blocks AWS key"
expect 0 validate-write.sh "$(w src/a.ts 'const url = "postgres://postgres:postgres@localhost:5432/app"')" "allows local DB URL"
remote_url="postgres://admin:s3cr3t""pass@prod-db.acme.io/app"   # split so the repo never holds the full string
expect 2 validate-write.sh "$(w src/a.ts "const url = \"$remote_url\"")" "blocks remote DB URL with password"
expect 0 validate-write.sh "$(w src/a.ts 'export const x = process.env.STRIPE_SECRET_KEY')" "allows env reads"

# validate-read
mk docs/big.md "$(head -c 50000 /dev/zero | tr '\0' 'a')"
expect 2 validate-read.sh "{\"tool_input\":{\"file_path\":\"$T/docs/big.md\"}}" "blocks whole read of big doc"
expect 0 validate-read.sh "{\"tool_input\":{\"file_path\":\"$T/docs/big.md\",\"offset\":1,\"limit\":50}}" "allows ranged read"

# validate-commit
expect 2 validate-commit.sh "$(b 'git commit -m "updated stuff"')" "rejects non-conventional message"
expect 0 validate-commit.sh "$(b 'git commit -m "feat(auth): add magic link"')" "accepts conventional message"
expect 0 validate-commit.sh "$(b 'git status')" "ignores non-commit commands"
mk .env "SECRET=1"; git add -f .env
expect 2 validate-commit.sh "$(b 'git commit -m "chore: x"')" "blocks staged .env"
git rm -q --cached .env; rm .env

# tdd-guard (standard rigor: advise)
mk src/lib/pricing.ts "export const p = 1"
expect 0 tdd-guard.sh "$(w src/lib/pricing.ts x)" "advises missing test" "TDD"
mk tests/pricing.test.ts "test"
out="$(printf '%s' "$(w src/lib/pricing.ts x)" | bash .claude/hooks/tdd-guard.sh)"; [ -z "$out" ] && pass=$((pass+1)) || { fail=$((fail+1)); echo "FAIL [tdd-guard] silent when test exists"; }

# check-a11y
mk src/components/Card.tsx '<div onClick={go}><img src="/a.png"></div>'
expect 0 check-a11y.sh "$(w src/components/Card.tsx x)" "flags missing alt + div onClick" "alt.*|click"
mk src/components/Ok.tsx '<button onClick={go}><img src="/a.png" alt="Logo"/></button>'
out="$(printf '%s' "$(w src/components/Ok.tsx x)" | bash .claude/hooks/check-a11y.sh)"; [ -z "$out" ] && pass=$((pass+1)) || { fail=$((fail+1)); echo "FAIL [check-a11y] clean file flagged: $out"; }

# scan-security
mk src/server/q.ts 'db.query(`SELECT * FROM users WHERE id = ${id}`)'
expect 0 scan-security.sh "$(w src/server/q.ts x)" "flags SQL interpolation" "SQL"
mk src/components/Html.tsx '<div dangerouslySetInnerHTML={{__html: post.body}} />'
expect 0 scan-security.sh "$(w src/components/Html.tsx x)" "flags raw HTML" "raw HTML"

# check-perf-budget
mk src/util/date.ts "import moment from 'moment'"
expect 0 check-perf-budget.sh "$(w src/util/date.ts x)" "flags moment" "moment"

# full rigor turns advice into blocking feedback
bash .claude/scripts/config-set.sh modes.rigor=full >/dev/null
expect 2 scan-security.sh "$(w src/server/q.ts x)" "full rigor blocks security smell"
rm tests/pricing.test.ts
expect 2 tdd-guard.sh "$(w src/lib/pricing.ts x)" "full rigor blocks missing test"
bash .claude/scripts/config-set.sh modes.rigor=minimal >/dev/null
expect 0 validate-commit.sh "$(b 'git commit -m "wip"')" "minimal rigor only warns on message" "Conventional"

# lifecycle hooks never fail
for h in session-start.sh detect-gaps.sh pre-compact.sh session-stop.sh log-agent.sh log-agent-stop.sh notify.sh; do
  expect 0 "$h" '{"session_id":"abc","agent_type":"ui-engineer","message":"hi"}' "$h exits 0"
done
grep -q "ui-engineer" production/session-logs/agents.log && pass=$((pass+1)) || { fail=$((fail+1)); echo "FAIL agent log not written"; }

echo "hooks: $pass passed, $fail failed"
[ "$fail" -eq 0 ]
