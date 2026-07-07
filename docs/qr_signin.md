# QR Code Sign-In

## Overview

The login switch screen can offer a "QR code" tab next to the Password/OTP/Sign-up
tabs. Scanning a provisioning QR code signs the user in through the regular password
login: the code carries a plain user reference and password, the app parses them and
performs the same `POST /session` request as manual entry.

The primary use case is migrating users from provisioning portals that already issue
such codes (for example the Cloud Softphone portal QR generator), so a user's first
login is a single scan instead of typing credentials.

## Table of Contents

- [QR Payload Format](#qr-payload-format)
- [Supported Schemes](#supported-schemes)
- [Configuration](#configuration)
- [When the Tab Appears](#when-the-tab-appears)
- [Screen States](#screen-states)
- [Security Notes](#security-notes)
- [Platform Notes](#platform-notes)

---

## QR Payload Format

```
scheme:USER_REF:PASSWORD@HOST[?query]
```

Example:

```
csc:ph3142x777:Test%40777@DEE-CALL
```

| Part       | Description                                                                                                                              |
|------------|------------------------------------------------------------------------------------------------------------------------------------------|
| `scheme`   | URI scheme name, matched case-insensitively against the configured `schemes` list (default `csc`).                                        |
| `USER_REF` | Percent-encoded user reference (account id, phone number or email). Decoded as `ph3142x777`.                                              |
| `PASSWORD` | Percent-encoded password. `Test%40777` decodes to `Test@777`. May be empty or omitted - see below.                                        |
| `HOST`     | Cloud/tenant identifier of the issuing portal. Validated against `expectedHost` when configured, otherwise ignored. A trailing `*` (test-version marker) is stripped before comparison. |
| `?query`   | Optional. Unknown parameters are ignored so generator-side extras do not break scanning.                                                   |

Parsing rules:

- The `?query` tail is cut off first; the remainder is split at the LAST `@` (host)
  and the FIRST `:` (credentials). Since the credential segments are percent-encoded,
  a literal `:` or `@` can only appear between them, which makes the split unambiguous.
- The reserved query parameter `m` selects the sign-in method. Absent means
  `password`; any other value is rejected as unsupported (reserved for future methods
  such as token-based auto-provisioning).
- Query parameters that would redirect the sign-in to another core (`core`, `tenant`,
  `core_url`, `tenant_id`) are rejected: a scanned code must not choose where
  credentials are sent.
- A code with an empty or omitted password (`csc:user:@HOST`, `csc:user@HOST`) does
  not fail: the user reference is prefilled on the password tab and the user finishes
  signing in manually.

The parser lives in
`lib/features/login/features/login_qr_signin/models/qr_signin_uri_parser.dart` and is
covered by a unit-test matrix in `test/features/login/qr_signin_uri_parser_test.dart`.

## Supported Schemes

The scheme name identifies which provisioning system issued the code; all configured
schemes share the same grammar above. A code whose scheme is not in the configured
`schemes` list is rejected as "not a sign-in code" (the scanner shows the invalid-code
hint and keeps scanning).

| Scheme | Issued by                                                                 | Notes                                                                                                                             |
|--------|----------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------|
| `csc`  | Cloud Softphone provider portal (Tools -> QR code generator)                | The default and currently the only known producer. `HOST` is the portal's cloud id (e.g. `DEE-CALL`); a trailing `*` marks a test (non-approved) app version and is tolerated. The portal URL-encodes the username/password segments. |

Adding a scheme is a config-only change: list its name in `loginConfig.qr.schemes`.
Use this when a brand's provisioning system issues codes in the same
`scheme:user:password@host` shape under a different name. Codes with a different
STRUCTURE (not just a different scheme name) are not supported by configuration and
require a parser extension.

## Configuration

The feature is driven by the `qr` block of `loginConfig` in the application config
(see [application_config.md](application_config.md)):

```json
{
  "loginConfig": {
    "signinOrder": ["passwordSignin", "otpSignin", "signup", "qrSignin"],
    "qr": {
      "enabled": true,
      "schemes": ["csc"],
      "expectedHost": "DEE-CALL"
    }
  }
}
```

| Field          | Type           | Default   | Description                                                                                   |
|----------------|----------------|-----------|-----------------------------------------------------------------------------------------------|
| `enabled`      | `bool`         | `false`   | Whether the QR sign-in tab is available at all.                                                |
| `schemes`      | `List<String>` | `["csc"]` | Accepted URI scheme names, matched case-insensitively.                                         |
| `expectedHost` | `string?`      | `null`    | Expected host (cloud id) of the code. When set, codes issued for a different host are rejected; `null` accepts any host. |

The tab's position and default selection follow the regular `signinOrder` mechanism;
add `qrSignin` to the list to control its placement (unlisted types go last).

## When the Tab Appears

The QR tab is NOT a backend capability. It is offered when BOTH hold:

1. `loginConfig.qr.enabled` is `true` in the app config, and
2. the backend adapter advertises `passwordSignin` in `system-info`
   (`adapter.supported`) - the scanned code carries plain credentials, so QR sign-in
   is a client-side companion of password login.

## Screen States

| State                | Behavior                                                                                                             |
|----------------------|----------------------------------------------------------------------------------------------------------------------|
| Scanner              | Camera viewfinder (a neutral backdrop keeps the shape while the camera initializes). Detected codes are deduplicated. |
| Signing in           | Spinner + "Signing you in..." while the session is created (the shared login `processing` state).                     |
| Invalid code         | Inline error line under the viewfinder; scanning resumes automatically after a short cooldown.                        |
| No camera permission | Single action: "Allow camera access" triggers the system request; once the denial is permanent it is replaced by "Open settings". Re-checked when the app returns from the settings screen. |
| Failed sign-in       | Regular login error notification; the same code is retried only after a cooldown so a code left in the viewfinder does not loop attempts. |

## Security Notes

- The raw QR payload is never logged: it may carry plain credentials. Only the
  rejection reason (scheme/host/method/malformed) is logged.
- Codes that try to override the target core are rejected (see parsing rules).
- A password inside a QR image is plaintext at rest (paper, screenshots). The format
  exists for portal-driven migration; prefer token-based provisioning for new
  deployments.

## Platform Notes

- Scanning uses the `mobile_scanner` plugin: AVFoundation/Apple Vision on iOS/macOS,
  CameraX + the bundled ML Kit model on Android (works without Google Play Services),
  ZXing on web.
- iOS `NSCameraUsageDescription` mentions QR scanning; Android camera permission is
  merged from the plugin manifest.
