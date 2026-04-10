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
- [Keypad Configuration](#keypad-configuration)
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
  "defaultPlaceholderImage": {},
  "appIcon": {},
  "leadingAvatarStyle": {}
}
```

---

#### Default Placeholder Image

Defines the **default image** used across the application when an asset fails to load or is
unavailable.  
This configuration ensures visual consistency for all placeholder, error, or empty image states.

**You can configure:**

- **uri** — path or URL of the image resource.  
  Supports formats like `asset://`, `network://`, or `remote://`.
- **render** — optional rendering settings:
    - **scale** — scaling factor to adjust image size.
    - **padding** — defines extra spacing around the image (top, left, right, bottom).

**Example:**

```json
{
  "defaultPlaceholderImage": {
    "uri": "asset://assets/secondary_onboardin_logo.svg",
    "render": {
      "scale": 0.25,
      "padding": {
        "left": 0.0,
        "top": 128.0,
        "right": 0.0,
        "bottom": 0.0
      }
    }
  }
}
```

- Automatically used for all placeholder or fallback visuals (e.g., missing avatars, thumbnails, or
  logos).
- Helps maintain a unified appearance across different screens and loading states.

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

Defines the styles for various action buttons, primarily used on the call screen and dial pad. Each
key in this object
corresponds to a specific button, and its value is a button style configuration (see [Button
Configuration](#button-configuration)).

This allows for customizing buttons like `callStart`, `hangup`, `camera`, `muted`, `digit` (for
keypad numbers), `backspace`, etc.
For toggleable buttons like `camera` or `muted`, you can define separate styles for their active
states (e.g., `cameraActive`).

**Example:**

```json
{
  "callStart": {
    "backgroundColor": "#75B943",
    "foregroundColor": "#ffffff",
    "iconColor": "#ffffff"
  },
  "hangup": {
    "backgroundColor": "#E74C3C",
    "foregroundColor": "#ffffff",
    "iconColor": "#ffffff"
  },
  "camera": {
    "backgroundColor": "#660371b3"
  },
  "cameraActive": {
    "backgroundColor": "#ff4baecc"
  },
  "muted": {
    "backgroundColor": "#6613a7fe"
  },
  "mutedActive": {
    "backgroundColor": "#ff14a3f8"
  },
  "digit": {
    "backgroundColor": "#EEF3F6",
    "foregroundColor": "#494949",
    "textColor": "#494949"
  },
  "backspace": {
    "backgroundColor": "transparent",
    "iconColor": "#494949"
  }
}
```

- `callStart`: Style for the call initiation button.
- `hangup`: Style for the call termination button.
- `camera`, `cameraActive`: Styles for the camera toggle button in its inactive and active states.
- `muted`, `mutedActive`: Styles for the mute toggle button.
- `digit`: Style for the numeric (0-9, *, #) buttons on the dial pad.
- `backspace`: Style for the backspace button on the dial pad.
  ... and other action buttons can be configured similarly.

### Keypad Configuration

Defines settings for the keypad (dial pad) view itself, distinct from the buttons on it.

**Example:**

```json
{
  "backgroundColor": "#ffffff",
  "digitsTextStyle": {
    "fontFamily": "Montserrat",
    "fontSize": 36.0,
    "fontWeight": {
      "weight": 400
    },
    "color": "#494949"
  },
  "lettersTextStyle": {
    "fontFamily": "Montserrat",
    "fontSize": 12.0,
    "fontWeight": {
      "weight": 500
    },
    "color": "#494949"
  }
}
```

- `backgroundColor`: Background color of the entire keypad view.
- `digitsTextStyle`: Text style for the main digits (e.g., "1", "2") on the keypad buttons.
- `lettersTextStyle`: Text style for the secondary letters (e.g., "ABC", "DEF") on the keypad
  buttons.

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
