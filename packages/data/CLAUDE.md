@AGENTS.md

## Gotcha

Schema migration requires **all 5 steps** in order — don't generate the file and stop there:

1. Edit table · 2. Create `migration_vN.dart` · 3. Register in `migrations.dart`
2. Run `dart run bin/create_new_schema_dump_and_test_migration.dart` · 5. Write tests in `migrations_test.dart`
