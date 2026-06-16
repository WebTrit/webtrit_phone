# Feature docs

Living, feature-oriented overviews of the app. Each file describes one user-facing
feature: what it does, the UX states, the widgets and bloc that back it, and what
is currently changing. These are kept up to date as the feature evolves - update
the relevant file in the same PR that changes the feature.

How these differ from the other docs:

- **Feature docs (here)** - everything about one user-facing feature, split by
  concern (see the file pattern below): an index, the product/UX view, and the
  code/architecture deep-dive.
- **Cross-cutting docs** - components shared by several features stay at the docs
  root (e.g. [`../signaling_architecture_target.md`](../signaling_architecture_target.md)
  - the signaling layer, shared by call and push). Feature docs link to them
  rather than repeat them.
- **Scenario docs** - specific flows with diagrams; feature-specific ones live here
  too (e.g. [`incoming_call_scenarios.md`](incoming_call_scenarios.md)).

## File pattern

Per feature `<name>` (kebab-case), keep the docs split by concern:

| File | Holds |
|------|-------|
| `<name>.md` | index/overview: one-line summary, "Where it lives", and links to the docs below |
| `<name>_ux.md` | product / UX: what the user can do, screen states, key widgets, in-progress redesign |
| `<name>_arch.md` | code / architecture: bloc, events, state machine, flows, isolates, key patterns |

Split only when a section grows enough to warrant it - a small feature can keep
everything in `<name>.md` and add `_ux` / `_arch` later. Scenario-style docs
(flows + diagrams) keep a descriptive name (e.g. `incoming_call_scenarios.md`).
The call feature is the reference layout: `call.md` + `call_ux.md` + `call_arch.md`.

## Index

| Feature | Doc | Status |
|---|---|---|
| App update / version compatibility | [app-update.md](app-update.md) | Active - force-update (app side) and iOS pending |
| Call | [call.md](call.md) | Active - UI redesign in progress |

## Conventions

- Name files per the "File pattern" above: `<name>.md` / `<name>_ux.md` /
  `<name>_arch.md`, kebab-case.
- Start with a one-line summary and a `Last reviewed:` date.
- Describe the CURRENT behavior first; put in-progress work under a clearly
  marked "Redesign / in progress" section so the doc never lies about what ships.
- Link code by relative path (`lib/features/<name>/...`) and link sibling docs
  relatively.
- Plain ASCII only (matches the repo convention).
