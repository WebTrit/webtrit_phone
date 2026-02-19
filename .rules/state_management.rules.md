# State Management & Dependency Injection

## Dependency Injection (Inversion of Control)

* **No DI Frameworks:** Strictly DO NOT use Service Locators or DI packages like `get_it` or
  `injectable`.
* **Inherited Providers:** Provide dependencies down the widget tree using `Provider`,
  `RepositoryProvider`, `MultiProvider`, and `MultiRepositoryProvider` from the `provider` and
  `flutter_bloc` packages.
* **Constructor Injection:** Pass all dependencies explicitly through class constructors.
* **Access:** Read dependencies exclusively via `context.read<T>()` for callbacks/event additions
  and `context.watch<T>()` for UI rebuilds. Do not pass `BuildContext` into BLoCs or Services.

## BLoC / Cubit Conventions

* **Events (Pure Dart):** DO NOT use `freezed` for BLoC events. Always use native Dart
  `sealed class` combined with `Equatable` for exhaustiveness checking and value equality.
    * Example: `sealed class CallEvent extends Equatable`
* **Sub-events Structuring:** For complex event groups, use nested `sealed classes` with factory
  constructors returning concrete subclasses.
* **State (Freezed):** Use `@freezed` exclusively for State classes and complex data models where
  `copyWith` and immutability boilerplate generation is beneficial.
* **Transformers:** Use `bloc_concurrency` transformers (like `sequential()`, `droppable()`,
  `restartable()`, `debounce()`) explicitly when registering event handlers to control execution
  flow.
