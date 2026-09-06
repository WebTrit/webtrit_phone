# Where cold start time goes

What the app spends before its first frame, measured rather than assumed, and what is
worth attacking next.
Last reviewed: 2026-08-24.

## How this was measured

Profile builds of the same commit range on one device, signed in against a real backend,
three interleaved blocks of `install -> one discarded warm-up -> three measured starts`.
A start is made cold by sending the app to the home screen, killing it with `am kill` and
waiting for its pid to disappear; `am kill` only reaches background processes, so killing
a foregrounded app silently leaves it running and every later number describes a warm
start instead.

Two numbers per run: `am start -W` `TotalTime`, which ends at the first frame, and the
app's own startup trace, which the app logs as `startup_complete total_ms=... stages=[...]`
from `main()` to the first frame.

Device: Xiaomi 25028RN03Y, Android 15. Numbers from a Huawei MAO-LX9N (Android 12, no
Google services) are quoted where they differ enough to matter - the shape holds, the
magnitudes do not.

## The breakdown

Medians of nine cold starts, milliseconds, with the spread in brackets.

| Segment | Median | Range | What it is |
|---|---|---|---|
| Before `main()` | ~1665 | - | Process start, engine, Dart snapshot, plugin registration. Not traced; inferred from `TotalTime` minus the trace. |
| `system-ui` | 225 | 181..268 | One awaited `SystemChrome.setEnabledSystemUIMode` in `lib/main.dart`, before anything else runs. |
| `bootstrap` | 439 | 408..488 | Everything in `lib/bootstrap.dart`: the parallel root wave plus the serial work after it. |
| trace total | 698 | 672..756 | `main()` to first frame. |
| `am start -W` | 2363 | 2323..2435 | Process launch to first frame. |

Inside `bootstrap`, the root wave runs its members concurrently, so the wave lasts as long
as its slowest member, not as long as their sum:

| Root | Median | Range |
|---|---|---|
| `secure-storage` | 342 | 321..370 |
| `app-info` | 96 | 48..343 |
| `app-themes` | 36 | 27..85 |
| `device-info` | 36 | 34..83 |
| `package-info` | 23 | 21..35 |
| `app-preferences` | 5 | 4..5 |
| `remote-config-cache` | 3 | 2..5 |

The serial tail after the wave - api clients, database isolate, callkeep, connectivity,
work manager - is around 90 ms in total, with `callkeep` (15) and `database-isolate` (10)
the largest single items.

Outside the wave but inside `bootstrap`: `platform` 53 (Firebase core 51 and local
notifications 43 run inside it).

## What this says

**Most of a cold start is not ours.** About 1.6 of the 2.4 seconds is spent before the
first line of Dart in `main()` runs. Nothing in the composition root can move it; app
size, the number of registered plugins and their native initialisation are what change it.

**Of what is ours, the single largest item is not in `bootstrap` at all.** `system-ui` is
one awaited platform call in `main.dart` and costs 225 ms here - and 1122 ms (201..1132)
on the Huawei, which is more than that device's entire `bootstrap`. It is awaited before
`bootstrap` starts, so it is pure serial cost.

**The root wave is bounded by its longest member, and there are two candidates.** Reading
the keychain is 342 ms; `app-info` is 96 ms with spikes past 400. Removing one leaves the
other, which is exactly what happened when the keychain read was taken out of the wave:
`bootstrap` moved from 439 to 426.

**The first frame is not the first useful screen.** The route guard for the main shell
waits for the cached system info and, if the session is read lazily, for the session too.
Making the first frame arrive earlier without giving that window something to show only
replaces the system splash with the app's own empty background.

## What was tried

Three changes were measured against this baseline. None of them moved startup.

`#1726` started the keychain read earlier so it would overlap with the rest of the wave.
On the Huawei: `bootstrap` 265.6 against 265.4 ms. The mechanism worked - the wait before
the first reader was 0.1 ms - but the read overlapped with nothing, because the startup
path is platform-channel calls serialised on one thread. The read simply took over the
waiting that `app-info` had been paying. Closed.

`#1727` moved the cached system info and the last push token out of the keychain into app
preferences, where they belong; they are not secrets. Merged, on its own merits, without a
startup claim.

`#1728` made every read lazy and asynchronous: a record is fetched the first time somebody
asks for it and remembered. Three arrangements were measured. Reading the session after
the wave cost 77 ms (`bootstrap` 509). Reading it inside the wave brought it back to par
(439 against 439). Taking it off the startup path entirely, with the app drawing before
the session is known and the guard waiting for it, gave `bootstrap` 426 and cold start
2329 against 2363 - about 30 ms, none of it visible, since the guard still waits.

The reason none of this pays: reading four records costs 344 ms and reading the entire
keychain costs 329. The price is bringing the keystore up, not the number of records
fetched. Closed.

## Candidates, in the order the numbers justify

1. **`system-ui`.** 225 ms here, over a second on the Huawei, awaited before `bootstrap`
   for a call that configures how system bars are drawn. Worth establishing whether the
   mode has to be applied before the first frame at all, and if it does, whether it has to
   be awaited on the startup path. Largest single controllable number in the trace.

2. **`app-info`.** Now the longest member of the wave when the keychain is not, 96 ms
   median with spikes past 400. It resolves an installation identifier through Firebase;
   worth checking what part of that is cache-able across launches.

3. **Something to show while the shell resolves.** The guard waits for cached system info
   even today. Any work that makes the first frame earlier is only worth doing together
   with a screen that belongs in that window.

4. **Before `main()`.** The largest segment by far, and the only lever is what the app
   loads at process start: plugin count, native initialisers, app size.

## Caveats

One device, one build flavour, medians of nine runs. The spread on individual roots is
wide - `app-info` ranged 48..343 ms in the same nine runs - so differences under about
30 ms are not distinguishable here. Cross-device magnitudes differ a lot: the same
keychain read is 342 ms on the Xiaomi and 151 ms on the Huawei, while `system-ui` is 225
against 1122. Conclusions about ordering hold; absolute numbers do not travel.
