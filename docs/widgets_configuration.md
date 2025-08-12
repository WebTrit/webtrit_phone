# Setup Widget Configuration

## Table of Contents

- [Fonts Configuration](#fonts-configuration)
- [Button Configuration](#button-configuration)
- [Group Configuration](#group-configuration)
- [Bar Configuration](#bar-configuration)
- [Picture Configuration](#picture-configuration)
    - [Leading Avatar Style Configuration](#leading-avatar-style-configuration)
- [Input Configuration](#input-configuration)
- [Text Configuration](#text-configuration)
- [Dialog Configuration](#dialog-configuration)
- [Action Pad Configuration](#action-pad-configuration)
- [Statuses Configuration](#statuses-configuration)
- [Decoration Configuration](#decoration-configuration)

---

## Setup Widget Configuration

The widget configuration defines various UI components used throughout the application. Below are
the different
configuration categories:

### Fonts Configuration

Defines the default font settings from [Google Fonts](https://fonts.google.com/), such as:

- `fontFamily`: Default font family (e.g., Montserrat)

### Button Configuration

Override the default button styles (primary, neutral, primaryOnDark, neutralOnDark) with custom
configurations. Defines
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

## Picture Configuration

#### **Main structure:**

```json
{
  "primaryOnboardingLogo": "asset://assets/primary_onboarding_logo.svg",
  "secondaryOnboardingLogo": "asset://assets/secondary_onboarding_logo.svg",
  "onboardingPictureLogo": {},
  "onboardingLogo": {},
  "appIcon": {},
  "leadingAvatarStyle": {}
}
```

---

#### Primary / Secondary Onboarding Logo

- **primaryOnboardingLogo** — Path to the primary onboarding logo.
- **secondaryOnboardingLogo** — Path to the secondary onboarding logo.  
  Supports local (`asset://`) or remote (`https://`) resources.

---

#### Onboarding Picture Logo

Configurable properties:

- **scale** — Scaling factor for the image.
- **labelColor** — Label color (hex format).

**Example:**

```json
{
  "onboardingPictureLogo": {
    "scale": "#ffffff",
    "labelColor": "#ffffff"
  }
}
```

---

#### Onboarding Logo

Configurable properties:

- **scale** — Scaling factor for the logo.
- **labelColor** — Label color (hex format).

**Example:**

```json
{
  "onboardingLogo": {
    "scale": "#ffffff",
    "labelColor": "#ffffff"
  }
}
```

---

#### App Icon

Configurable properties:

- **color** — Color overlay for the application icon (hex format).

**Example:**

```json
{
  "appIcon": {
    "color": "#ffffff"
  }
}
```

#### Leading Avatar Style Configuration

The **Leading Avatar** component is a circular profile/avatar element commonly used in lists, call
screens, and contact details.  
It can display a user’s photo, initials, or a placeholder icon, and supports additional visual
indicators like loading states,  
smart badges, and registration status markers.

**You can configure:**

- **Background color** — circle fill color (hex).
- **Size** — radius in logical pixels.
- **Initials text style** — font, size, weight, color, etc.
- **Placeholder icon** — icon to show when no photo is available (by `codePoint` or `name`).
- **Loading overlay** — loader visibility, padding, stroke width.
- **Smart indicator** — top-left badge with background color, icon, and size factor.
- **Registered badge** — bottom-right badge with colors for registered/unregistered and size factor.

**Example:**

```json
{
  "leadingAvatarStyle": {
    "backgroundColor": "#EEF3F6",
    "radius": 20.0,
    "initialsTextStyle": {
      "fontFamily": "Montserrat",
      "fontSize": null,
      "fontWeight": {
        "weight": 700
      },
      "color": "#1F618F"
    },
    "placeholderIcon": {
      "codePoint": "0xe497",
      "fontFamily": "MaterialIcons",
      "matchTextDirection": false
    },
    "loading": {
      "showByDefault": false,
      "padding": {
        "left": 2.0,
        "top": 2.0,
        "right": 2.0,
        "bottom": 2.0
      },
      "strokeWidth": 1.0
    },
    "smartIndicator": {
      "backgroundColor": "#F8FBFD",
      "icon": {
        "codePoint": "0xe491",
        "fontFamily": "MaterialIcons",
        "matchTextDirection": false
      },
      "sizeFactor": 0.4
    },
    "registeredBadge": {
      "registeredColor": null,
      "unregisteredColor": null,
      "sizeFactor": 0.2
    }
  }
}
```

### Input Configuration

Defines input fields, including:

**Example: **

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
