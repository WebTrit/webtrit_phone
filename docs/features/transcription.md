# Transcription

Client-side speech-to-text for media the app holds: audio is transcribed by a
Whisper engine (on-device or an OpenAI-compatible endpoint) through a
session-wide fire-and-forget pool, results land in a media-agnostic database
table, and consumers observe them through their own queries. Voicemail is the
first consumer; call recordings or chat voice notes can plug into the same
pipeline without schema or engine changes.

Last reviewed: 2026-07-14

## Where it lives

- `packages/data/app_transcription/` - the self-contained, storage-agnostic
  engine package:
    - `src/transcription_datasource.dart` - `TranscriptionDataSource`
      contract: bytes -> text, an `engine` id string, `dispose()`.
    - `src/local_whisper_transcription_datasource*.dart` - on-device
      whisper.cpp via `whisper_ggml` (io implementation + web stub behind a
      conditional import); converts input to 16 kHz mono WAV with the bundled
      ffmpeg, downloads the ggml model on first use, engine id
      `whisper-ggml:<model>`.
    - `src/remote_whisper_transcription_datasource.dart` - any
      OpenAI-compatible `POST .../audio/transcriptions` endpoint; accepts a
      full URL or its `/v1` base, optional Bearer key, engine id
      `openai-compatible:<model>`. Builds its own HTTP client internally
      (`_http_client` stays a package detail).
    - `src/transcription_service.dart` - `TranscriptionService`, the pool
      (see below), and `MediaTranscriber`, the narrow consumer contract.
    - `src/transcription_store.dart` - `TranscriptionStore`, the storage
      delegate the application implements.
    - `src/transcription_config.dart` + `src/transcription_datasource_factory.dart` -
      `TranscriptionConfig` (the resolved config vocabulary) and
      `createTranscriptionDataSource(config)`: config -> engine mapping lives
      in the package; the app only resolves the white-label config into
      `TranscriptionConfig` and supplies certificates and timeouts.
- `packages/data/app_database/` - persistence:
    - `src/tables/transcription_table.dart` - the `transcriptions` table
      (schema v26): PK `(media_type, media_id)`, `transcript`, `status`,
      `engine`.
    - `src/daos/transcriptions_dao.dart` - upsert (explicit companion so
      nulls really clear fields), per-media and per-type deletes,
      `clearStatuses` for stale in-progress recovery.
    - `src/daos/voicemail_dao.dart` - the voicemail-side queries: the list
      join with transcriptions, `getVoicemailsPendingTranscription`,
      `watchVoicemailsMissingTranscription`, `deleteOrphanTranscriptions`.
- App-side wiring:
    - `lib/data/feature_access.dart` - `TranscriptionMapper` resolves the
      theme `AppConfigTranscription` into the package `TranscriptionConfig`.
    - `lib/repositories/transcription/drift_transcription_store.dart` -
      `DriftTranscriptionStore`: the only place where pool output meets the
      database; also classifies failures and handles 401.
    - `lib/repositories/transcription_model/transcription_model_repository.dart` -
      prefs persistence of the user's model override (`transcription-model`).
    - `lib/services/transcription_model_service.dart` -
      `TranscriptionModelService`: session-wide owner of the model choice.
    - `lib/app/router/main_shell.dart` - providers: the pool
      (`TranscriptionService` over the datasource builder and the drift
      store) and the model service; the voicemail repository receives the
      pool as `MediaTranscriber`.
- Consumers (voicemail today):
    - `lib/repositories/voicemail/voicemail_repository.dart` - enqueues
      pending voice messages, forgets deleted ones, sweeps orphans.
    - `lib/features/settings/features/voicemail/` - the list UI
      (`VoicemailTile` renders the transcript states) and the overflow menu.
    - `lib/features/settings/features/transcription_settings/` - the model
      selection page (route `settings/transcription-settings`).

## Configuration

Top-level `transcription` section of the white-label app config
(`assets/themes/app.config.json`; theme models `AppConfigTranscription*` in
`packages/webtrit_appearance_theme`, resolved by `FeatureAccess` into the
package-owned `TranscriptionConfig`). Off by default.

