# Feature docs

Living, feature-oriented overviews of the app. Each file describes one user-facing
feature: what it does, the UX states, the widgets and bloc that back it, and what
is currently changing. These are kept up to date as the feature evolves - update
the relevant file in the same PR that changes the feature.

How these differ from the other docs:

- **Feature docs (here)** - everything about one user-facing feature, split by
  concern (see the file pattern below): the product/UX view and the
  code/architecture deep-dive. This file (`features.md`) is the central index;
  there is no separate per-feature index file.
- **Cross-cutting docs** - components shared by several features stay at the docs
  root (e.g. [`../signaling_architecture_target.md`](../signaling_architecture_target.md)
  - the signaling layer, shared by call and push). Feature docs link to them
  rather than repeat them.
- **Scenario docs** - specific flows with diagrams. They live where their scope is:
  a single-feature flow can sit in features/, but a cross-component one stays at the
  docs root (e.g. [`../incoming_call_scenarios.md`](../incoming_call_scenarios.md) -
  incoming-call delivery across push, callkeep and signaling).

## File pattern

Per feature `<name>` (kebab-case), split the docs by concern:

| File | Holds |
|------|-------|
| `<name>.md` | small feature - everything in one file |
| `<name>_ux.md` | product / UX: what the user can do, screen states, key widgets, in-progress redesign |
| `<name>_arch.md` | code / architecture: bloc, events, state machine, flows, isolates, key patterns |

A small feature stays a single `<name>.md` (e.g. `app-update.md`). Split into
`<name>_ux.md` + `<name>_arch.md` once it grows enough to warrant it; when you split,
drop the plain `<name>.md` rather than keep a redundant per-feature index - this
`features.md` is the index. Scenario-style docs (flows + diagrams) keep a descriptive
name and live by scope (cross-component ones at the docs root, e.g.
`../incoming_call_scenarios.md`). The call feature is the reference split layout:
`call_ux.md` + `call_arch.md`.

## Index

| Feature | Docs | Status |
|---|---|---|
| App update / version compatibility | [app-update.md](app-update.md) | Active - force-update (app side) and iOS pending |
| Call | [call_ux.md](call_ux.md) · [call_arch.md](call_arch.md) | Active - UI redesign in progress |

## Conventions

- Name files per the "File pattern" above: a single `<name>.md`, or the
  `<name>_ux.md` / `<name>_arch.md` split, kebab-case.
- Start with a one-line summary and a `Last reviewed:` date.
- Describe the CURRENT behavior first; put in-progress work under a clearly
  marked "Redesign / in progress" section so the doc never lies about what ships.
- Link code by relative path (`lib/features/<name>/...`) and link sibling docs
  relatively.
- Plain ASCII only (matches the repo convention).
