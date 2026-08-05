# Transcription

Speech-to-text for media the app holds: audio is sent to an OpenAI-compatible
transcription service through a session-wide fire-and-forget pool, results land
in a media-agnostic database table, and consumers observe them through their own
queries. Voicemail is the first consumer; call recordings or chat voice notes
can plug into the same pipeline without schema or engine changes.

Last reviewed: 2026-08-05

## Where it lives

- `packages/data/app_transcription/` - the self-contained, storage-agnostic
  engine package:
    - `src/transcription_datasource.dart` - `TranscriptionDataSource`
      contract: bytes -> text, an `engine` id string, `dispose()`.
    - `src/remote_whisper_transcription_datasource.dart` - any
      OpenAI-compatible `POST .../audio/transcriptions` endpoint; accepts a
      full URL or its `/v1` base, optional Bearer key, engine id
      `openai-compatible:<model>`. Builds its own HTTP client internally
      (`_http_client` stays a package detail). Pure Dart: the package carries
      no native dependency at all.
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
      theme `AppConfigTranscription` into the package `TranscriptionConfig`
      and picks the service credential up from the environment.
    - `lib/repositories/transcription/transcription_store_drift_impl.dart` -
      `TranscriptionStoreDriftImpl`: the only place where pool output meets the
      database; also classifies failures and handles 401.
    - `lib/app/router/main_shell.dart` - provides the pool
      (`TranscriptionService` over the datasource and the drift store); the
      voicemail repository receives it as `MediaTranscriber`.
- Consumers (voicemail today):
    - `lib/repositories/voicemail/voicemail_repository.dart` - enqueues
      pending voice messages, forgets deleted ones, sweeps orphans.
    - `lib/features/settings/features/voicemail/` - the list UI
      (`VoicemailTile` renders the transcript states).

## Configuration

Top-level `transcription` section of the white-label app config
(`assets/themes/app.config.json`; theme models `AppConfigTranscription*` in
`packages/webtrit_appearance_theme`, resolved by `FeatureAccess` into the
package-owned `TranscriptionConfig`).

```json
"transcription": {
  "mode": "remote | disabled",
  "language": "optional ISO 639-1 hint; omit to auto-detect",
  "remote": { "url": "https://api.groq.com/openai/v1", "model": "whisper-large-v3-turbo" }
}
```

- `mode` - `remote` or `disabled` (which keeps a configured endpoint in place
  while the feature is off); unknown values disable the feature.
- `language` - passed to the service as a hint; empty means auto-detect per
  message.
- `remote.url` - the endpoint base; `audio/transcriptions` is appended when
  not already present. Transcription stays off while it is missing or invalid,
  which is what the stock config ships with.
- `remote.model` - the model name the service expects.

The credential is NOT part of this section. It is billed per request, so it
comes from the build-time `WEBTRIT_APP_TRANSCRIPTION_API_KEY` dart-define
instead of travelling with the theme, and it is simply left unset for endpoints
that authenticate by network placement or client certificates (the datasource
also trusts the app's configured certificates, so a self-hosted service behind a
private CA works out of the box).

## Architecture

```
consumer (voicemail repository)
  | enqueue / forget (MediaTranscriber)
  v
TranscriptionService (pool, session-wide)
  | transcribe via TranscriptionDataSource (HTTP multipart)
  | lifecycle facts (TranscriptionStore)
  v
TranscriptionStoreDriftImpl -> transcriptions table (drift)
                                ^
        consumer queries / watches (list join, missing-row watch)
```

### The pool - `TranscriptionService`

Provided session-wide in the main shell. Consumers hand media off through
`MediaTranscriber` and never await anything:

- `enqueue(mediaType, mediaId, loadAudio, {language})` - fire-and-forget.
  The audio loader is lazy (queued items do not hold payloads). Duplicates of
  a queued or in-flight item and calls while disabled are no-ops. Every
  queued item is marked in progress immediately (guarded, so a finished
  transcript is never overwritten), so the whole backlog shows "transcribing"
  instead of a blank list while the workers catch up.
- `forget(mediaType, mediaId)` / `forgetAllForType(mediaType)` - the media
  was deleted: dequeues, invalidates in-flight results and removes stored
  rows through the store.

Internals: a small worker pool draining one queue (concurrency 3 in the app -
the work is network-bound); an `_active` map (key -> request instance) whose
identity check invalidates stale writes (a forget or re-enqueue replaces the
entry, so the old in-flight request no longer owns its key); staleness
re-checks between the download and the request so dead work is dropped before
it burns network. The pool is storage-agnostic: every lifecycle fact goes to
the injected `TranscriptionStore`.

### The store - `TranscriptionStoreDriftImpl`

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
with no transcription row at all (freshly fetched or wiped by a cache clear),
and the pool's own lifecycle writes take rows out of that watch, so emissions
cannot loop. Rows rolled back to a null status (transient failures) are
excluded from the watch and retried only by the fetch-time pending query - one
attempt per fetch.

### Consumer rules (voicemail)

- Transcription starts only after the first successful voicemail fetch and
  never while the server reports voicemail unsupported: a doomed audio
  download must not mark cached messages terminally unavailable.
- The pending pass also runs after failed refreshes, so transient failures do
  not starve behind a dead network.
- Deletion goes through `forget` (row removal + in-flight invalidation);
  orphan rows left by races are swept after each fetch
  (`deleteOrphanTranscriptions`). The whole-database cache wipe clears the
  transcriptions table with everything else; the missing-row watch re-feeds
  the pool after the next fetch.
- Only `type == 'voice'` messages are eligible (fax is skipped); refetches
  upsert remote fields with a conflict-limited companion and never touch
  transcription data.
- The repository implements `Disposable` and cancels its database watches
  with the session (the database itself is app-scoped).

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

## Limitations / future work

- Transcription runs only while the app is alive (triggered by fetch or
  refresh); there is no background/push pipeline.
- The transcript is produced per install: two devices of the same user each
  send the audio and pay for it. Moving the work behind our own service (so
  one transcript is shared and no credential ships in the build) is the
  natural next step; the client change would be limited to the datasource.
- The credential lives in the build. It is not extractable-proof - prefer a
  brand-owned key with a spend cap, or an endpoint that needs no key at all.

## Tests

- `packages/data/app_transcription/test/` - datasource contract tests
  (remote request shape, endpoint resolution, auth, language, error mapping)
  and the pool (concurrency, immediate in-progress marking, forget after
  dispose).
- `packages/data/app_database/test/` - transcriptions dao (upsert null
  semantics, scoping, deletes), voicemail dao (join, missing-row watch,
  contact collapse), migration v26.
- `test/repository/voicemail_repository_test.dart` - the pool through the
  repository: success, failures transient/terminal, refetch idempotency,
  fax skip, deleted-message race, unsupported-server gate.
- `test/mappers/transcription_mapper_test.dart` - config resolution and the
  credential coming from the environment rather than the theme.
