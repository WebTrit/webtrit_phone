# Configuring Custom Signup

This document provides guidelines for configuring custom signup functionality in your application by embedding custom HTML files or using the default login flow.

## Overview

The custom signup configuration allows developers to:
- Use a custom HTML file for the login flow.
- Continue using the default login flow if a custom configuration is not provided.

## Configuration Options

### Custom Signup Configuration

To enable custom signup, add a configuration entry to the `loginConfig` section of your app configuration file. Here is an example:

```json
"loginConfig": {
  "modeSelectActions": [
    {
      "enabled": true,
      "embeddedId": 1,
      "type": "embedded",
      "titleL10n": "login_Button_signIn"
    }
  ],
  "embedded": [
    {
      "id": 1,
      "launch": false,
      "showToolbar": true,
      "titleL10n": "login_requestCredentials_title",
      "resource": "assets/themes/custom_signup.html"
    }
  ]
}
```

### Default Login Flow

If no custom HTML is provided, the application will use the default login flow. Example configuration:

```json
"loginConfig": {
  "modeSelectActions": [
    {
      "enabled": true,
      "type": "login",
      "titleL10n": "login_Button_signUpToDemoInstance"
    }
  ]
}
```

## HTML Structure for Custom Signup

An example HTML template for custom signup:

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OTP Login</title>
    <style>
        /* Add CSS styling here */
    </style>
</head>

<body>
<div class="form-container">
    <p class="description" id="descriptionText">Enter your phone number to receive a one-time password (OTP) for login.</p>
    <div class="form-group">
        <label for="phone" id="phoneLabel">Phone Number</label>
        <input id="phone" name="phone" required>
    </div>
</div>

<button class="fixed-button" id="submitButton" onclick="handleLogin()">
    <span class="button-text" id="submitButtonText">Submit</span>
    <div class="spinner"></div>
</button>

<script>
    const translations = {
        en: {
            description: "Enter your phone number to receive a one-time password (OTP) for login.",
            phoneLabel: "Phone Number",
            submitButtonText: "Submit",
            alert: "Please enter your phone number."
        }
        // Add other locales as needed
    };

    function setLocale(locale) {
        const translation = translations[locale];
        document.getElementById("descriptionText").textContent = translation.description;
        document.getElementById("phoneLabel").textContent = translation.phoneLabel;
        document.getElementById("submitButtonText").textContent = translation.submitButtonText;
    }

    function handleLogin() {
        const phone = document.getElementById("phone").value;

        if (!phone) {
            alert(translations.en.alert);
            return;
        }

        const json = {
            event: "signup",
            data: {
                phone_number: phone
            }
        };

        WebtritLoginChannel.postMessage(JSON.stringify(json));
    }

    setLocale("en");
</script>
</body>

</html>
```

### Key Points
1. Data collected from the form is sent in JSON format to `WebtritLoginChannel.postMessage(JSON.stringify(json));`.
2. The `event` is always set to `signup`.
3. Data can include additional key-value pairs, such as `tenant_id`.
4. The `tenant_id` is used to construct the API path dynamically.

Example:

```dart
return baseUrl.replace(
  pathSegments: [
    ...baseUrlPathSegments,
    ...['tenant', tenantId],
  ],
);
```

## Flutter Integration

When `WebtritLoginChannel.postMessage` is called with the `signup` event, the Flutter application initiates the custom signup process using the provided data.

## Summary

By configuring the `loginConfig` section, you can seamlessly integrate a custom signup flow with your app, providing a tailored user experience while maintaining flexibility to fall back on the default login process.
