# Ports and adapters

How a consumer in one layer gets a capability owned by another layer without
depending on its implementation. Introduced as a deliberate precedent: new
cross-layer capabilities follow this pattern, and existing direct
dependencies migrate to it gradually as they are touched.
Last reviewed: 2026-09-04.

## The problem

A bloc sometimes needs something that only infrastructure can do - run a
refresh through the schedule owner, and in the future possibly more. A direct
dependency on the service type points the arrow the wrong way: presentation
and domain code end up importing Flutter-bound infrastructure, every consumer
learns implementation details it must not know, and the service becomes
impossible to swap or to test around.

## The pattern

Three pieces, three homes:

- **Port** - an abstract contract declared from the consumer's side: what the
  consumer needs, in the consumer's terms, with no mention of who provides
  it. Ports live in `lib/common/`, which depends on nothing. Name the port by
  the capability's effect (`OnDemandRefresher`, not `PollingRefresher`): an
  implementation name in the port defeats its purpose. Document the
  semantics the consumer may rely on - error behavior included - because the
  port IS that promise.
- **Adapter** - a few lines of glue implementing a port on top of a concrete
  service. Adapters live in `lib/app/adapters/`. An adapter only delegates:
  it holds references and forwards calls. It contains no business logic - an
  adapter that grows logic is a use case trying to be born, and when a use
  case layer appears it will stand between consumers and ports, leaving
  adapters exactly as they are.
- **Wiring** - the composition root (the shell's provider layers, or
  `bootstrap()` for process-long objects) is the only place allowed to know
  every layer at once. It creates the adapter from the service and provides
  it AS the port, gated by the same conditions as the underlying capability,
  so a consumer can only obtain a port that actually works in this session.

The consumer depends on the port alone and receives it through its
constructor, exactly like it receives repositories today.

## What does not belong here

- **Mappers** - they have `lib/mappers/`.
- **Repositories and services** - they have their own layers; an adapter
  joins layers, it does not replace them.
- **Wrappers around repositories for their consumers** - blocs already talk
  to repositories directly by convention; that boundary works and is not
  what this pattern is for. Ports are for capabilities of services and
  infrastructure that consumers must not see.

## Testing

- A consumer is tested against a mocked port - a few lines, no service
  involved.
- The port's semantics are tested where they are implemented: in the
  service's own suite (the adapter is too thin to fail on its own).

## Adopters

- On-demand data refresh - the first port and the reference example:
  [`docs/refresh_ownership.md`](refresh_ownership.md).
