# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this
repository.

## Package Overview

This directory contains a single Dart package: **`app_database`** — the complete data persistence
layer for WebTrit Phone, built on **Drift** (type-safe SQLite ORM). It is fully encapsulated:
features and BLoCs in the main app use only DAOs, never `AppDatabase` directly.

## Common Commands

```bash
# Generate Drift code (after editing tables or DAOs)
dart run build_runner build

# Watch mode for continuous generation
dart run build_runner watch

# Update DB schema after adding/modifying a table (run from app_database/)
dart run bin/create_new_schema_dump_and_test_migration.dart

# Run all tests
dart test

# Run a single test file
dart test test/migrations_test.dart
dart test test/contacts_dao_test.dart
```

## Architecture

### Key Directories

- `lib/src/tables/` — 27 Drift table definitions
- `lib/src/daos/` — 13 DAOs (one per domain area)
- `lib/src/migrations/` — one file per schema version (`migration_v2.dart` … `migration_vN.dart`)
- `lib/src/migrations/generated/` — generated schema helpers (do not edit)
- `lib/src/drift_schemas/` — JSON schema snapshots (do not edit)
- `lib/src/connection/` — platform-aware DB connection (native SQLite / WASM)
- `bin/` — schema generation utility
- `test/` — migration matrix tests and DAO unit tests

### Platform Connection

Conditional imports select the connection implementation:

| Platform       | File                     | Backend                                       |
|----------------|--------------------------|-----------------------------------------------|
| Mobile/Desktop | `connection/native.dart` | NativeDatabase, WAL mode, 5 s busy timeout    |
| Web            | `connection/web.dart`    | WasmDatabase (sqlite3.wasm + drift_worker.js) |

### Schema Migration Workflow

1. Edit table definition(s) in `lib/src/tables/`.
2. Create `lib/src/migrations/migration_vN.dart` extending `Migration`.
3. Register it in `lib/src/migrations/migrations.dart`.
4. Run: `dart run bin/create_new_schema_dump_and_test_migration.dart` — generates new schema JSON
   and Dart helpers and increments the version.
5. Add migration tests in `test/migrations_test.dart` using `SchemaVerifier`.

### Table Conventions

- Enums: use `intEnum<T>()`.
- Foreign keys: `customConstraint('NOT NULL REFERENCES table_name(id) ON DELETE CASCADE')`.
- Timestamps: include `insertedAt` / `updatedAt`; do not update `updatedAt` manually — triggers
  handle it.
- Prefer `insertReturning` with `onConflict: DoUpdate(...)` for upserts.

### DAO Conventions

- All DAOs extend `DatabaseAccessor<AppDatabase>` with `@DriftAccessor(tables: [...])`.
- DAOs return domain-level compound objects (e.g. `FullContactData`) that join related tables.
- Stream-based (`watch()`) methods are used for reactive UI updates.
- Generated `.g.dart` files must never be edited manually.

### Domain Areas

| Domain        | Tables                                                                          | DAO                                                   |
|---------------|---------------------------------------------------------------------------------|-------------------------------------------------------|
| Contacts      | contacts, contact_phones, contact_emails                                        | ContactsDao, ContactPhonesDao, ContactEmailsDao       |
| Call history  | call_logs                                                                       | CallLogsDao, RecentsDao                               |
| Chats         | chats, chat_members, chat_messages, chat outbox (3 tables), cursors (2 tables)  | ChatsDao                                              |
| SMS           | sms_conversations, sms_messages, sms outbox (3 tables), cursors (2 tables)      | SmsDao                                                |
| Voicemail     | voicemail                                                                       | VoicemailDao                                          |
| Notifications | active_message_notifications, system_notifications, system_notifications_outbox | ActiveMessageNotificationsDao, SystemNotificationsDao |
| Presence      | presence_info                                                                   | PresenceInfoDao                                       |
| Favorites     | favorites                                                                       | FavoritesDao                                          |
| CDR           | cdr                                                                             | CdrsDao                                               |

### Outbox Pattern

Write operations that need offline support use dedicated outbox tables (e.g. `chat_outbox_message`,
`sms_outbox_messages`). Edits, deletes, and read receipts are each tracked in their own outbox table
and synced asynchronously.

## Code Style

- `prefer_single_quotes`, 120-character page width, `lints/recommended`.
- `build.yaml` sets `use_data_class_name_for_companions: true` for Drift code generation.
- Never edit `*.g.dart` files — regenerate via `build_runner`.
