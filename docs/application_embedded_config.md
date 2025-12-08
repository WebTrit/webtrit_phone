# Embedded Resources

## Overview

This documentation describes how to integrate embedded web pages into the **WebTrit Call App** using
a WebView. These pages can extend the app with client-specific features. Embedded pages are
configured via `app.embedded.config.json`, and can appear as a bottom menu tab, settings item or a login flow.

---

## Example Embedded Resources Definition

```json
{
  "embeddedResources": [
    {
      "id": "example_embedded_login",
      "uri": "https://webtrit-app.web.app/example/example_embedded_login.html",
      "toolbar": {
        "titleL10n": "login_requestCredentials_title"
      }
    },
    {
      "id": "example_embedded_payload_data",
      "uri": "https://webtrit-app.web.app/example/example_embedded_payload_data.html",
      "payload": [
        "coreToken"
      ]
    },
    {
      "id": "example_embedded_call",
      "uri": "https://webtrit-app.web.app/example/example_embedded_call.html"
    },
    {
      "id": "privacy-policy-for-webtrit-app",
      "uri": "https://webtrit.com/legal/privacy-policy-for-webtrit-app/",
      "type": "terms",
      "toolbar": {
        "titleL10n": "settings_ListViewTileTitle_termsConditions"
      }
    },
    {
      "id": "example_embedded_registration",
      "uri": "https://webtrit-app.web.app/example/example_embedded_registration.html",
      "toolbar": {
        "titleL10n": "login_requestCredentials_title"
      }
    },
    {
      "id": "example_embedded_statistics",
      "uri": "https://webtrit-app.web.app/example/example_embedded_statistics.html",
      "toolbar": {
        "titleL10n": "login_requestCredentials_title"
      }
    },
    {
      "id": "example_embedded_rating",
      "uri": "https://webtrit-app.web.app/example/example_embedded_rating.html",
      "toolbar": {
        "titleL10n": "login_requestCredentials_title"
      }
    },
    {
      "id": "example_embedded_media_query",
      "uri": "https://webtrit-app.web.app/example/example_embedded_media_query.html"
    },
    {
      "id": "example_embedded_spa",
      "uri": "https://webtrit-app.web.app/example/example_embedded_spa.html",
      "enableConsoleLogCapture": true,
      "reconnectStrategy": "notifyOnly",
      "payload": [
        "coreToken"
      ]
    }
  ]
}
```

---

## Definition of the Embedded Page Resource

```json
{
  "id": "example_embedded_payload_data",
  "uri": "https://webtrit-app.web.app/example/example_embedded_payload_data.html",
  "payload": [
    "coreToken"
  ]
}
```

---

## Payload Injection

The `payload` field defines which dynamic data will be injected into the embedded web page.

**Supported values**:

- `userId`
- `coreToken`
- `externalPageToken`

If any of the requested payload values are unavailable (e.g., `externalPageToken`), they are fetched
automatically from the server before the page is loaded.

### JavaScript Entry Point

Once the page is fully loaded and ready, the app executes JavaScript to deliver the payload. This is
the single point of integration for web developers:

```javascript
if (typeof window.onPayloadDataReady === 'function') {
	window.onPayloadDataReady(payload);
}
```

The `payload` is a key-value object, passed as the first and only argument to
`window.onPayloadDataReady`.

### Example Payload

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

### Required Integration by Web Developers

Implement the following function in your embedded page:

```javascript
function onPayloadDataReady(payload) {
	// Handle injected data from the app
	console.log(payload);
}
```

---

## MediaQuery Injection

When an embedded page is fully loaded, the app also injects **media query data** from the native
context. This allows the web page to adjust its layout based on platform-specific UI insets and
theming (e.g., status bar height, gesture area, dark mode).

### JavaScript Entry Point

```javascript
if (typeof window.onMediaQueryReady === 'function') {
	window.onMediaQueryReady(payload);
}
```

> **Note:** Earlier docs sometimes referenced the misspelled hook `onMediaQuaryReady`. The correct
> name is **`onMediaQueryReady`**.

### Example Payload

```json
{
  "brightness": "dark",
  "devicePixelRatio": 2.75,
  "topSafeInset": 44,
  "bottomSafeInset": 34
}
```

- `brightness`: `"light"` or `"dark"` depending on the system theme
- `devicePixelRatio`: the screen's pixel density
- `topSafeInset`: top system inset (e.g., status bar or notch)
- `bottomSafeInset`: bottom system inset (e.g., system gesture area)

### Required Integration by Web Developers

```javascript
function onMediaQueryReady(payload) {
	// Apply padding to avoid native UI overlap
	document.body.style.paddingTop = `${payload.topSafeInset}px`;
	document.body.style.paddingBottom = `${payload.bottomSafeInset}px`;

	// Optional: adjust theme
	if (payload.brightness === 'dark') {
		document.body.style.backgroundColor = '#121212';
		document.body.style.color = '#ffffff';
	}

	console.log('MediaQuery info received:', payload);
}
```

---

## Device / App Info Injection (Optional)

If enabled, the app can inject high-level device/app labels (e.g., app name/version, OS, model,
store version, tenant/core URL).

### JavaScript Entry Point

```javascript
if (typeof window.onDeviceInfoReady === 'function') {
	window.onDeviceInfoReady(payload);
}
```

### Example (shape may vary per build)