```json
"transcription": {
  "mode": "disabled | local | remote",
  "language": "optional ISO 639-1 hint; omit to auto-detect",
  "local": { "model": "base" },
  "remote": { "url": "https://stt.example.com/v1", "apiKey": "optional", "model": "whisper-1" }
}
```

- `mode` - source selector; unknown values disable the feature. `local` is
  not available on web (FFI) and quietly disables itself there.
- `language` - passed to the engine as a hint; empty means auto-detect per
  message.
- `local.model` - the Whisper tier downloaded to the device (`tiny`, `base`,
  `small`, ...). This is only the predefined default: the user may switch the
  tier at runtime (see Model choice), there is no brand pinning flag.
- `remote.url` - the endpoint base; `audio/transcriptions` is appended when
  not already present. The remote mode stays disabled while it is missing or
  invalid.

The configurator still edits the pre-promotion `voicemail.transcription`
path and needs a follow-up for this section.

## Architecture

```
consumer (voicemail repository)                    settings page
  | enqueue / forget (MediaTranscriber)              | setModel
  v                                                  v
TranscriptionService (pool, session-wide)  <--- TranscriptionModelService
  | transcribe via TranscriptionDataSource           | persists override
  | lifecycle facts (TranscriptionStore)             v
  v                                            AppPreferences
DriftTranscriptionStore -> transcriptions table (drift)
                                ^
        consumer queries / watches (list join, missing-row watch)
```

### The pool - `TranscriptionService`

Provided session-wide in the main shell. Consumers hand media off through
`MediaTranscriber` and never await anything:

- `enqueue(mediaType, mediaId, loadAudio, {language})` - fire-and-forget.
  The audio loader is lazy (queued items do not hold payloads). Duplicates of
  a queued or in-flight item and calls while disabled are no-ops.
- `forget(mediaType, mediaId)` / `forgetAllForType(mediaType)` - the media
  was deleted: dequeues, invalidates in-flight results and removes stored
  rows through the store.
- `switchLocalModel(localModel)` - see Model choice.

Internals: a small worker pool draining one queue (concurrency is injected
per mode: 1 for the compute-bound local engine, where parallel inference only
multiplies memory pressure, 3 for the network-bound remote one; with one
worker processing is strictly sequential); an `_active` map (key -> request
instance) whose identity check invalidates stale writes (a forget, switch or
re-enqueue replaces the entry, so the old in-flight request no longer owns
its key); a generation counter bumped by switches; staleness re-checks
between the download and the inference so dead work is dropped before it
burns network or CPU. The pool is storage-agnostic: every lifecycle fact goes
to the injected `TranscriptionStore`.

### The store - `DriftTranscriptionStore`

Implements the delegate over the `transcriptions` table:

- `saveInProgress` first consults the row and returns false when a transcript
  already exists or the media is terminally `unavailable` - the pool then
  skips the work, so a raced re-enqueue cannot clobber a finished transcript.
- `saveFailure` classifies: `TranscriptionException.transient`, transport
  errors and 5xx roll the row back to "not attempted" (retried by the next
  pending pass); other 4xx are terminal (`unavailable`, never retried
  automatically). 401 rolls back, stops the queue and delegates to the
  session guard.
- A failed write of a successfully produced transcript is NOT a transcription
  failure: the row stays `inProgress` and the next pending pass retries.
- `resetStaleInProgress` runs once at session start: rows stuck `inProgress`
  by a killed run go back to "not attempted".

### The database is the single feedback channel

There is no event stream between the pool and its consumers. The voicemail
list joins the transcriptions table (`VoicemailTile` renders
transcript/progress/unavailable from the joined row), and re-enqueue is
driven by data: `watchVoicemailsMissingTranscription` emits voice messages
with no transcription row at all (freshly fetched or wiped for
regeneration), and the pool's own lifecycle writes take rows out of that
watch, so emissions cannot loop. Rows rolled back to a null status (transient
failures) are excluded from the watch and retried only by the fetch-time
pending query - one attempt per fetch.

