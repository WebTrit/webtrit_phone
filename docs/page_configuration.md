# Page Configuration

This document defines the **page-level appearance configuration** app reads from JSON: **Login
**, **About**, **Call (Dialing)**, and **Keypad**. Every section is optional—missing fields fall
back to sensible in-app defaults.

---

## Table of Contents

- [Color format](#color-format)
- [Global structure](#global-structure)
- [Login page](#login-page)
- [About page](#about-page)
- [Call page (Dialing)](#call-page-dialing)
    - [App bar](#app-bar)
    - [Call info](#call-info)
    - [Call actions](#call-actions)
    - [Light & dark action presets](#light--dark-action-presets)
- [Keypad page](#keypad-page)
- [Common object formats](#common-object-formats)

---

## Color format

Use HEX strings:

- `#RRGGBB` — opaque
- `#AARRGGBB` — with alpha (recommended for “glassy”/translucent looks, e.g. `#66FFFFFF` ≈ 40%
  opacity)

---

## Global structure

```json
{
  "login": {
    /* Login page config */
  },
  "about": {
    /* About page config */
  },
  "dialing": {
    /* Call page config */
  },
  "keypad": {
    /* Keypad page config */
  }
}
```

All sections can be provided independently.

---

## Login page

Top-level keys inside `"login"`:

| Key               | Type   | Description                                              |
|-------------------|--------|----------------------------------------------------------|
| `modeSelect`      | object | Mode selection screen (buttons, system bars, main logo). |
| `switchPage`      | object | “Switch mode” screen (main logo only).                   |
| `otpSigninVerify` | object | OTP sign-in verification screen (repeat countdown).      |
| `signupVerify`    | object | Sign-up verification screen (repeat countdown).          |

### `login.modeSelect`

```json
{
  "login": {
    "modeSelect": {
      "systemUiOverlayStyle": {
        "statusBarIconBrightness": "dark",
        "systemNavigationBarIconBrightness": "dark"
      },
      "mainLogo": {
        "asset": "assets/branding/logo.png"
      },
      "buttonLoginStyleType": "primary",
      "buttonSignupStyleType": "primary"
    }
  }
}
```

- `systemUiOverlayStyle` — status/navigation bar colors & icon brightness (see **Common object
  formats**).
- `mainLogo` — image descriptor for the primary logo (see **ImageSource**).
- `buttonLoginStyleType`, `buttonSignupStyleType` — string enum style presets (e.g. `"primary"`).

### `login.switchPage`

```json
{
  "login": {
    "switchPage": {
      "mainLogo": {
        "asset": "assets/branding/logo_switch.png"
      }
    }
  }
}
```

### `login.otpSigninVerify` / `login.signupVerify`

```json
{
  "login": {
    "otpSigninVerify": {
      "countdownRepeatIntervalSeconds": 45
    },
    "signupVerify": {
      "countdownRepeatIntervalSeconds": 30
    }
  }
}
```

- `countdownRepeatIntervalSeconds`:  
  `0` → “Repeat” always enabled; `>0` → enabled after that many seconds.

**Minimal login example:**

```json
{
  "login": {
    "modeSelect": {
      "mainLogo": {
        "asset": "assets/branding/logo.png"
      }
    },
    "otpSigninVerify": {
      "countdownRepeatIntervalSeconds": 0
    },
    "signupVerify": {
      "countdownRepeatIntervalSeconds": 0
    }
  }
}
```

---

## About page

Top-level keys inside `"about"`:

| Key        | Type   | Description                                            |
|------------|--------|--------------------------------------------------------|
| `mainLogo` | object | Image descriptor for a picture/logo.                   |
| `metadata` | object | Arbitrary key–value store (e.g., version/build/links). |

**Example:**

```json
{
  "about": {
    "mainLogo": {
      "asset": "assets/branding/about.png"
    },
    "metadata": {
      "version": "1.8.2",
      "build": 245,
      "website": "https://example.com"
    }
  }
}
```

---

## Call page (Dialing)

Top-level keys inside `"dialing"`:

| Key                    | Type   | Description                                                  |
|------------------------|--------|--------------------------------------------------------------|
| `systemUiOverlayStyle` | object | Status/navigation bars styling.                              |
| `appBarStyle`          | object | App bar styling (background/foreground/primary/back button). |
| `callInfo`             | object | Text styles for username/number/status.                      |
| `actions`              | object | Button styles for call controls.                             |

**Compact example:**

```json
{
  "dialing": {
    "systemUiOverlayStyle": {
      "statusBarIconBrightness": "dark",
      "statusBarBrightness": "light",
      "systemNavigationBarColor": "#000000",
      "systemNavigationBarIconBrightness": "light"
    },
    "appBarStyle": {
      "backgroundColor": null,
      "foregroundColor": null,
      "primary": false
    },
    "callInfo": {
      "usernameTextStyle": {
        "fontSize": 36,
        "fontWeight": {
          "weight": 400
        },
        "color": "#FFFFFF"
      },
      "numberTextStyle": {
        "fontSize": 16,
        "fontWeight": {
          "weight": 400
        },
        "color": "#EEF3F6"
      },
      "callStatusTextStyle": {
        "fontSize": 14,
        "fontWeight": {
          "weight": 400
        },
        "color": "#EEF3F6",
        "fontFeatures": [
          "tabularFigures"
        ]
      },
      "processingStatusTextStyle": {
        "fontSize": 14,
        "fontWeight": {
          "weight": 500
        },
        "color": "#EEF3F6"
      }
    },
    "actions": {}
  }
}
```

### App bar

`dialing.appBarStyle`:

```json
{
  "dialing": {
    "appBarStyle": {
      "backgroundColor": "#123752",
      "foregroundColor": "#FFFFFF",
      "primary": true,
      "showBackButton": true
    }
  }
}
```

### Call info

`dialing.callInfo`:

```json
{
  "dialing": {
    "callInfo": {
      "usernameTextStyle": {
        "fontSize": 34,
        "color": "#FFFFFF"
      },
      "numberTextStyle": {
        "fontSize": 16,
        "color": "#EEF3F6"
      },
      "callStatusTextStyle": {
        "fontSize": 14,
        "color": "#EEF3F6"
      },
      "processingStatusTextStyle": {
        "fontSize": 14,
        "color": "#EEF3F6"
      }
    }
  }
}
```

### Call actions

`dialing.actions` groups all action button styles. Each field accepts an **ElevatedButton** style
config (see **ElevatedButtonWidgetConfig**).

Available action keys:

- `callStart`, `hangup`, `transfer`, `camera`, `muted`, `speaker`, `held`, `swap`, `key`

**Correct nesting:**

```json
{
  "dialing": {
    "actions": {
      "callStart": {},
      "hangup": {},
      "transfer": {},
      "camera": {},
      "muted": {},
      "speaker": {},
      "held": {},
      "swap": {},
      "key": {}
    }
  }
}
```

**Alpha (“glassy”) recommendation:**  
Use semi-transparent backgrounds like `"#66FFFFFF"` for normal and `"#26FFFFFF"` for disabled to
blend over gradients.

#### Light & dark action presets

**Light:**

```json
{
  "dialing": {
    "actions": {
      "callStart": {
        "backgroundColor": "#75B943",
        "foregroundColor": "#FFFFFF",
        "iconColor": "#FFFFFF",
        "disabledBackgroundColor": "#DDE0E3",
        "disabledForegroundColor": "#848581",
        "disabledIconColor": "#848581"
      },
      "hangup": {
        "backgroundColor": "#E74C3C",
        "foregroundColor": "#FFFFFF",
        "iconColor": "#FFFFFF",
        "disabledBackgroundColor": "#DDE0E3",
        "disabledForegroundColor": "#848581",
        "disabledIconColor": "#848581"
      },
      "transfer": {
        "backgroundColor": "#123752",
        "foregroundColor": "#FFFFFF",
        "iconColor": "#FFFFFF",
        "disabledBackgroundColor": "#DDE0E3",
        "disabledForegroundColor": "#848581",
        "disabledIconColor": "#848581"
      },
      "camera": {
        "backgroundColor": "#66FFFFFF",
        "foregroundColor": "#FFFFFFFF",
        "iconColor": "#FFFFFFFF",
        "disabledBackgroundColor": "#26FFFFFF",
        "disabledForegroundColor": "#FF848581",
        "disabledIconColor": "#FF848581"
      },
      "muted": {
        "backgroundColor": "#66FFFFFF",
        "foregroundColor": "#FFFFFFFF",
        "iconColor": "#FFFFFFFF",
        "disabledBackgroundColor": "#26FFFFFF",
        "disabledForegroundColor": "#FF848581",
        "disabledIconColor": "#FF848581"
      },
      "speaker": {
        "backgroundColor": "#66FFFFFF",
        "foregroundColor": "#FFFFFFFF",
        "iconColor": "#FFFFFFFF",
        "disabledBackgroundColor": "#26FFFFFF",
        "disabledForegroundColor": "#FF848581",
        "disabledIconColor": "#FF848581"
      },
      "held": {
        "backgroundColor": "#66FFFFFF",
        "foregroundColor": "#FFFFFFFF",
        "iconColor": "#FFFFFFFF",
        "disabledBackgroundColor": "#26FFFFFF",
        "disabledForegroundColor": "#FF848581",
        "disabledIconColor": "#FF848581"
      },
      "swap": {
        "backgroundColor": "#66FFFFFF",
        "foregroundColor": "#FFFFFFFF",
        "iconColor": "#FFFFFFFF",
        "disabledBackgroundColor": "#26FFFFFF",
        "disabledForegroundColor": "#FF848581",
        "disabledIconColor": "#FF848581"
      },
      "key": {
        "backgroundColor": "#66FFFFFF",
        "foregroundColor": "#FFFFFFFF",
        "iconColor": "#FFFFFFFF",
        "disabledBackgroundColor": "#26FFFFFF",
        "disabledForegroundColor": "#FF848581",
        "disabledIconColor": "#FF848581"
      }
    }
  }
}
```

**Dark:**

```json
{
  "dialing": {
    "actions": {
      "callStart": {
        "backgroundColor": "#34C759",
        "foregroundColor": "#FFFFFF",
        "iconColor": "#FFFFFF",
        "disabledBackgroundColor": "#3A3A3A",
        "disabledForegroundColor": "#9E9E9E",
        "disabledIconColor": "#9E9E9E"
      },
      "hangup": {
        "backgroundColor": "#FF3B30",
        "foregroundColor": "#FFFFFF",
        "iconColor": "#FFFFFF",
        "disabledBackgroundColor": "#3A3A3A",
        "disabledForegroundColor": "#9E9E9E",
        "disabledIconColor": "#9E9E9E"
      },
      "transfer": {
        "backgroundColor": "#2E7D32",
        "foregroundColor": "#FFFFFF",
        "iconColor": "#FFFFFF",
        "disabledBackgroundColor": "#3A3A3A",
        "disabledForegroundColor": "#9E9E9E",
        "disabledIconColor": "#9E9E9E"
      },
      "camera": {
        "backgroundColor": "#2A2A2A",
        "foregroundColor": "#FFFFFF",
        "iconColor": "#FFFFFF",
        "disabledBackgroundColor": "#1F1F1F",
        "disabledForegroundColor": "#6D6D6D",
        "disabledIconColor": "#9E9E9E"
      },
      "muted": {
        "backgroundColor": "#2A2A2A",
        "foregroundColor": "#FFFFFF",
        "iconColor": "#FFFFFF",
        "disabledBackgroundColor": "#1F1F1F",
        "disabledForegroundColor": "#6D6D6D",
        "disabledIconColor": "#9E9E9E"
      },
      "speaker": {
        "backgroundColor": "#2A2A2A",
        "foregroundColor": "#FFFFFF",
        "iconColor": "#FFFFFF",
        "disabledBackgroundColor": "#1F1F1F",
        "disabledForegroundColor": "#6D6D6D",
        "disabledIconColor": "#9E9E9E"
      },
      "held": {
        "backgroundColor": "#2A2A2A",
        "foregroundColor": "#FFFFFF",
        "iconColor": "#FFFFFF",
        "disabledBackgroundColor": "#1F1F1F",
        "disabledForegroundColor": "#6D6D6D",
        "disabledIconColor": "#9E9E9E"
      },
      "swap": {
        "backgroundColor": "#2A2A2A",
        "foregroundColor": "#FFFFFF",
        "iconColor": "#FFFFFF",
        "disabledBackgroundColor": "#1F1F1F",
        "disabledForegroundColor": "#6D6D6D",
        "disabledIconColor": "#9E9E9E"
      },
      "key": {
        "backgroundColor": "#2A2A2A",
        "foregroundColor": "#FFFFFF",
        "iconColor": "#FFFFFF",
        "disabledBackgroundColor": "#1F1F1F",
        "disabledForegroundColor": "#6D6D6D",
        "disabledIconColor": "#9E9E9E"
      }
    }
  }
}
```

---

## Keypad page

Top-level keys inside `"keypad"`:

| Key                    | Type   | Description                                       |
|------------------------|--------|---------------------------------------------------|
| `systemUiOverlayStyle` | object | Status/navigation bars styling.                   |
| `textField`            | object | Number input field style (top of page).           |
| `contactName`          | object | Resolved contact name style (under input).        |
| `keypad`               | object | Numeric keypad layout (digits, spacing, padding). |
| `actionpad`            | object | Action buttons (call, backspace, etc.).           |

**Minimal example:**

```json
{
  "keypad": {
    "systemUiOverlayStyle": {
      "statusBarIconBrightness": "dark"
    },
    "textField": {
      "textStyle": {
        "color": "#123752",
        "fontSize": 22
      }
    },
    "contactName": {
      "textStyle": {
        "color": "#848581",
        "fontSize": 14
      }
    },
    "keypad": {
      "spacing": 16
    },
    "actionpad": {}
  }
}
```

---

## Common object formats

### ImageSource

Provide one of the supported sources (keep to what your build supports). Common patterns:

```json
{
  "asset": "assets/branding/logo.png"
}
```

or

```json
{
  "url": "https://cdn.example.com/logo.png",
  "cache": true
}
```

### System UI overlay style (`systemUiOverlayStyle`)

```json
{
  "statusBarIconBrightness": "light|dark",
  "statusBarBrightness": "light|dark",
  "systemNavigationBarColor": "#AARRGGBB",
  "systemNavigationBarIconBrightness": "light|dark"
}
```

### App bar style (`appBarStyle`)

```json
{
  "backgroundColor": "#AARRGGBB",
  "foregroundColor": "#AARRGGBB",
  "primary": true,
  "showBackButton": true
}
```

### Text style (`TextStyleConfig` shape)

```json
{
  "color": "#AARRGGBB",
  "fontSize": 16,
  "fontWeight": {
    "weight": 400
  },
  "letterSpacing": 0.0,
  "fontFeatures": [
    "tabularFigures"
  ]
}
```

### Text field (`TextFieldConfig` shape)

```json
{
  "textStyle": {
    "...": "see TextStyleConfig"
  },
  "hintStyle": {
    "...": "see TextStyleConfig"
  },
  "cursorColor": "#AARRGGBB",
  "padding": {
    "left": 0,
    "top": 0,
    "right": 0,
    "bottom": 0
  }
}
```

### Keypad (`KeypadStyleConfig` shape)

```json
{
  "spacing": 16,
  "padding": {
    "left": 24,
    "top": 12,
    "right": 24,
    "bottom": 24
  },
  "digitTextStyle": {
    "fontSize": 28,
    "color": "#FFFFFF"
  },
  "subTextStyle": {
    "fontSize": 12,
    "color": "#B3FFFFFF"
  }
}
```

### Action pad (`ActionPadWidgetConfig` shape)

```json
{
  "spacing": 12,
  "padding": {
    "left": 16,
    "top": 8,
    "right": 16,
    "bottom": 24
  },
  "callButton": {
    /* ElevatedButtonWidgetConfig */
  },
  "backspaceButton": {
    /* ElevatedButtonWidgetConfig */
  }
}
```

### Elevated button widget (`ElevatedButtonWidgetConfig` shape)

```json
{
  "backgroundColor": "#AARRGGBB",
  "foregroundColor": "#AARRGGBB",
  "textColor": "#AARRGGBB",
  "iconColor": "#AARRGGBB",
  "disabledBackgroundColor": "#AARRGGBB",
  "disabledForegroundColor": "#AARRGGBB",
  "disabledIconColor": "#AARRGGBB",
  "shape": "circle|stadium|rounded",
  "elevation": 2
}
```

---

### Notes & tips

- `dialing.actions` must live **inside** `"dialing"`, not at root.
- If a section is omitted, in-app defaults apply.
- For toggleable call actions (`muted`, `speaker`, `camera`, `held`), the UI can switch visuals when
  the control is selected—ensure the widget sets the selected state so your
  enabled/disabled/selected colors are respected.
- Prefer ARGB with partial alpha for layered UIs (e.g., translucent buttons over gradients).
