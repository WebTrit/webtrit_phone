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
- [Call and keypad buttons](#call-and-keypad-buttons)
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
configurations.

This is the one button style object used everywhere in the theme - here, on the call screen and
under the dial pad. Every field is optional; whatever you leave out keeps the app default.

```json
{
  "backgroundColor": "#ffff061e",
  "foregroundColor": "#ffffffff",
  "iconColor": "#ffe42626",
  "overlayColor": "#22ffffff",
  "disabledBackgroundColor": "#66dde0e3",
  "disabledForegroundColor": "#ff848581",
  "disabledIconColor": "#1fcd2f2f",
  "elevation": 0,
  "textStyle": {
    "fontSize": 16
  }
}
```

- `backgroundColor`, `foregroundColor`, `iconColor` - the resting look. `foregroundColor` is the
  text color, and the icon color too unless `iconColor` overrides it.
- `selectedBackgroundColor`, `selectedForegroundColor`, `selectedIconColor` - the same three while
  a button that can be on or off is switched on. Ignored by buttons that have no such state.
- `disabledBackgroundColor`, `disabledForegroundColor`, `disabledIconColor` - the same three while
  the button is unavailable.
- `overlayColor` - the ripple shown on press/hover/focus.
- `textStyle`, `elevation`, `padding`, `minimumSize`, `fixedSize`, `maximumSize`, `iconSize`,
  `side`, `shape`, `visualDensity`, `shadowColor`, `disabledShadowColor`, `surfaceTintColor`,
  `animationDuration` - shape, size and typography of the button.

### Group Configuration

Defines the structure of grouped widgets, including:

#### Group title list tile settings

**Example:**

```json
{
  "backgroundColor": "#ffdf2929",
  "textStyle": {
    "color": "#ff100000",
    "fontSize": 14
  }
}
```

- Background color (optional)
- Title text style (optional)

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

> **A theme lists only what it wants different.** Every value below has an app-side default
> (`LeadingAvatarStyle.defaults`); a key present in the theme is a deliberate override and pins that
> value for good, a key left out follows the app and changes with the next build. So do not restate
> a default here - that is exactly what stops an app-wide appearance change from reaching this
> deployment. The shipped `original.widget.*.config.json` files follow the same rule and therefore
> mention only the values that differ from the app.

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
- **Name colors** — pseudorandom, name-derived colors for avatars without a photo:
    - **enabled** — when `true` (default), the circle background and initials color are derived
      deterministically from the displayed name, so the same contact/chat/group always gets the
      same color; set to `false` to keep the static `backgroundColor` / `initialsTextStyle.color`.
    - **palette** — optional list of hex colors to pick from; when `null` or empty the color is
      generated from the name hash (unbounded number of hues, tuned per light/dark theme).

**Example** (only the values this brand wants different; badge sizes, name colors and the avatar
radius are left to the app):

```json
{
  "leadingAvatarStyle": {
    "backgroundColor": "#EEF3F6",
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
      "padding": {
        "left": 2.0,
        "top": 2.0,
        "right": 2.0,
        "bottom": 2.0
      }
    },
    "smartIndicator": {
      "backgroundColor": "#F8FBFD",
      "icon": {
        "codePoint": "0xe491",
        "fontFamily": "MaterialIcons",
        "matchTextDirection": false
      }
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

### Call and keypad buttons

These are not part of the widget configuration. They belong to the page that shows them:

- call screen buttons (call, hangup, mute, camera, speaker, hold, transfer, swap, keypad) -
  `dialing.actions`, see [Call actions](page_configuration.md#call-actions);
- buttons under the dial pad (call, transfer, backspace) - `keypad.actionpad`, see
  [Action pad](page_configuration.md#action-pad).

Both use the same button style object described in [Button Configuration](#button-configuration).

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
