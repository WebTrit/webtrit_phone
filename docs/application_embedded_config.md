# Embedded Resources Configuration

## Overview

This document describes how to integrate embedded web pages into the **WebTrit Call App**. These
pages, rendered in a
`WebView`, can extend the application with client-specific features and are configured in
`app.embedded.config.json`.
They can be launched as a bottom menu tab, a settings item, or as part of a custom login flow.

## Table of Contents

- [Resource Definition](#resource-definition)
    - [Structure](#structure)
    - [Example](#example)
- [Data Injection (from App to Web)](#data-injection-from-app-to-web)
    - [JavaScript Hooks](#javascript-hooks)
    - [Injection Order & Timing](#injection-order--timing)
    - [Payload Injection](#payload-injection)
    - [MediaQuery Injection](#mediaquery-injection)
    - [Device & App Info Injection](#device--app-info-injection)
- [JavaScript Channels (from Web to App)](#javascript-channels-from-web-to-app)
    - [Console Log Capture Channel](#console-log-capture-channel)
    - [Reload Channel](#reload-channel)
- [Advanced Features](#advanced-features)
    - [Connectivity Recovery](#connectivity-recovery)
    - [External Navigation Protocol](#external-navigation-protocol)
- [Best Practices](#best-practices)

---

## Resource Definition

An embedded resource is defined by an object with a unique `id` and a `uri`. It can also include
configurations for data
payloads, connectivity, and native UI elements like the toolbar.

### Structure

| Key                       | Type            | Description                                                                                            |
|---------------------------|-----------------|--------------------------------------------------------------------------------------------------------|
| `id`                      | `string`        | A unique identifier for the resource.                                                                  |
| `uri`                     | `string`        | The URL of the web page to load.                                                                       |
| `type`                    | `string?`       | Optional type specifier (e.g., `terms`).                                                               |
| `payload`                 | `List<string>?` | A list of data keys to be injected into the page (see [Payload Injection](#payload-injection)).        |
| `toolbar`                 | `object?`       | Configuration for the native toolbar displayed above the `WebView`.                                    |
| `reconnectStrategy`       | `string?`       | The strategy for handling network interruptions (see [Connectivity Recovery](#connectivity-recovery)). |
| `enableConsoleLogCapture` | `bool?`         | If `true`, captures `console.*` messages from the web page.                                            |

### Example

The following demonstrates a list of `embeddedResources`, as it would appear in
`app.embedded.config.json`.

```json
{
  "embeddedResources": [
    {
      "id": "example_spa",
      "uri": "https://webtrit-app.web.app/example/example_embedded_spa.html",
      "enableConsoleLogCapture": true,
      "reconnectStrategy": "notifyOnly",
      "payload": [
        "coreToken",
        "userId"
      ]
    },
    {
      "id": "privacy-policy",
      "uri": "https://webtrit.com/legal/privacy-policy-for-webtrit-app/",
      "type": "terms",
      "toolbar": {
        "titleL10n": "settings_ListViewTileTitle_termsConditions"
      }
    }
  ]
}
```

---

## Data Injection (from App to Web)

The application can inject various types of data into a loaded web page, enabling the page to become
context-aware. This
is achieved by calling global JavaScript functions (hooks) on the `window` object.

### JavaScript Hooks

The web page must implement these global functions to receive data from the app.

| Function             | Payload Description                          |
|----------------------|----------------------------------------------|
| `onPayloadDataReady` | Business-level data like tokens and user ID. |
| `onMediaQueryReady`  | Device screen metrics and theme info.        |
| `onDeviceInfoReady`  | Application and device identification data.  |

### Injection Order & Timing

- The app injects data only after the page has loaded successfully, plus a short debounce (~500 ms).
  No data is injected if the page fails to load.
- Injections occur in a specific order:
    1. Console log wrapper (if enabled)
    2. MediaQuery data
    3. Device/App info
    4. Business payload

### Payload Injection

The `payload` field in the resource definition specifies which dynamic business data to inject.

**Supported values**:

- `userId`
- `coreToken`
- `externalPageToken`

If a requested value is unavailable (e.g., `externalPageToken`), the app will fetch it from the
server before loading the page.

**Hook & Example Payload:**

```javascript
function onPayloadDataReady(payload) {
  console.log('Business payload received:', payload);
}
```

```json
{
  "userId": "123",
  "coreToken": "xxxxx",
  "externalPageToken": {
    "accessToken": "xxxxx",
    "refreshToken": "xxxxx",
    "expiresAt": "2025-04-30T10:21:13.274710Z"
  }
}
```

### MediaQuery Injection

The app injects native context details, allowing the web page to adapt to the device's UI, such as
safe areas and the
system theme.

**Hook & Example Payload:**

```javascript
function onMediaQueryReady(payload) {
  document.body.style.paddingTop = `${payload.topSafeInset}px`;
  document.body.style.paddingBottom = `${payload.bottomSafeInset}px`;
}
```

```json
{
  "brightness": "dark",
  "devicePixelRatio": 2.75,
  "topSafeInset": 44,
  "bottomSafeInset": 34
}
```

### Device & App Info Injection

Injects high-level identifiers for the app and device.

**Hook & Example Payload:**

```javascript
function onDeviceInfoReady(payload) {
  console.log('Device info received:', payload);
}
```

```json
{
  "app": "WebTrit Phone",
  "appVersion": "1.8.0",
  "manufacturer": "Google",
  "model": "Pixel 7",
  "os": "Android",
  "osVersion": "14",
  "coreUrl": "https://core.example.com"
}
```

---

## JavaScript Channels (from Web to App)

JS channels allow the web page to send events to the native app via
`window.<ChannelName>.postMessage()`. The message
must be a JSON string with an `event` and an optional `data` field.

```json
{
  "event": "EVENT_NAME",
  "data": {}
}
```

### Console Log Capture Channel

- **Channel:** `WebtritConsoleLogChannel`
- **Enablement:** Set `enableConsoleLogCapture: true` in the resource definition.
- **Description:** Forwards `console.log/info/warn/error/debug` messages to the native logs. No
  changes are required on the web page; continue using `console` as usual.

### Reload Channel

- **Channel:** `WebtritPageReloadChannel`
- **Event:** `reload`
- **Description:** Allows the web page to request a native reload. The app debounces and rate-limits
  these requests.

**Example:**

```javascript
function requestNativeReload() {
  if (window.WebtritPageReloadChannel) {
    window.WebtritPageReloadChannel.postMessage(JSON.stringify({ event: 'reload' }));
  }
}
```

---

## Advanced Features

### Connectivity Recovery

The `reconnectStrategy` field in the resource definition controls how the `WebView` handles network
interruptions.

**Strategies:**

- `none`: Shows a fallback error screen.
- `notifyOnly`: (Default) Does not reload. Calls the `window.onWebTritReconnect()` JavaScript hook
  when connectivity is restored, allowing SPAs to handle reconnection internally.
- `softReload`: Retries `WebView.reload()`.
- `hardReload`: Reloads the original URI forcibly.

To set a strategy, add it to the resource definition:

```json
{
  "id": "example_spa",
  "uri": "...",
  "reconnectStrategy": "notifyOnly"
}
```

### External Navigation Protocol

To open a link in the system's external browser instead of within the `WebView`, use the `app://`
custom URL scheme.

- **In-WebView (Standard):** `<a href="https://webtrit.com">Home</a>`
- **External Browser:** `<a href="app://openInExternalBrowser?url=https://webtrit.com">Home</a>`

---

## Best Practices

- Always check that JS hooks and channels (`window.on...`, `window.Webtrit...Channel`) exist before
  using them.
- Send only valid JSON strings via channels.
- Use the `notifyOnly` reconnect strategy for Single-Page Applications (SPAs) to manage reconnection
  state internally.
- Avoid spamming the `WebtritPageReloadChannel`, as requests are rate-limited.
