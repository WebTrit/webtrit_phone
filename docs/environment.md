## Variables

This file describes environment variables and Dart define variables used in the WebTrit application
configuration.

### Naming Convention

To ensure clarity and consistency across configuration parameters, the following naming conventions
are used:

| Prefix       | Purpose                                                                  |
|--------------|--------------------------------------------------------------------------|
| `WEBTRIT_`   | Public and required or commonly configurable variables.                  |
| `_WEBTRIT_`  | Optional or platform-specific variables. Inactive unless explicitly set. |
| `__WEBTRIT_` | Internal meta fields used only for documentation (e.g., descriptions).   |

#### Example:

```json
{
  "WEBTRIT_APP_NAME": "WebTrit",
  "_WEBTRIT_APP_FCM_VAPID_KEY": "",
  "__WEBTRIT_APP_FCM_VAPID_KEY_DESCRIPTION": "Used only for Web Push via FCM. Optional."
}
```

This convention ensures clear separation between active, optional, and descriptive keys, improving
maintainability and enabling tools to parse configuration reliably.

---

### Dart define

- `WEBTRIT_APP_NAME` – The application name (_default: **WebTrit**_).
- `WEBTRIT_APP_LINK_DOMAIN` – Used to configure Android App Links and iOS Universal Links.
- `WEBTRIT_APP_DEMO_CORE_URL` – Demo core URL (_default: **http://localhost:4000**_).
- `WEBTRIT_APP_DEBUG_LEVEL` – Logging verbosity level (_default: **ALL**_).
- `WEBTRIT_APP_DATABASE_LOG_STATEMENTS` – Enables logging of database queries (
  _default: **false**_).
- `WEBTRIT_APP_PERIODIC_POLLING` – Enables background polling (_default: **true**_).
- `_WEBTRIT_APP_CORE_URL` – Custom core URL (optional override).
- `_WEBTRIT_APP_CORE_VERSION_CONSTRAINT` – Core compatibility range.
- `_WEBTRIT_APP_ABOUT_URL` – URL for "About" screen content.
- `WEBTRIT_APP_SALES_EMAIL` – Email address shown for sales inquiries.
- `_WEBTRIT_APP_FCM_VAPID_KEY` – VAPID key for Web Push notifications (used on web only).
- `_WEBTRIT_APP_REMOTE_LOGZIO_LOGGING_URL` – Logz.io remote logging endpoint (optional).
- `_WEBTRIT_APP_REMOTE_LOGZIO_LOGGING_TOKEN` – Logz.io auth token.
- `_WEBTRIT_APP_REMOTE_LOGZIO_LOGGING_BUFFER_SIZE` – Logz.io log buffer size.

### Environment

- `_WEBTRIT_ANDROID_RELEASE_UPLOAD_KEYSTORE_PATH` – Path for keystore directory used in Android
  release signing.
- `WEBTRIT_HTTP_ALLOWED_DOMAINS` – List of HTTP domains allowed for cleartext traffic.
- `WEBTRIT_CALL_TRIGGER_MECHANISM_SMS` – Enables fallback call triggering via SMS (
  _default: **false**_).
- `WEBTRIT_CALL_TRIGGER_MECHANISM_SMS_PREFIX` – Prefix for SMS-based call triggers.
- `WEBTRIT_CALL_TRIGGER_MECHANISM_SMS_REGEX_PATTERN` – Regex pattern to extract call data from SMS
  content.

> Default build variables are located in [`dart_define.json`](../dart_define.json) and can be
> applied
> via:
> ```bash
> flutter run --dart-define-from-file=dart_define.json
> flutter build apk --dart-define-from-file=dart_define.json
> ```
