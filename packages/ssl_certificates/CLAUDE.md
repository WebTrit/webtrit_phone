@AGENTS.md

## Gotcha

`securety_context.dart` — intentional misspelling ("securety" not "security"). Do not rename it.
Renaming breaks the barrel export `lib/ssl_certificates.dart` and all dependents (`_http_client`, `_web_socket_channel`).
