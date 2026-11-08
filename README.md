<p align="center">
  <h1 align="center">Claude Code Web Studios</h1>
  <p align="center">
    Turn a single Claude Code session into a full web development studio.
    <br />
    Frontend + backend. Discovery to growth. You make the calls.
  </p>
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="MIT License"></a>
  <img src="https://img.shields.io/badge/agents-55-blueviolet" alt="55 agents">
  <img src="https://img.shields.io/badge/stage-Discovery→Grow-green" alt="Lifecycle">
  <a href="https://code.claude.com/docs"><img src="https://img.shields.io/badge/built%20for-Claude%20Code-f5f5f5" alt="Built for Claude Code"></a>
</p>

---

> **Status: under construction (Phase 2 of 7).** The foundation, config system,
> status line, `/start`, `/help` and all 55 agents are in place. The remaining skills,
> hooks, rules and templates land in the following phases. See
> [`docs/BLUEPRINT.md`](docs/BLUEPRINT.md) for the full plan and progress.

## Why

Building a website solo with AI is fast, and a single chat has no structure:
nobody asks who the user is, nobody writes the API contract before the UI
calls it, nobody checks the Lighthouse score, the alt text or the webhook
signature. **Web Studios** gives your session the structure of a real web
agency: directors who guard the product, the architecture and the brand; leads
who own frontend, backend, UX, QA, DevOps, security and growth; and
specialists for your exact stack.

You still make every decision. The team asks the right questions, drafts the
work, and catches the mistakes.

## What's included (target)

| Category | Count | Description |
|---|---|---|
| Agents | 55 | Directors, leads, core specialists, and stack specialists (Next.js, Nuxt, SvelteKit, Astro, Angular, Remix, Solid/Qwik, Node, FastAPI/Django, Go, Laravel, Rails, Supabase/Firebase, Postgres, MongoDB, Redis…) |
| Skills | ~97 | Slash commands for every stage: `/write-prd`, `/design-system`, `/feature-spec`, `/api-contract`, `/dev-story`, `/tdd`, `/add-payments`, `/perf-audit`, `/launch-checklist`, `/experiment`… |
| Hooks | 17 | Conventional commits, lint/typecheck, secret blocking, TDD guard, a11y + perf budgets, security patterns, dependency audit, session state + agent audit trail |
| Rules | 18 | Path-scoped standards for components, styling, API routes, server actions, DB migrations, auth, payments, AI, realtime, i18n, SEO, infra, tests |
| Templates | 44 | PRD, feature spec, OpenAPI contract, ADR, design system, threat model, launch checklist, experiment brief, postmortem… |

## Studio hierarchy

```
Directors   product-director · technical-director · design-director · producer
Leads       product-manager · lead-frontend · lead-backend · ux-lead · qa-lead
            devops-lead · security-lead · growth-lead · content-lead · release-manager
Specialists ui-engineer · api-engineer · data-engineer · test-engineer · performance-engineer
            accessibility-specialist · realtime-engineer · prototyper · auth · payments · cms
            ai-features · email · ui-designer · ux-researcher · copywriter · seo · analytics
            observability · i18n · privacy-compliance · mobile
Stack       nextjs · remix · nuxt-vue · sveltekit · astro · angular · solid-qwik · tailwind-shadcn
            node · python · go · laravel · rails · baas · postgres · mongodb · redis-queue
            hosting-platform · cloud-infra
```

## Lifecycle

**Discovery → Design → Build → Launch → Grow**, with a `/gate-check` between
each stage. See [`docs/WORKFLOW-GUIDE.md`](docs/WORKFLOW-GUIDE.md).

## Getting started

**As a template (new project):**
```bash
git clone https://github.com/chatquill/claude-code-websites my-site
cd my-site && git remote remove origin
claude
# then:  /start
```

**As a plugin (existing repo):**
```text
/plugin marketplace add chatquill/claude-code-websites
/plugin install web-studios@claude-code-web-studios
/start
```

**Optional dependencies:** reused public skills for visual design, UI
guidelines and browser testing. See
[`docs/RECOMMENDED-SKILLS.md`](docs/RECOMMENDED-SKILLS.md).

## Configuration

Everything lives in [`project.yaml`](project.yaml): project type, stage,
stack, performance and accessibility budgets, locales, privacy regions and
modes. `/start` sets the rigor (`minimal` / `standard` / `full`) and
automation (`ask` / `batch` / `auto`); `/setup-stack` fills the stack.

## Collaboration

Every task follows **Question → Options → Decision → Draft → Approval**.
Agents never commit, push, deploy, migrate a shared database, spend money or
read secrets on their own. See
[`docs/COLLABORATIVE-DESIGN-PRINCIPLE.md`](docs/COLLABORATIVE-DESIGN-PRINCIPLE.md).

## Credits

Structure inspired by
[Claude Code Game Studios](https://github.com/Donchitos/Claude-Code-Game-Studios)
(MIT), re-designed for web development.

## License

MIT. See [LICENSE](LICENSE).