### Consumer rules (voicemail)

- Transcription starts only after the first successful voicemail fetch and
  never while the server reports voicemail unsupported: a doomed audio
  download must not mark cached messages terminally unavailable.
- The pending pass also runs after failed refreshes, so transient failures do
  not starve behind a dead network.
- Deletion goes through `forget` (row removal + in-flight invalidation);
  orphan rows left by races are swept after each fetch
  (`deleteOrphanTranscriptions`); the local cache wipe uses
  `forgetAllForType`.
- Only `type == 'voice'` messages are eligible (fax is skipped); refetches
  upsert remote fields with a conflict-limited companion and never touch
  transcription data.
- The repository implements `Disposable` and cancels its database watches
  with the session (the database itself is app-scoped).

### Model choice

`TranscriptionModelService` (session-wide) owns the user's tier choice:

- `canSelectModel` - a purely functional gate: the pool is enabled AND the
  mode is `local` (the remote mode ignores the tier). The voicemail overflow
  menu shows the "Transcription model" entry only then.
- `setModel` switches the pool first and persists the prefs override after
  (a failed switch must not leave an override that silently applies on next
  start); rapid re-selection is serialized.
- The pool's `switchLocalModel` builds the replacement source first and
  no-ops when its engine id equals the current one (same tier re-picked, or
  a remote source that ignores the tier) - nothing is wiped then. A real
  engine change wipes the whole transcriptions table, which re-feeds the
  missing-row watch and regenerates every message with the new engine; when
  the wipe fails the current engine is kept and the error surfaces to the
  settings page.
- UI: `TranscriptionSettingsScreen` (pattern of the cache management page)
  lists Fast (`base`, ~142 MB), Balanced (`small`, ~466 MB), Accurate
  (`medium`, ~1.5 GB) plus the brand default when it is a different tier;
  the cubit's rollback is revision-guarded so an older failed attempt cannot
  clobber a newer successful selection. l10n keys live under
  `transcriptionSettings_*`.

## Adding a new media consumer

1. Pick a `media_type` constant (voicemail uses
   `kVoicemailTranscriptionMediaType` in `voicemail_dao.dart`) - no schema
   changes needed, the table is keyed by `(media_type, media_id)`.
2. Take `MediaTranscriber` (the provided `TranscriptionService`) in your
   repository and `enqueue` items with a lazy audio loader; call `forget` on
   deletion.
3. Query/watch the transcriptions table joined to your media for rendering,
   and drive re-enqueue from your own "missing a row" watch plus a pending
   query for transient retries (mirror the voicemail DAO queries).
4. Regeneration after a model switch comes for free: the wipe empties the
   table and your missing-row watch re-feeds the pool.

## Limitations / future work

- Transcription runs only while the app is alive (triggered by fetch or
  refresh); there is no background/push pipeline.
- `whisper_ggml` pulls `ffmpeg_kit_flutter_new_min` (app size cost); the
  engine sits behind `TranscriptionDataSource`, so swapping it (e.g.
  sherpa-onnx) is a single-class change.
- Whisper model files are cached by the engine and are not yet visible in
  the Storage & cache page.

## Tests

- `packages/data/app_transcription/test/` - datasource contract tests
  (remote request shape, endpoint resolution, auth, language, error mapping;
  local model validation).
- `packages/data/app_database/test/` - transcriptions dao (upsert null
  semantics, scoping, deletes), voicemail dao (join, missing-row watch,
  contact collapse), migration v26.
- `test/repository/voicemail_repository_test.dart` - the pool through the
  repository: success, failures transient/terminal, refetch idempotency,
  fax skip, model switch and regeneration, mid-flight switch discard,
  deleted-message race, unsupported-server gate.
- `test/data/transcription/` - factory mode switching and the pool's switch
  semantics; `test/features/settings/features/transcription_settings/` - the
  settings page.
