# README

## Overview

This documentation describes the structure and flow of data from a web page to a Flutter application to successfully log
in using a session token. The communication between the web page and the Flutter app is facilitated through
the `WebtritLoginChannel` JavaScript channel.

## Web Page Requirements

The web page should contain a login form that collects user credentials (email and password). Upon form submission, the
credentials should be concatenated to form a token, which is then wrapped in a JSON structure and sent to the Flutter
app using the `WebtritLoginChannel`.

### HTML Structure

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Form</title>
    <style>
        /* Add your CSS styles here */
    </style>
</head>
<body>
<div class="form-container">
    <p class="description">
        This is a sample embedded page to display a user login form.
    </p>
    <h1>Login</h1>
    <form onsubmit="return handleLogin()">
        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
            <button type="submit">Login</button>
        </div>
    </form>
</div>

<script>
    function handleLogin() {
        var email = document.getElementById('email').value;
        var password = document.getElementById('password').value;

        // Generate the token using concatenation
        var token = email + ':' + password;

        // Wrap the token in a JSON structure
        var tokenJson = JSON.stringify({ token: token });

        // Send the JSON string to Flutter using the JavaScript channel
        WebtritLoginChannel.postMessage(tokenJson);

        return false; // Prevent form submission
    }
</script>
</body>
</html>
```

## Flutter Integration

### JavaScript Channel

The Flutter app uses the `WebtritLoginChannel` to receive the session token from the web page. The channel is defined in
the `LoginCustomSigninScreen` widget.

### JSON Structure

The JSON structure for the session token can be represented as follows:

```json
{
  "token": "string",
  "tenantId": "string (optional)"
}
```

This JSON structure includes:

- `token`: A required string that represents the session token.
- `tenantId`: An optional string that represents the tenant ID.

## Configuring WebView in the App

To configure the WebView in your app, you need to specify the settings in a configuration file. Here's an example of how
to set up the WebView:

### Configuration Schema

```json
{
  "login": {
    "customSignIn": {
      "enabled": false,
      "titleL10n": "login_requestCredentials_title",
      "url": "https://webtrit-app.web.app/example/example_embedded_login.html"
    }
  }
}
```

This JSON scheme includes:

- `enable`: A boolean value that determines whether the custom sign-in feature is enabled.
- `titleL10n`: A string that represents the localization key for the toolbar title.
- `url`: A string that represents the URL of the embedded login page.

### File Path

The configuration should be placed in the following file:

```
webtrit_phone/assets/themes/original.ui.compose.config.json
```

## Summary

- The web page collects user credentials and sends a JSON-encoded session token to the Flutter app using
  the `WebtritLoginChannel`.
- The Flutter app listens for messages on the `WebtritLoginChannel` and processes the session token to log in the user.
- Configure the WebView by updating the configuration file with the appropriate schema and file path.

## Diagram

Below is the sequence diagram illustrating the flow from opening the WebView to receiving the session token and logging
in the user:

```sequence
App->>WebPage: Open WebView
WebPage->>WebPage: Perform tasks (e.g., API calls)
WebPage->>FlutterApp: Send JSON with token
FlutterApp->>FlutterApp: Process token and log in user
```