# Custom Login Flow

## Overview

This documentation describes how to use a custom sign-up flow for a custom login page, demonstrating an example with
OTP. The communication between the web page and the Flutter app is facilitated through the `WebtritLoginChannel`
JavaScript channel.

[Example HTML for Custom Signup](../assets/themes/custom_signup.html)

## Web Page & JavaScript Communication

The web page can have any UI and input fields for collecting data. At the end of the flow, for example, when the user
submits a form, all collected data should be sent to the Flutter app using the `WebtritLoginChannel` in a structured
JSON format. This ensures seamless communication between the web page and the Flutter app, allowing the app to process
and act upon the received data.

The Flutter app listens to the `WebtritLoginChannel` for messages sent from the web page. These messages contain a
structured JSON object with user-provided data. The app processes this information, extracts relevant values, and
initiates authentication using the provided credentials or other required data.

## HTML Structure

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
    const json = {
      event: "signup", // For now, this should always be 'signup'
      data: {
        email: email, // Here can be any key-value pairs
        key1: "value1",
        key2: "value2"
      }
    };
    WebtritLoginChannel.postMessage(JSON.stringify(json));
  }
</script>
</body>
</html>
```

## Functions to Implement in JavaScript

### `setLocale()`

- This function is called after the initial rendering to apply the correct localization settings from the mobile app.

```javascript
function setLocale(locale) {
  // add implementation
}
```

## JSON Structure

The JSON structure sent from the web page to the Flutter app follows a predefined format. This structure consists of two
main parts:

- **`event`**: A string that specifies the type of action being performed. For now, it should always be set to `signup`.
- **`data`**: An object containing key-value pairs representing user-submitted data. If the `tenant_id` key is included,
  it will be automatically used to modify the API request URL in the format `core-url/tenant/{tenant_id}/api/v1/user`.

### Example JSON Structure

```json
{
  "event": "signup",
  // This should always be 'signup'
  "data": {
    "email": "user@example.com",
    // Required: User email for authentication
    "key1": "value1",
    // Additional key-value pairs can be included
    "key2": "value2",
    // Optional: tenant_id key to modify API request URL
    "tenant_id": "d1bbfa00-0298-4667-ba81-9c432a416a10"
    // Optional: If present, modifies API request URL
  }
}
```

## Sending Data from Web Page to Flutter

To send data from the web page to the Flutter app, use the `WebtritLoginChannel`. This ensures seamless communication
between the WebView and the Flutter application. The data should be structured in JSON format and sent using the
`postMessage()` function.

```javascript
const json = {
  event: "signup", // For now, this should always be 'signup'
  data: {
    email: email, // Here can be any key-value pairs
    key1: "value1",
    key2: "value2"
  }
};
WebtritLoginChannel.postMessage(JSON.stringify(json));
```

## Handling Data in Flutter After Receiving `postMessage()`

1. **Receiving the Message:**

- The Flutter WebView registers a JavaScript channel named `WebtritLoginChannel`.
- When the web page calls `postMessage()`, the Flutter app captures the message in `_onJavaScriptMessageReceived`.

2. **Parsing the Data:**

- The message is parsed as a JSON object.
- The `event` field is checked to determine the type of request (currently, it should always be `signup`).
- The `data` field, which contains user-submitted information, is extracted.

3. **Handling the Request:**

- If the event is `signup`, all received key-value pairs are appended to a POST request to `POST api/v1/user`.
- If the `tenant_id` key is present in `data`, it modifies the API request endpoint to:
  ```plaintext
  core-url/tenant/{tenant_id}/api/v1/user
  ```
- `setLocale()` should also be implemented to ensure proper localization.

4. **Result Handling:**

- The response from the API is processed, and the user is navigated from the custom login page to the next native
  screen, such as the OTP verification screen or a success screen.

## Configuring WebView in the App

For detailed instructions on configuring WebView and integrating this HTML into your project, refer to *
*[Features](feature_configuration.md)**.

