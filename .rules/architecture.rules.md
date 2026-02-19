# Monorepo Structure & Architecture

## Local Packages

* **Strict Boundaries:** The project utilizes local packages within the `packages/` directory to
  enforce strict domain boundaries (e.g., `webtrit_api`, `webtrit_signaling`).
* **No Circular Dependencies:** Code inside `packages/` must not import anything from the main
  `lib/` folder.

## Features Folder

* **Location:** App-specific business logic, UI screens, and feature-specific BLoCs should reside in
  `lib/features/`.
* **Stateless Widgets:** Never use a method to return a Widget (except for lists). Always use a
  `StatelessWidget` class instead.

## Callback Rules

* **Single Expression:** If a callback contains more than one statement, extract its logic into a
  private method. Callbacks should be concise and single-expression only. Multi-line callback bodies
  are not allowed.
