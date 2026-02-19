# Custom Login Flow

## Overview

This document describes how to implement a custom login/sign-up page using a `WebView`.
Communication between the custom
web page and the Flutter application is handled via the `WebtritLoginChannel` JavaScript channel,
allowing the web UI to
securely transmit user data to the app for authentication.

An example HTML file is available here: [custom_signup.html](../assets/themes/custom_signup.html)

## Table of Contents

- [Communication Protocol](#communication-protocol)
    - [JavaScript Channel](#javascript-channel)
    - [From Flutter to Web: Page Initialization](#from-flutter-to-web-page-initialization)
    - [From Web to Flutter: Sending User Data](#from-web-to-flutter-sending-user-data)
- [Example Implementation](#example-implementation)
- [Flutter-Side Handling](#flutter-side-handling)
- [Integration](#integration)

---

## Communication Protocol

The interaction between the web page and the Flutter app follows a clear protocol built around a
JavaScript channel.

### JavaScript Channel

All communication is facilitated through the `WebtritLoginChannel` object, which is injected into
the `WebView`'s
JavaScript context by the Flutter app. This channel exposes a `postMessage()` method for sending
data from the web page
to the app.

### From Flutter to Web: Page Initialization

After the web page is loaded, the Flutter app can call the global JavaScript function
`initializePage(initData)` to pass
initial data, such as localization settings or pre-filled form values.

**Function Signature:** `initializePage(initData)`

- **`initData`**: An object containing initialization data. Common keys include:
    - `locale`: The current language setting of the app (e.g., `"en"`).
    - `prefillEmail`: An email address to pre-populate in an input field.

It is the responsibility of the web page to implement this function to handle the incoming data.

**Example Implementation:**

```javascript
function initializePage(initData) {
  const { locale, prefillEmail } = initData || {};
  if (locale) {
    // Apply translations based on the locale
  }
  if (prefillEmail) {
    document.getElementById("email").value = prefillEmail;
  }
}
```

**Example Call from Flutter:**

```dart

final script = '''
  if (typeof window.initializePage === 'function') {
    window.initializePage({ "locale": "$locale" });
  }
''';
```

### From Web to Flutter: Sending User Data

When the user completes an action (e.g., submitting a form), the web page must gather the data and
send it to the
Flutter app by calling `WebtritLoginChannel.postMessage()`. The message must be a stringified JSON
object with a
specific structure.

**JSON Payload Structure:**

- **`event`**: A string identifying the action. Currently, this must always be `"signup"`.
- **`data`**: An object containing the key-value pairs of user-submitted data.

A special key, `tenant_id`, can be included in the `data` object. If present, the app will modify
the API request URL
to `core-url/tenant/{tenant_id}/api/v1/user`.

**Example JSON Payload:**

```json
{
  "event": "signup",
  "data": {
    "email": "user@example.com",
    "key1": "value1",
    "tenant_id": "d1bbfa00-0298-4667-ba81-9c432a416a10"
  }
}
```

---

## Example Implementation

Below is a minimal HTML structure demonstrating how to collect an email and send it to the Flutter
app. This example
also includes the `initializePage` function for handling data from Flutter.

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OTP Login</title>
</head>
<body>
<div class="form-container">
    <p class="description" id="descriptionText">
        Enter your email to receive a one-time password (OTP) for login.
    </p>
    <div class="form-group">
        <label for="email" id="emailLabel">Email</label>
        <input id="email" name="email" required>
    </div>
</div>
<button class="fixed-button" id="submitButton" onclick="handleLogin()">
    <span class="button-text" id="submitButtonText">Submit</span>
    <div class="spinner"></div>
</button>

<script>
    function handleLogin() {
      const email = document.getElementById("email").value;
      if (!email) {
        alert("Please enter your email.");
        return;
      }
      const payload = {
        event: "signup", // For now, this should always be 'signup'
        data: {
          email: email, // Here can be any key-value pairs
          key1: "value1",
          key2: "value2"
        }
      };
  
      if (window.WebtritLoginChannel) {
        WebtritLoginChannel.postMessage(JSON.stringify(payload));
      } else {
        console.error("WebtritLoginChannel not found.");
      }
    }
  
    function initializePage(initData) {
      const { locale, prefillEmail } = initData || {};
      if (locale) {
        // apply translations based on locale
      }
      if (prefillEmail) {
        document.getElementById("email").value = prefillEmail;
      }
    }
</script>
</body>
</html>
```

---

## Flutter-Side Handling

When the Flutter app receives a message from the web page via `postMessage()`, it performs the
following steps:

1. **Receiving the Message**
   The Flutter `WebView` has a registered JavaScript channel named `WebtritLoginChannel`. Its
   message handler is
   triggered when `postMessage()` is called from JavaScript.

2. **Parsing the Data**
   The incoming message (a JSON string) is parsed into a Dart `Map`. The app verifies the `event`
   key (expecting
   `signup`) and extracts the `data` object.

3. **Handling the API Request**
   The key-value pairs from the `data` object are sent as the body of a `POST` request to the
   `api/v1/user` endpoint.
   If a `tenant_id` key is present in the `data` object, the request URL is modified to:
   `core-url/tenant/{tenant_id}/api/v1/user`

4. **Result Handling & Navigation**
   After processing the API response, the app navigates the user from the custom login `WebView` to
   the appropriate
   native screen, such as an OTP verification page or a success screen.

---

## Integration

For detailed instructions on configuring the `WebView` component and integrating custom HTML files
into your project,
please refer to the **[Features](feature_configuration.md)** documentation.

