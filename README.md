<p align="center">
  <h1 align="center">Claude Code Web Studios</h1>
  <p align="center">
    Turn a single Claude Code session into a full web development studio.
    <br />
    Frontend + backend. Discovery to growth. You make the calls.
    <br />
    55 agents · 97 skills · 17 hooks · 18 rules · 45 templates
  </p>
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="MIT License"></a>
  <a href=".claude/agents"><img src="https://img.shields.io/badge/agents-55-blueviolet" alt="55 agents"></a>
  <a href=".claude/skills"><img src="https://img.shields.io/badge/skills-97-green" alt="97 skills"></a>
  <a href=".claude/hooks"><img src="https://img.shields.io/badge/hooks-17-orange" alt="17 hooks"></a>
  <a href=".claude/rules"><img src="https://img.shields.io/badge/rules-18-red" alt="18 rules"></a>
  <a href="https://code.claude.com/docs"><img src="https://img.shields.io/badge/built%20for-Claude%20Code-f5f5f5" alt="Built for Claude Code"></a>
</p>

---

## Why

Building a website solo with AI is fast, and a single chat has no structure.
Nobody asks who the user is. Nobody writes the API contract before the UI calls
it. Nobody checks the Lighthouse score, the alt text or the webhook signature.

**Web Studios** gives your session the structure of a real web agency.
- **Directors** guard the product, the architecture and the brand.
- **Leads** own frontend, backend, UX, QA, DevOps, security, growth, content and releases.
- **Specialists** cover your exact stack, from Next.js to Laravel and from Postgres to Cloudflare.

Hooks catch secrets, missing tests, accessibility and security smells as code is
written.

You still make every decision. The team asks the right questions, drafts the
work, and catches the mistakes.

## Contents

