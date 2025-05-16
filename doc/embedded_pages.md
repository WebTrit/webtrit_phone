# Embedded Pages Integration

## Overview

This documentation describes how to integrate embedded web pages into the WebTrit Call App using a WebView. These pages can extend the app with client-specific features. Embedded pages are configured via `app.config.json`, and can appear as a bottom menu tab or a settings item.

## App Configuration

Embedded pages are declared in the app configuration. A typical setup includes two parts:

1. **Reference in `mainConfig.bottomMenu.tabs` or settings section:**

```json
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
```

2. **Definition of the embedded page resource:**

```json
{
  "id": 2,
  "uri": "https://webtrit-app.web.app/example/example_embedded_payload_data.html",
  "payload": ["coreToken"],
  "toolbar": {
    "showToolbar": false
  }
}
```

## Payload Injection

The `payload` field defines which dynamic data will be injected into the embedded web page. Supported values:

* `userId`
* `coreToken`
* `externalPageToken`

If any of the requested payload values are unavailable (e.g., `externalPageToken`), they are fetched automatically from the server before the page is loaded.

### JavaScript Entry Point

Once the page is fully loaded and ready, the Flutter app executes JavaScript to deliver the payload. This is the single point of integration for web developers:

```javascript
if (typeof window.onPayloadDataReady === 'function') {
  window.onPayloadDataReady(payload);
}
```

The `payload` is a key-value map, passed as the first and only argument to `window.onPayloadDataReady`.

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

## Summary

By declaring embedded resources and referencing them in app config, clients can extend the WebTrit app with dynamic web content that securely receives contextual data like tokens or user IDs. The app ensures robust error handling, retry logic, and clear communication via the `onPayloadDataReady` JavaScript function.