```json
{
  "app": "WebTrit Phone",
  "appVersion": "1.8.0",
  "appSessionIdentifier": "a1b2c3...",
  "storeVersion": "1.8.0",
  "packageName": "com.example.webtrit",
  "buildNumber": "123",
  "manufacturer": "Google",
  "model": "Pixel 7",
  "os": "Android",
  "osVersion": "14",
  "authorization": "authorized",
  "embeddedUrls": "https://example.com, https://help.example.com",
  "coreUrl": "https://core.example.com",
  "tenantId": "tenant-42"
}
```

---

## Injection Order & Timing

- The app waits for **successful page load** and a short debounce (~**500 ms**) to avoid racing with
  late subresource loads.
- If load ends with error — **no injection** occurs.
- **Order of injections** (when enabled):
    1. Console log wrapper (to capture logs from subsequent injections)
    2. MediaQuery
    3. Device/App Info
    4. Business Payload(s) / Custom payloads

---

## JavaScript Channels

JS channels allow the page to **send events to the native app** via
`window.<ChannelName>.postMessage(...)`. Messages must be JSON strings with fields `event` and (
optional) `data`:

```json
{
  "event": "<EVENT_NAME>",
  "data": {
  }
}
```

### Console Log Capture Channel

- **Channel name:** `WebtritConsoleLogChannel`
- **What it does:** When enabled, the app injects a console wrapper that forwards
  `console.log/info/warn/error/debug` into the native logs, while preserving them in the browser
  console.
- **Event values:** `LOG`, `INFO`, `WARN`, `ERROR`, `DEBUG`
- **Message format:**
  ```json
  { "event": "INFO", "data": { "message": "...", "args": [ ] } }
  ```

> **How to enable:** per embedded resource set `"enableConsoleLogCapture": true` in the app config.

> **Web page changes required:** **none** — you just keep using `console.*`.

### Reload Channel

- **Channel name:** `WebtritPageReloadChannel`
- **Supported event:** `reload`
- **Behavior in the app:** incoming reload requests are debounced (default ~5 s) and rate-limited (
  default up to 10 reloads per minute).

**Web page example:**

```javascript
function requestNativeReload() {
	const ch = window.WebtritPageReloadChannel || globalThis.WebtritPageReloadChannel;
	if (ch && typeof ch.postMessage === 'function') {
		ch.postMessage(JSON.stringify({event: 'reload'}));
	}
}
```

---

## Connectivity Recovery Strategies

The embedded WebView integration supports configurable **Reconnect Strategies** via the
`ReconnectStrategy` enum:

- `none` – no reconnection logic, shows fallback error screen.
- `notifyOnly` – does not reload the page, but calls `window.onWebTritReconnect?.()` when internet
  is restored (if the page had loaded successfully at least once).
- `softReload` – retries `WebView.reload()` until success or max attempts.
- `hardReload` – reloads the original URI forcibly (`loadRequest(initialUri)`), useful for non-SPA
  pages.

### When is Error Screen Shown?

- The page has **never** loaded successfully (for any strategy).
- The strategy is **not** `notifyOnly` and a load fails.

### JavaScript Reconnect Hook (notifyOnly)

```javascript
if (typeof window.onWebTritReconnect === 'function') {
	window.onWebTritReconnect();
}
```

---

## External Navigation Protocol

To open links **outside of the embedded WebView** (e.g., in the system browser), use an internal
scheme handled by the app.

### Default Behavior (in-WebView)

```html

<li><a href="https://webtrit.com">Home</a></li>
```

### External Browser Navigation

```html

<li><a href="app://openInExternalBrowser?url=https://webtrit.com">Home</a></li>
```

- `app://` — internal instruction to the WebTrit app
- `openInExternalBrowser` — command that triggers external navigation
- `url` — target URL to be opened in the browser (must be a valid absolute URL)

**Use Case Example**

```html
<a href="app://openInExternalBrowser?url=https://www.webtrit.com">Visit Webtrit Website</a>
```

---

## WebView Behavior

- JavaScript is injected **only after** confirming that the WebView has successfully loaded (plus
  debounce).
- Errors during load trigger the fallback UI with a reload option.

---

## Use Cases

- Custom client dashboards
- Authorization flows
- Embedded help pages or forms

---

## Security & Robustness Recommendations

- Send only **JSON strings** via JS-channels: `{ "event": "...", "data": { ... } }`.
- Avoid spamming the `WebtritPageReloadChannel` — excessive requests will be **rate-limited**.
- Prefer `notifyOnly` for SPA pages to manage your own reconnection logic.
- Keep to the **correct hook names** (`onMediaQueryReady`, not `onMediaQuaryReady`).

---

## Configuration of Reconnect Strategy

To configure which strategy the app should use for your embedded page, add the `reconnectStrategy`
key to the embedded resource definition:

```json
{
  "id": 2,
  "uri": "https://example.com",
  "payload": [
    "coreToken"
  ],
  "reconnectStrategy": "notifyOnly",
  "enableConsoleLogCapture": true
}
```

**Possible values:** `"none" | "notifyOnly" | "softReload" | "hardReload"`  
**Default:** `"notifyOnly"`

---

## Summary

By declaring embedded resources and referencing them in app config, clients can extend the WebTrit
app with dynamic web content that securely receives contextual data like tokens or user IDs. The app
ensures robust error handling, retry logic, structured two-way communication via JavaScript hooks
and channels, and optional console log capture for diagnostics.