- [What's included](#whats-included)
- [Studio hierarchy](#studio-hierarchy)
- [Lifecycle and slash commands](#lifecycle-and-slash-commands)
- [Getting started](#getting-started)
- [Configuration](#configuration)
- [Quality system](#quality-system)
- [Reused skills (dependencies)](#reused-skills-dependencies)
- [Project structure](#project-structure)
- [Customising](#customising)
- [Self-tests](#self-tests)

## What's included

| Category | Count | Where |
|---|---|---|
| Agents | 55 | [`.claude/agents/`](.claude/agents): roster in [`agent-roster.md`](.claude/docs/agent-roster.md) |
| Skills (slash commands) | 97 | [`.claude/skills/`](.claude/skills): conventions in [`skill-conventions.md`](.claude/docs/skill-conventions.md) |
| Hooks | 17 | [`.claude/hooks/`](.claude/hooks): see [`hooks-reference.md`](.claude/docs/hooks-reference.md) |
| Path-scoped rules | 18 | [`.claude/rules/`](.claude/rules) |
| Templates | 45 | [`.claude/docs/templates/`](.claude/docs/templates) |
| Stage gates | 4 | [`.claude/docs/gates.md`](.claude/docs/gates.md) |
| Stack matrix | 40+ stack values | [`.claude/docs/stack-matrix.md`](.claude/docs/stack-matrix.md) |

## Studio hierarchy

```
Tier 1  Directors   product-director · technical-director · design-director · producer (PM)

Tier 2  Leads       product-manager · lead-frontend · lead-backend · ux-lead · qa-lead
                    devops-lead · security-lead · growth-lead · content-lead · release-manager

Tier 3  Specialists ui-engineer · api-engineer · data-engineer · test-engineer
                    performance-engineer · accessibility-specialist · realtime-engineer · prototyper
                    auth · payments · cms · ai-features · email
                    ui-designer · ux-researcher · copywriter
                    seo · analytics · observability · i18n · privacy-compliance · mobile (PWA/Expo)

        Stack       nextjs · remix · nuxt-vue · sveltekit · astro · angular · solid-qwik · tailwind-shadcn
                    node-backend · python-backend · go-backend · laravel · rails · baas (Supabase/Firebase)
                    postgres (Prisma/Drizzle) · mongodb · redis-queue · hosting-platform · cloud-infra
```

Disagreements escalate to the director who owns the domain: product, technical
or design, or the producer for schedule. The user decides. Common agency roles
(scrum master, BA, DBA, solutions architect…) map onto these agents; see
[role aliases](.claude/docs/agent-roster.md#role-aliases).

## Lifecycle and slash commands

**Discovery → Design → Build → Launch → Grow**, with a `/gate-check` between
stages. Full guide: [`docs/WORKFLOW-GUIDE.md`](docs/WORKFLOW-GUIDE.md).

| Stage | Key commands |
|---|---|
| **Start** | `/start` · `/help` · `/adopt` (existing site) · `/setup-stack` · `/settings` · `/install-deps` |
| **Discovery** | `/brainstorm` · `/market-research` · `/competitor-audit` · `/personas` · `/write-prd` · `/scope-check` · `/estimate` · `/tech-spike` |
| **Design** | `/brand-identity` · `/design-system` · `/design-tokens` · `/sitemap` · `/ux-flow` · `/wireframe` · `/ux-review` · `/feature-spec` · `/api-contract` · `/data-model` · `/create-architecture` · `/architecture-decision` · `/architecture-review` · `/content-strategy` · `/design-review` |
| **Build** | `/create-epics` · `/create-stories` · `/sprint-plan` · `/dev-story` · `/tdd` · `/review-code` · `/story-done` · `/team-feature` · `/add-auth` · `/add-payments` · `/add-cms` · `/add-ai-feature` · `/add-realtime` · `/add-i18n` · `/db-migration` · `/test-setup` · `/e2e` |
| **Audits** | `/perf-audit` · `/a11y-audit` · `/security-audit` · `/dependency-audit` · `/seo-audit` · `/privacy-audit` |
| **Launch** | `/ci-setup` · `/deploy-setup` · `/team-launch` · `/launch-checklist` · `/release-checklist` · `/smoke-check` · `/load-test` · `/changelog` · `/release-notes` |
| **Grow** | `/analytics-plan` · `/experiment` · `/funnel-review` · `/cro-review` · `/email-flows` · `/observability-setup` · `/incident` · `/hotfix` · `/postmortem` · `/retrospective` · `/content-calendar` |
| **Teams** | `/team-frontend` · `/team-backend` · `/team-design` · `/team-qa` · `/team-launch` · `/team-growth` · `/team-polish` |

Run `/help all` for the full catalogue, or `/help <topic>` (e.g. `/help payments`).

## Getting started

**Requirements:** [Claude Code](https://code.claude.com/docs), Git, Bash. `jq` or
`python3` are optional; hooks use them to parse input and fail open without them.
Node/Python/etc. are needed only for your chosen stack.

**New project (template):**
```bash
git clone https://github.com/chatquill/claude-code-websites my-site
cd my-site && git remote remove origin   # make it yours
claude
```
Then type `/start`.

**Existing project (plugin):**
```text
/plugin marketplace add chatquill/claude-code-websites
/plugin install web-studios@claude-code-web-studios
/web-studios:start
```
`/start` offers to copy the helper scripts and `project.yaml` into your repo,
then runs `/adopt` to detect your stack and map what exists.

**Typical first hour:**
`/start` → `/brainstorm` → `/write-prd` → `/setup-stack` → `/brand-identity` → `/feature-spec` → `/create-stories` → `/dev-story`

## Configuration

[`project.yaml`](project.yaml) is the single source of truth: project type,
stage, stack, specialists, budgets (Lighthouse, Web Vitals, JS kB, image kB),
accessibility standard, locales, privacy regions and modes.
Per-developer overrides go in `project.local.yaml` (gitignored). See
[`config-resolution.md`](.claude/docs/config-resolution.md).

| Mode | Values | Effect |
|---|---|---|
| `modes.rigor` | `minimal` / `standard` / `full` | How strict tests, gates, hooks and docs are |
| `modes.automation` | `ask` / `batch` / `auto` | How often agents ask before writing docs (code and outward actions always ask) |

## Quality system

- **Collaboration protocol:** every task goes Question → Options → Decision → Draft → Approval. See [`COLLABORATIVE-DESIGN-PRINCIPLE.md`](docs/COLLABORATIVE-DESIGN-PRINCIPLE.md).
- **Hard limits:** `settings.json` denies:
  - reading or writing `.env` files and keys
  - force-push and `git reset --hard`
  - production deploys (`vercel --prod`, `wrangler deploy`, `fly deploy`…)
  - `terraform apply`
  - migration deploys and resets against real databases
  - `npm publish`
- **Hooks:**
  - Always blocking: secrets and `.env` writes.
  - Blocking from `standard` rigor: non-conventional commit messages.
  - Blocking under `full` rigor: failing tests on push, and the TDD, a11y, performance and security checks.
- **Rules:** path-scoped standards load only when Claude edits matching files. They cover components, styling, API routes, server actions, databases, auth, payments, AI, realtime, i18n, SEO, env/config, infra, tests, prototypes and docs.
- **Gates:** `/gate-check` checks each stage's required artifacts and gets director sign-off (`PASS` / `CONCERNS` / `FAIL`).

## Reused skills (dependencies)

The studio calls proven public skills instead of re-writing them. They are
optional, and every skill falls back to its own checklist when one is missing.
Install them with `/install-deps`.

- [anthropics/skills](https://github.com/anthropics/skills): `frontend-design`, `webapp-testing`, `theme-factory`, `web-artifacts-builder`, `mcp-builder`, `claude-api`
- [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills): `web-design-guidelines`, `react-best-practices`, `composition-patterns`, `react-native-skills`, `deploy-to-vercel`
- Playwright MCP for browser-driven e2e, a11y, perf and visual checks

Details: [`docs/RECOMMENDED-SKILLS.md`](docs/RECOMMENDED-SKILLS.md).

## Project structure

```
CLAUDE.md               studio constitution (always loaded)
project.yaml            config: stack, stage, budgets, modes
.claude/                agents, skills, hooks, rules, scripts, docs/templates, settings
.claude-plugin/         plugin, marketplace and plugin-hooks manifests
docs/                   product/ design/ specs/ architecture/ content/  ← your project's docs
production/             epics, stories, sprints, audits, releases, incidents, experiments
src/  tests/            your application (scaffolded by /setup-stack)
studio-tests/           self-tests for the framework
```

Full map: [`.claude/docs/directory-structure.md`](.claude/docs/directory-structure.md).

## Customising

- **Add an agent:** copy a similar one in `.claude/agents/`, then add it to `agent-roster.md`.
- **Add a skill:** follow `skill-conventions.md`, add it to `docs/BLUEPRINT.md` §4, then run `/skill-test <name>`.
- **Change standards:** edit `.claude/rules/*.md` and `.claude/docs/coding-standards.md`.
- **Change budgets or rigor:** run `/settings budgets.lighthouse.performance=95`, `/settings modes.rigor=full`, and so on.

## Self-tests

```bash
bash studio-tests/run.sh          # syntax + lint (agents, skills, rules, templates, cross-refs) + script + hook behaviour
bash studio-tests/run.sh skill dev-story
```

CI runs the same suite on every push ([`.github/workflows/studio-tests.yml`](.github/workflows/studio-tests.yml)).

## Credits

Structure inspired by
[Claude Code Game Studios](https://github.com/Donchitos/Claude-Code-Game-Studios)
(MIT), re-designed from scratch for web development.

## License

MIT. See [LICENSE](LICENSE).
