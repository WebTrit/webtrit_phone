# app_database

Complete data persistence layer for WebTrit Phone, built on **Drift** (type-safe SQLite ORM).
Fully encapsulated — features and BLoCs use only DAOs, never `AppDatabase` directly.

## Commands

Run all commands from `packages/data/app_database/`:

```bash
dart run build_runner build          # generate Drift code after editing tables/DAOs
dart run build_runner watch          # watch mode
dart run bin/create_new_schema_dump_and_test_migration.dart  # after adding/modifying a table
dart test
dart test test/migrations_test.dart
dart test test/contacts_dao_test.dart
```

## Architecture

- `lib/src/tables/` — 27 Drift table definitions
- `lib/src/daos/` — 13 DAOs (one per domain area)
- `lib/src/migrations/` — one file per schema version (`migration_v2.dart` … `migration_vN.dart`)
- `lib/src/migrations/generated/` — generated schema helpers (do not edit)
- `lib/src/drift_schemas/` — JSON schema snapshots (do not edit)
- `lib/src/connection/` — platform-aware DB connection

### Platform Connection

| Platform       | File                     | Backend                                        |
|----------------|--------------------------|------------------------------------------------|
| Mobile/Desktop | `connection/native.dart` | NativeDatabase, WAL mode, 5s busy timeout      |
| Web            | `connection/web.dart`    | WasmDatabase (sqlite3.wasm + drift_worker.js)  |

### Schema Migration Workflow

1. Edit table definition(s) in `lib/src/tables/`.
2. Create `lib/src/migrations/migration_vN.dart` extending `Migration`.
3. Register it in `lib/src/migrations/migrations.dart`.
4. Run `dart run bin/create_new_schema_dump_and_test_migration.dart`.
5. Add migration tests in `test/migrations_test.dart` using `SchemaVerifier`.

### Table Conventions

- Enums: `intEnum<T>()`.
- Foreign keys: `customConstraint('NOT NULL REFERENCES table_name(id) ON DELETE CASCADE')`.
- Timestamps: `insertedAt` / `updatedAt`; do not update `updatedAt` manually — triggers handle it.
- Prefer `insertReturning` with `onConflict: DoUpdate(...)` for upserts.

### DAO Conventions

- Extend `DatabaseAccessor<AppDatabase>` with `@DriftAccessor(tables: [...])`.
- Return domain-level compound objects (e.g. `FullContactData`) joining related tables.
- `watch()` methods for reactive UI updates.
- Never edit `.g.dart` manually.

#### Contact source priority (number collisions)

The same phone number can belong to BOTH a local (device phonebook) contact and an
external (PBX) contact. Any query that resolves a number to a single display contact
MUST make the winner deterministic instead of leaving it to SQLite's unspecified row
order. Use the shared ordering term, never an ad-hoc `ORDER BY sourceType`:

```dart
..orderBy(contactsTable.sourcePriorityOrder()) // defaults to external (PBX) first
```

`sourcePriorityOrder` lives in `daos/contact_source_priority.dart`. It uses an explicit
CASE (independent of the enum's int encoding) and takes a `ContactSourcePreference`
for the rare case where local priority is intentional.

- Single-contact lookups (`LIMIT 1`): add the ordering before the limit.
- Entry-centric joins (call_log/voicemail -> contact_phones -> contacts): a colliding
  number yields one joined row per contact, so order by the term AND collapse to one
  contact per entry (keep the first, which is the preferred source).

### Domain Areas

| Domain        | Tables                                                                         | DAO                                                    |
|---------------|--------------------------------------------------------------------------------|--------------------------------------------------------|
| Contacts      | contacts, contact_phones, contact_emails                                       | ContactsDao, ContactPhonesDao, ContactEmailsDao        |
| Call history  | call_logs                                                                      | CallLogsDao, RecentsDao                                |
| Chats         | chats, chat_members, chat_messages, chat outbox (3), cursors (2)               | ChatsDao                                               |
| SMS           | sms_conversations, sms_messages, sms outbox (3), cursors (2)                  | SmsDao                                                 |
| Voicemail     | voicemail                                                                      | VoicemailDao                                           |
| Notifications | active_message_notifications, system_notifications, outbox                    | ActiveMessageNotificationsDao, SystemNotificationsDao  |
| Presence      | presence_info                                                                  | PresenceInfoDao                                        |
| Favorites     | favorites                                                                      | FavoritesDao                                           |
| CDR           | cdr                                                                            | CdrsDao                                                |

### Outbox Pattern

Offline-support writes use dedicated outbox tables (e.g. `chat_outbox_message`,
`sms_outbox_messages`). Edits, deletes, and read receipts each have their own outbox table,
synced asynchronously.

## Code Style

- `prefer_single_quotes`, 120-char width, `lints/recommended`.
- `build.yaml`: `use_data_class_name_for_companions: true`.
