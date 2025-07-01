# Embedded Pages Integration

## Overview

This documentation describes how to integrate embedded web pages into the WebTrit Call App using a
WebView. These pages can extend the app with client-specific features. Embedded pages are configured
via `app.config.json`, and can appear as a bottom menu tab or a settings item.

## App Configuration

Embedded pages are declared in the app configuration. A typical setup includes two parts:

1. **Reference in `mainConfig.bottomMenu.tabs` or settings section:**

```json
    {
  "bottomMenu": {
    "cacheSelectedTab": true,
    "tabs": [
      {
        "enabled": true,
        "initial": false,
        "type": "favorites",
        "titleL10n": "main_BottomNavigationBarItemLabel_favorites",
        "icon": "0xe5fd"
      },
      {
        "enabled": true,
        "initial": false,
        "type": "embedded",
        "titleL10n": "embedded_TabTitle",
        "icon": "0xe2ce",
        "embeddedResourceId": 2
      }
    ]
  }
}
```

2. **Definition of the embedded page resource:**

```json
{
  "id": 2,
  "uri": "https://webtrit-app.web.app/example/example_embedded_payload_data.html",
  "payload": [
    "coreToken"
  ],
  "toolbar": {
    "showToolbar": false
  }
}
```

## Payload Injection

The `payload` field defines which dynamic data will be injected into the embedded web page.
Supported values:

* `userId`
* `coreToken`
* `externalPageToken`

If any of the requested payload values are unavailable (e.g., `externalPageToken`), they are fetched
automatically from the server before the page is loaded.

### JavaScript Entry Point

Once the page is fully loaded and ready, the Flutter app executes JavaScript to deliver the payload.
This is the single point of integration for web developers:

```javascript
if (typeof window.onPayloadDataReady === 'function') {
  window.onPayloadDataReady(payload);
}
```

The `payload` is a key-value map, passed as the first and only argument to
`window.onPayloadDataReady`.

### Example Payload

```json
{
  "userId": "123",
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

## Lifecycle Handling

The app manages network connectivity and retries for payload loading automatically:

* If `externalPageToken` is unavailable, it retries up to 3 times.
* On network reconnection, the page and payload are reloaded.
* If payload or page load fails, an error screen is shown with a retry option.

## WebView Behavior

* JavaScript is injected only after confirming that the WebView has successfully loaded.
* The WebView hides the native toolbar if configured via `toolbar.showToolbar: false`.
* Errors during load trigger the fallback UI with reload option.

## Use Cases

This integration is ideal for:

* Custom dashboards per client
* Authorization flows
* Embedded help pages or forms

## External Navigation Protocol

To open links **outside of the embedded WebView** (e.g., in the user's default browser), the WebTrit
app supports a custom URI scheme.

### Default Behavior

Links opened **inside the app WebView** can be written as usual:

```html

<li><a href="https://webtrit.com">Home</a></li>
```

This will load the page inside the WebView context.

### External Browser Navigation

To explicitly open a link **in the system browser**, use the following format:

```html

<li><a href="app://openInExternalBrowser?url=https://webtrit.com">Home</a></li>
```

- `app://` — indicates an internal instruction to the WebTrit app.
- `openInExternalBrowser` — command that triggers external navigation.
- `url` — target URL to be opened in the browser, provided as a query parameter.

### Use Case Example

```html
<a href="app://openInExternalBrowser?url=https://www.webtrit.com">Visit Webtrit Website</a>
```

This link will be intercepted by the app and launched in the system's default browser, not in the
embedded WebView.

## MediaQuery Injection

When an embedded page is fully loaded, the WebTrit app also injects **media query data** from the
native app context.  
This allows the web page to adjust its layout based on platform-specific UI insets and theming (
e.g., status bar height, navigation bar height, dark mode).

### JavaScript Entry Point

If defined, the following global JavaScript function will be executed:

```javascript
if (typeof window.onMediaQuaryReady === 'function') {
  window.onMediaQuaryReady(payload);
}
```

The `payload` is a JSON object containing device-related layout information.  
This enables your embedded page to apply dynamic layout adjustments without relying on hardcoded
values or CSS environment variables.

### Example Payload

```json
{
  "brightness": "dark",
  "devicePixelRatio": 2.75,
  "statusBarHeight": 44,
  "navigationBarHeight": 34
}
```

- `brightness`: `"light"` or `"dark"` depending on the system theme
- `devicePixelRatio`: the screen's pixel density
- `statusBarHeight`: top inset (useful for padding under status bar)
- `navigationBarHeight`: bottom inset (useful for avoiding native nav bar overlap)

### Required Integration by Web Developers

To handle these values in your page, implement the following hook:

```javascript
function onMediaQuaryReady(payload) {
  // Apply padding to avoid native UI overlap
  document.body.style.paddingTop = `${payload.statusBarHeight}px`;
  document.body.style.paddingBottom = `${payload.navigationBarHeight}px`;

  // Optional: adjust theme
  if (payload.brightness === 'dark') {
    document.body.style.backgroundColor = '#121212';
    document.body.style.color = '#ffffff';
  }

  console.log('MediaQuery info received:', payload);
}
```

This hook is especially useful for full-screen or minimal pages, where precise alignment with system
UI is important  
(e.g., avoiding overlap with gesture areas or notches).

## Summary

By declaring embedded resources and referencing them in app config, clients can extend the WebTrit
app with dynamic web content that securely receives contextual data like tokens or user IDs. The app
ensures robust error handling, retry logic, and clear communication via the `onPayloadDataReady`
JavaScript function.
