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

- [Payload Formats](#payload-formats)
- [URI Format](#uri-format)
- [JSON Format](#json-format)
- [Supported Schemes](#supported-schemes)
- [Configuration](#configuration)
- [When the Tab Appears](#when-the-tab-appears)
- [Screen States](#screen-states)
- [Security Notes](#security-notes)
- [Platform Notes](#platform-notes)

---

## Payload Formats

Payloads are interpreted by a chain of format decoders (adapters), probed in the
order of the `loginConfig.qr.formats` entries: the first decoder that RECOGNIZES the payload
fully decides the outcome (including failures such as a host mismatch); when none
does, the code is reported as "not a sign-in code". Supporting a new payload
structure is one new decoder class
(`lib/features/login/features/login_qr_signin/models/qr_signin_payload_decoder.dart`)
plus its name in the `formats` list - the scanner, cubit and login flow are
format-agnostic and stay untouched.

Built-in formats:

| Format | Shape                                          | Typical producer                          |
|--------|--------------------------------------------------|---------------------------------------------|
| `uri`  | `scheme:USER_REF:PASSWORD@HOST[?query]`          | Provisioning portals (Cloud Softphone QR generator) |
| `json` | Marker-discriminated JSON object (`"t"` field)   | Reserved for WebTrit-issued codes            |

## URI Format

```
scheme:USER_REF:PASSWORD@HOST[?query]
```

Example:

```
csc:user123:p%40ssword@EXAMPLE
```

| Part       | Description                                                                                                                              |
|------------|------------------------------------------------------------------------------------------------------------------------------------------|
| `scheme`   | URI scheme name, matched case-insensitively against the configured `schemes` list (default `csc`).                                        |
| `USER_REF` | Percent-encoded user reference (account id, phone number or email). Decoded as `user123`.                                              |
| `PASSWORD` | Percent-encoded password. `p%40ssword` decodes to `p@ssword`. May be empty or omitted - see below.                                        |
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

The decoder lives in
`lib/features/login/features/login_qr_signin/models/uri_qr_signin_payload_decoder.dart`
and is covered by a unit-test matrix in
`test/features/login/qr_signin_payload_parser_test.dart`.

## JSON Format

```json
{"t": "webtrit-signin", "v": 1, "user": "user123", "password": "p@ssword", "host": "EXAMPLE"}
```

| Field      | Required | Description                                                                                                   |
|------------|----------|-----------------------------------------------------------------------------------------------------------------|
| `t`        | yes      | Marker discriminator; must be `webtrit-signin`. Bare JSON has no scheme, so any other JSON falls through as unrecognized. |
| `v`        | no       | Payload version; absent means `1`. Other versions are rejected as unsupported.                                    |
| `user`     | yes      | Plain (not encoded) user reference.                                                                               |
| `password` | no       | Plain password; missing or empty prefills the password tab instead of signing in.                                 |
| `host`     | see note | Cloud/tenant identifier. When `expectedHost` is configured the field must be present and match; otherwise ignored. |

Rules shared with the URI format: fields that would redirect the sign-in to another
core (`core`, `tenant`, `core_url`, `tenant_id`) are rejected; unknown fields are
ignored so the format can grow without breaking older builds. The JSON form is
reserved for WebTrit-issued codes (nothing produces it yet); prefer the URI form for
plain user+password codes - it makes a sparser, easier-to-scan QR.

The field layout (marker, version and field names) is described by a
`JsonQrSigninStructure` value: a dialect that only renames fields or uses another
marker is a different structure passed to the same decoder, not a new decoder class.
Payloads whose shape differs beyond field names still get their own decoder.

The decoder lives in
`lib/features/login/features/login_qr_signin/models/json_qr_signin_payload_decoder.dart`.

## Supported Schemes

The scheme name identifies which provisioning system issued the code; all configured
schemes share the same grammar above. A code whose scheme is not in the configured
`schemes` list is rejected as "not a sign-in code" (the scanner shows the invalid-code
hint and keeps scanning).

| Scheme | Issued by                                                                 | Notes                                                                                                                             |
|--------|----------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------|
| `csc`  | Cloud Softphone provider portal (Tools -> QR code generator)                | The default and currently the only known producer. `HOST` is the portal's cloud id (an opaque identifier assigned by the portal); a trailing `*` marks a test (non-approved) app version and is tolerated. The portal URL-encodes the username/password segments. |

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
      "formats": [
        { "type": "uri", "schemes": ["csc"] },
        { "type": "json" }
      ],
      "expectedHost": "EXAMPLE"
    }
  }
}
```

| Field          | Type           | Default   | Description                                                                                   |
|----------------|----------------|-----------|-----------------------------------------------------------------------------------------------|
| `enabled`      | `bool`         | `false`   | Whether the QR sign-in tab is available at all.                                                |
| `formats`      | `List<Format>` | uri (csc) + json | Accepted payload formats with their per-format options, probed in this order.           |
| `expectedHost` | `string?`      | `null`    | Expected host (cloud id) of the code, shared by all formats. When set, codes issued for a different host are rejected; `null` accepts any host. |

Each `formats` entry:

| Field     | Type            | Applies to | Description                                                                 |
|-----------|-----------------|------------|-------------------------------------------------------------------------------|
| `type`    | `string`        | all        | Decoder name: `uri` or `json`. Unknown types are ignored.                       |
| `schemes` | `List<String>?` | `uri`      | Accepted scheme names, matched case-insensitively. Defaults to `["csc"]`.       |

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
