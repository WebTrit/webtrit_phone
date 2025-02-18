# Setup Widget Configuration

## Table of Contents

- [Fonts Configuration](#fonts-configuration)
- [Button Configuration](#button-configuration)
- [Group Configuration](#group-configuration)
- [Bar Configuration](#bar-configuration)
- [Picture Configuration](#picture-configuration)
- [Input Configuration](#input-configuration)
- [Text Configuration](#text-configuration)
- [Dialog Configuration](#dialog-configuration)
- [Action Pad Configuration](#action-pad-configuration)
- [Statuses Configuration](#statuses-configuration)
- [Decoration Configuration](#decoration-configuration)

---

## Setup Environment

Set up `dart_define.json` key-value structure to define the base configuration, including core settings and logging
credentials.

**Example:**

```json
{
  "WEBTRIT_APP_DEBUG_LEVEL": "ALL",
  "WEBTRIT_APP_DATABASE_LOG_STATEMENTS": false,
  "WEBTRIT_APP_PERIODIC_POLLING": true,
  "WEBTRIT_APP_ENABLE_ATTENDED_TRANSFER": true,
  "WEBTRIT_APP_DEMO_CORE_URL": "http://192.168.10.100:4000",
  "WEBTRIT_APP_LINK_DOMAIN": "app.webtrit.com",
  "WEBTRIT_APP_NAME": "WebTrit",
  "WEBTRIT_APP_DESCRIPTION": "WebTrit application",
  "WEBTRIT_APP_SALES_EMAIL": "sales@webtrit.com",
  "_WEBTRIT_APP_REMOTE_LOGZIO_LOGGING_URL": "",
  "_WEBTRIT_APP_REMOTE_LOGZIO_LOGGING_TOKEN": "",
  "_WEBTRIT_APP_REMOTE_LOGZIO_LOGGING_BUFFER_SIZE": ""
}
```

---

## Setup Widget Configuration

The widget configuration defines various UI components used throughout the application. Below are the different
configuration categories:

### Fonts Configuration

Defines the default font settings from [Google Fonts](https://fonts.google.com/), such as:

- `fontFamily`: Default font family (e.g., Montserrat)

### Button Configuration

Override the default button styles (primary, neutral, primaryOnDark, neutralOnDark) with custom configurations. Defines
button styles, including:

```json
{
  "backgroundColor": "#ffff061e",
  "foregroundColor": "#ffffffff",
  "textColor": "#ff000000",
  "iconColor": "#ffe42626",
  "disabledIconColor": "#1fcd2f2f"
}
```

- Background color (optional)
- Foreground color (optional)
- Icon colors (optional)
- Disabled states (optional)

### Group Configuration

Defines the structure of grouped widgets, including:

#### Group title list tile settings

**Example:**

```json
{
  "backgroundColor": "#ffdf2929",
  "textColor": "#ff100000"
}
```

- Background color (optional)
- Text color (optional)

#### Call action buttons and their colors

**Example:**

```json
{
  "callStartBackgroundColor": "#ff6bbc2b",
  "hangupBackgroundColor": "#ffffff",
  "transferBackgroundColor": "#66009cfa",
  "cameraBackgroundColor": "#660371b3",
  "cameraActiveBackgroundColor": "#ff4baecc",
  "mutedBackgroundColor": "#6613a7fe",
  "mutedActiveBackgroundColor": "#ff14a3f8",
  "speakerBackgroundColor": "#660a95e5",
  "speakerActiveBackgroundColor": "#ff009cff",
  "heldBackgroundColor": "#660195ed",
  "heldActiveBackgroundColor": "#ff018ada",
  "swapBackgroundColor": "#66009fff",
  "keyBackgroundColor": "#661d92dc",
  "keypadBackgroundColor": "#6603a5fc",
  "keypadActiveBackgroundColor": "#ff0d99ee"
}
```

- Background color call start
- Background color keypad
- Background color keypad active
- Background color camera
- Background color camera active
- Background color muted
- Background color muted active
- Background color speaker
- Background color speaker active
- Background color transfer
- Background color held
- Background color held active
- Background color swap
- Background color hangup
- Background color key

### Bar Configuration

Defines navigation bars:

#### Bottom navigation bar (background and item colors)

**Example:**

```json
{
  "backgroundColor": "#ffffff",
  "selectedItemColor": "#ffffff",
  "unSelectedItemColor": "#ffffff"
}
```

#### Extended tab bar (foreground and background colors)

**Example:**

```json
{
  "foregroundColor": "#ffffff",
  "backgroundColor": "#ffffff",
  "selectedItemColor": "#ffffff",
  "unSelectedItemColor": "#ffffff"
}
```

### Picture Configuration

Defines image assets used across the application, including onboarding logos and icons.

**Example:**

```json
{
  "primaryOnboardingLogo": "asset://assets/primary_onboardin_logo.svg",
  "secondaryOnboardingLogo": "asset://assets/secondary_onboardin_logo.svg",
  "onboardingPictureLogo": {
    "scale": "#ffffff",
    "labelColor": "#ffffff"
  },
  "onboardingLogo": {
    "scale": "#ffffff",
    "labelColor": "#ffffff"
  },
  "appIcon": {
    "color": "#ffffff"
  },
  "metadata": {
    "attributes": {}
  }
}
```

### Input Configuration

Defines input fields, including:

**Example:**

```json
{
  "primary": {
    "labelColor": "#ffffff",
    "border": {
      "disabled": {
        "typicalColor": "#ffffff",
        "errorColor": "#ffffff"
      },
      "focused": {
        "typicalColor": "#ffffff",
        "errorColor": "#ffffff"
      },
      "any": {
        "typicalColor": "#ffffff",
        "errorColor": "#ffffff"
      }
    }
  }
}
```

- Primary input style
- Border configurations
- Label color settings

### Text Configuration

Defines text display settings, including:

**Example:**

```json
{
  "selection": {
    "cursorColor": "#ffffff",
    "selectionColor": "#ffffff",
    "selectionHandleColor": "#ffffff"
  },
  "linkify": {
    "styleColor": "#ffffff",
    "linkifyStyleColor": "#ffffff"
  }
}
```

- Selection colors
- Link styles

### Dialog Configuration

Defines dialog settings, including:

**Example:**

```json
{
  "confirmDialog": {
    "activeButtonColor1": "#ffffff",
    "activeButtonColor2": "#ffffff",
    "defaultButtonColor": "#ffffff"
  },
  "snackBar": {
    "successBackgroundColor": "#75B943",
    "errorBackgroundColor": "#E74C3C",
    "infoBackgroundColor": "#494949",
    "warningBackgroundColor": "#F95A14"
  }
}
```

- Confirmation dialogs
- Snack bar messages (success, error, info, warning colors)

### Action Pad Configuration

Defines call action pad settings, including:

**Example:**

```json
{
  "callStart": {
    "backgroundColor": "#ffffff",
    "foregroundColor": "#ffffff",
    "textColor": "#ffffff",
    "iconColor": "#ffffff",
    "disabledIconColor": "#ffffff"
  },
  "callTransfer": {
    "backgroundColor": "#ffffff",
    "foregroundColor": "#ffffff",
    "textColor": "#ffffff",
    "iconColor": "#ffffff",
    "disabledIconColor": "#ffffff"
  },
  "backspacePressed": {
    "backgroundColor": "#ffffff",
    "foregroundColor": "#ffffff",
    "textColor": "#ffffff",
    "iconColor": "#ffffff",
    "disabledIconColor": "#ffffff"
  }
}
```

- Call start buttons
- Transfer buttons
- Keypad buttons

### Statuses Configuration

Defines status colors for:

**Example:**

```json
{
  "registrationStatuses": {
    "online": "#75B943",
    "offline": "#EEF3F6"
  },
  "callStatuses": {
    "connectivityNone": "#E74C3C",
    "connectError": "#E74C3C",
    "appUnregistered": "#494949",
    "connectIssue": "#E74C3C",
    "inProgress": "#123752",
    "ready": "#75B943"
  }
}
```

- Registration statuses (online, offline)
- Call statuses (ready, in progress, errors)

### Decoration Configuration

Defines UI decoration settings, such as gradient colors for various components.

**Example:**

```json
{
  "primaryGradientColorsConfig": {
    "colors": [
      {
        "color": "#5CACE3",
        "blend": true
      },
      {
        "color": "#123752",
        "blend": true
      }
    ]
  }
}
```
