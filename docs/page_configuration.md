# Page Configuration

This document defines the **page-level appearance configuration** app reads from JSON: **Login
**, **About**, **Call (Dialing)**, and **Keypad**. Every section is optional—missing fields fall
back to sensible in-app defaults.

---

## Table of Contents

- [Color format](#color-format)
- [Global structure](#global-structure)
- [Login page](#login-page)
    - [Mode Select & Switch](#loginswitchpage)
    - [OTP & Password Sign-in (Inputs & Masks)](#loginotpsignin--loginpasswordsignin)
    - [Verification](#loginotpsigninverify--loginsignupverify)
- [About page](#about-page)
- [Call page (Dialing)](#call-page-dialing)
    - [App bar](#app-bar)
    - [Call info](#call-info)
- [Keypad page](#keypad-page)
- [Common page fields](#common-page-fields)
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

Top-level keys inside `login`:

| Key               | Type   | Description                                              |
|-------------------|--------|----------------------------------------------------------|
| `modeSelect`      | object | Mode selection screen (buttons, system bars, main logo). |
| `switchPage`      | object | “Switch mode” screen (main logo only).                   |
| `otpSignin`       | object | **NEW:** OTP request screen (phone/email input).         |
| `passwordSignin`  | object | **NEW:** Password login screen (user & password inputs). |
| `otpSigninVerify` | object | OTP sign-in verification screen (repeat countdown).      |
| `signupVerify`    | object | Sign-up verification screen (repeat countdown).          |

---

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
      "greetingTextStyle": {
        "color": "#FFFFFFFF",
        "fontSize": 24,
        "fontWeight": { "weight": 600 },
        "backgroundColor": "#CC123752",
        "backgroundBorderRadius": 8.0,
        "backgroundPadding": { "left": 16, "top": 8, "right": 16, "bottom": 8 }
      },
      "buttonLoginStyleType": "primary",
      "buttonSignupStyleType": "primary"
    }
  }
}
```

**Notes:**

- `systemUiOverlayStyle` — status/navigation bar colors & icon brightness
- `mainLogo` — image descriptor for the primary logo
- `greetingTextStyle` — text style for the greeting/onboarding text (see [TextStyleConfig](#text-style-textstyleconfig-shape)); when `backgroundColor` is combined with `backgroundBorderRadius` or `backgroundPadding`, a rounded decorated background is rendered behind the text
- `buttonLoginStyleType`, `buttonSignupStyleType` — enum style presets

---

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

---

### `login.otpSignin` / `login.passwordSignin`

These sections configure the input fields for login forms, including input masks.

### Configuration Keys:

- `refTextField` — identifier input (phone/email)

### Example with Input Mask

```json
{
  "login": {
    "otpSignin": {
      "refTextField": {
        "keyboardType": "phone",
        "textAlign": "left",
        "mask": {
          "pattern": "+380 (##) ###-##-##",
          "filter": {
            "#": "[0-9]"
          }
        }
      }
    },
    "passwordSignin": {
      "refTextField": {
        "keyboardType": "email",
        "textAlign": "start",
        "mask": null
      }
    }
  }
}
```

**Notes:**

- `keyboardType`: `"phone"`, `"email"`, `"text"`, `"number"`, etc.
- `mask.pattern`: Formatting pattern
- `mask.filter`: Regex definitions
- To disable masking: omit mask or set `"mask": null`

---

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

**Behavior:**

- `0` → “Repeat” always enabled
- `>0` → enabled after X seconds

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
    }
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

The styles for call action buttons are defined globally in the `Action Pad Configuration` section of
the `widgets_configuration.md` document. This allows for a consistent look and feel across the
application, including the main call screen and the keypad.

---

## Keypad page

Top-level keys inside `"keypad"`:

| Key                      | Type   | Description                                                                                                            |
|--------------------------|--------|------------------------------------------------------------------------------------------------------------------------|
| `appBarBackgroundColor`  | string | App bar background color (hex). See [Common page fields](#common-page-fields).                                         |
| `appBarBlurredSurface`   | object | Blurred surface config. See [Common page fields](#common-page-fields).                                                 |
| `systemUiOverlayStyle`   | object | Status/navigation bars styling.                                                                                        |
| `textField`              | object | Number input field style (top of page).                                                                                |
| `contactName`            | object | Resolved contact name style (under input).                                                                             |
| `keypad`                 | object | Numeric keypad layout (digits, spacing, padding).                                                                      |
| `actionpad`              | object | Layout for action buttons (call, backspace, etc.). Button styles are taken from the global `Action Pad Configuration`. |

**Minimal example:**

```json
{
  "keypad": {
    "appBarBackgroundColor": "#000000",
    "appBarBlurredSurface": {
      "color": "#66000000",
      "sigmaX": 10,
      "sigmaY": 10
    },
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

## Common page fields

Every page config that has an app bar supports these optional fields:

| Key                     | Type   | Description                                                        |
|-------------------------|--------|--------------------------------------------------------------------|
| `appBarBackgroundColor` | string | Background color for the app bar (hex). Overrides the default.     |
| `appBarBlurredSurface`  | object | Blurred surface overlay config (frosted-glass effect in app bar).  |

### `appBarBlurredSurface`

```json
{
  "appBarBlurredSurface": {
    "color": "#66000000",
    "sigmaX": 10,
    "sigmaY": 10
  }
}
```

| Key      | Type   | Default | Description                          |
|----------|--------|---------|--------------------------------------|
| `color`  | string | `null`  | Overlay color (hex).                 |
| `sigmaX` | double | `0`     | Horizontal gaussian blur sigma.      |
| `sigmaY` | double | `0`     | Vertical gaussian blur sigma.        |

Applies to: **Keypad**, **Contacts**, **Favorites**, **Recents**, **Conversations**, **Settings**, **About**.

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
  ],
  "backgroundColor": "#33000000",
  "backgroundBorderRadius": 4.0,
  "backgroundPadding": {
    "left": 4,
    "top": 2,
    "right": 4,
    "bottom": 2
  }
}
```

- `backgroundColor` — background fill behind the text (hex).
- `backgroundBorderRadius` — corner radius for the background decoration.
- `backgroundPadding` — padding around text when background is applied (`left`, `top`, `right`, `bottom`).

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

This object configures the layout (spacing and padding) for the action buttons at the bottom of the
keypad, such as the call and backspace buttons. The styles for these buttons are not defined here;
instead, they are sourced from the global `Action Pad Configuration` defined in
`widgets_configuration.md`. For example, the call button on this screen uses the `callStart` style,
and the backspace button uses the `backspace` style.

```json
{
  "spacing": 12,
  "padding": {
    "left": 16,
    "top": 8,
    "right": 16,
    "bottom": 24
  }
}
```

---

### Notes & tips

- If a section is omitted, in-app defaults apply.
- For toggleable call actions (`muted`, `speaker`, `camera`, `held`), the UI can switch visuals when
  the control is selected—ensure the widget sets the selected state so your
  enabled/disabled/selected colors are respected.
- Prefer ARGB with partial alpha for layered UIs (e.g., translucent buttons over gradients).
