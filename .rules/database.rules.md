# Database & Data Layer Rules

## 1. Drift & Package Boundaries

* **Core Package:** The local database is powered by the `drift` package and is fully encapsulated
  within `packages/data/app_database`.
* **No Direct AppDatabase Access:** Features and BLoCs must never interact with `AppDatabase`
  directly. All database operations must be executed through specific Data Access Objects (DAOs)
  located in `packages/data/app_database/lib/src/daos/`.

## 2. Table Definitions & Schema

* **Timestamps:** Tables should include `DateTimeColumn get insertedAt` and
  `DateTimeColumn get updatedAt` where applicable. Do not update `updatedAt` manually in queries;
  the `AppDatabase` automatically generates SQLite triggers (`_generateTableAfterUpdateTrigger`) to
  handle this.
* **Enums:** Always use `intEnum<YourEnum>()` for enum columns.
* **Constraints & Foreign Keys:** Use `customConstraints` for compound unique keys (e.g.,
  `['UNIQUE(source_type, source_id)']`). For foreign keys, use
  `customConstraint('NOT NULL REFERENCES table_name(id) ON DELETE CASCADE')`.

## 3. DAOs (Data Access Objects) & Queries

* **Query Builder:** Strictly use Drift's query builder (e.g., `select()`, `into().insert()`).
* **Upserts:** Prefer `insertReturning` with `onConflict: DoUpdate(...)` for insert-or-update logic.
* **Data Aggregation:** When joining multiple tables (e.g., Contacts with Phones and Emails), create
  a dedicated aggregate class (e.g., `FullContactData`) within the DAO file and use custom gathering
  methods (`_gatherSingleContact`, `_gatherMultipleContacts`) to parse `JoinedSelectStatement`
  results.

## 4. Mappers & Domain Models

* **No Leaking Generated Classes:** Drift-generated data classes (e.g., `ContactData`,
  `ContactPhoneData`) MUST NOT leave the repository layer and MUST NOT be used in BLoCs or UI.
* **Domain Models:** Always use clean domain models located in `lib/models/` for business logic.
* **Using Mappers:** Use mapper classes located in `lib/mappers/drift/` to translate between
  Drift-generated classes (or DAO aggregate classes) and domain models.

## 5. Migrations Workflow (CRITICAL)

When modifying an existing table or adding a new one, you MUST follow this exact workflow:

1. **Create Migration Class:** Create a new migration file in
   `packages/data/app_database/lib/src/migrations/` (e.g., `migration_v19.dart`) extending
   `Migration`.
2. **Register Migration:** Add the new migration instance to the `migrations` list in
   `packages/data/app_database/lib/src/migrations/migrations.dart`.
3. **Generate Schema Dump:** Instruct the user to run the schema dump generator using:
   `dart run bin/create_new_schema_dump_and_test_migration.dart`.
4. **Testing:** Write or update migration tests using `SchemaVerifier` in
   `test/migrations_test.dart` to ensure schema integrity. Note that `AppDatabase` disables foreign
   keys before migrations and checks them afterward using `PRAGMA foreign_key_check`. Downgrades are
   handled by completely dropping and recreating tables.
