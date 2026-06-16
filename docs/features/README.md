# Feature docs

Living, feature-oriented overviews of the app. Each file describes one user-facing
feature: what it does, the UX states, the widgets and bloc that back it, and what
is currently changing. These are kept up to date as the feature evolves - update
the relevant file in the same PR that changes the feature.

How these differ from the other docs:

- **Feature docs (here)** - product-level: what the user sees, the screen states,
  the in-progress redesigns, and pointers into the deeper docs.
- **Architecture docs** - implementation deep-dives: blocs, events, state machines,
  isolates. Feature-specific ones live here next to the feature doc
  (e.g. [`call_architecture.md`](call_architecture.md)); cross-cutting ones stay at the
  docs root (e.g. [`../signaling_architecture_target.md`](../signaling_architecture_target.md)
  - the signaling layer, shared by call and push).
- **Scenario docs** - specific flows with diagrams; feature-specific ones live here too
  (e.g. [`incoming_call_scenarios.md`](incoming_call_scenarios.md)).

A feature doc should link to those rather than repeat them.

## Index

| Feature | Doc | Status |
|---|---|---|
| App update / version compatibility | [app-update.md](app-update.md) | Active - force-update (app side) and iOS pending |
| Call | [call.md](call.md) | Active - UI redesign in progress |

## Conventions

- One file per feature, kebab-case (`call.md`, `contacts.md`).
- Start with a one-line summary and a `Last reviewed:` date.
- Describe the CURRENT behavior first; put in-progress work under a clearly
  marked "Redesign / in progress" section so the doc never lies about what ships.
- Link code by relative path (`lib/features/<name>/...`) and link sibling docs
  relatively.
- Plain ASCII only (matches the repo convention).
