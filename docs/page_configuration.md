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
    - [Call list](#call-list)
    - [Acting on hint](#acting-on-hint)
    - [Call actions](#call-actions)
- [Keypad page](#keypad-page)
    - [Action pad](#action-pad)
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

| Key                    | Type   | Description                                                                    |
|------------------------|--------|--------------------------------------------------------------------------------|
| `systemUiOverlayStyle` | object | Status/navigation bars styling.                                                |
| `appBarStyle`          | object | App bar styling (background/foreground/primary/back button).                   |
| `appBarBlurredSurface` | object | Blurred surface behind the app bar. See [Common page fields](#common-page-fields). |
| `background`           | object | Page background (solid color, gradient or image).                              |
| `callInfo`             | object | Text styles for username/number/status.                                        |
| `callList`             | object | Row colors of the multi-call list and its per-state status dots.               |
| `actingOnHint`         | object | Colors of the "Acting on" pill shown above the actions with several calls.     |
| `actions`              | object | Styles of the call action buttons (call, hangup, mute, transfer, ...).         |

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

### Call list

`dialing.callList` colors the list shown when more than one call is up: the rows themselves and the
small dot that marks each call's state.

```json
{
  "dialing": {
    "callList": {
      "rowBackgroundColor": "#1AFFFFFF",
      "rowFocusedBackgroundColor": "#42FFFFFF",
      "rowFocusedBorderColor": "#8CFFFFFF",
      "dotRingingColor": "#FFD54F",
      "dotOnCallColor": "#9CCC65",
      "dotHeldColor": "#8CFFFFFF"
    }
  }
}
```

---

### Acting on hint

`dialing.actingOnHint` colors the pill above the action buttons that tells the user which call the
buttons will act on.

```json
{
  "dialing": {
    "actingOnHint": {
      "backgroundColor": "#40000000",
      "affectedNameColor": "#FFE082"
    }
  }
}
```

---

### Call actions

`dialing.actions` styles the round buttons at the bottom of the call screen. Each key is one button
and takes a button style object (the same shape as every other button in the theme, see
[Button Configuration](widgets_configuration.md#button-configuration)):

| Key         | Button                                  |
|-------------|-----------------------------------------|
| `callStart` | Answer / place the call.                |
| `hangup`    | End the call.                           |
| `transfer`  | Transfer the call.                      |
| `swap`      | Switch between two calls.               |
| `key`       | Open the in-call keypad.                |
| `camera`    | Camera on/off (toggle).                 |
| `muted`     | Microphone on/off (toggle).             |
| `speaker`   | Speaker / audio device (toggle).        |
| `held`      | Hold / resume (toggle).                 |

`keypadInputStyle` (text style) sets how the digits typed on the in-call keypad look.

**Only the color fields are read here.** A button style can also carry a shape, a size, padding, an
elevation and a text style. The call screen draws these buttons at a fixed size and ignores those
fields; setting them does no harm, it simply changes nothing.

The buttons carry an icon and no text, so `iconColor` is the one you see. `foregroundColor` is still
read - on the always-on buttons it tints the press ripple - but it never colors the glyph: leaving
`iconColor` out falls the icon back to the color scheme, not to `foregroundColor`.

**States.** You can set the resting colors, the switched-on colors of a toggle, and the disabled
colors:

```json
{
  "dialing": {
    "actions": {
      "hangup": {
        "backgroundColor": "#E74C3C",
        "foregroundColor": "#FFFFFF",
        "iconColor": "#FFFFFF",
        "disabledBackgroundColor": "#66DDE0E3",
        "disabledForegroundColor": "#848581",
        "disabledIconColor": "#848581"
      },
      "muted": {
        "backgroundColor": "#66FFFFFF",
        "iconColor": "#FFFFFF"
      }
    }
  }
}
```

All four toggles - `camera`, `muted`, `speaker` and `held` - also have an "on" look, for when the
mute is engaged, the camera is running or the call is on hold. Set it with `selectedBackgroundColor`,
`selectedForegroundColor` and `selectedIconColor`; leave a slot out and that part of the on look
still comes from the color scheme. On the always-on buttons these keys are ignored - those buttons
are never switched on.

```json
{
  "dialing": {
    "actions": {
      "muted": {
        "backgroundColor": "#66FFFFFF",
        "iconColor": "#FFFFFF",
        "selectedBackgroundColor": "#0B6E4F",
        "selectedIconColor": "#FFFFFF"
      }
    }
  }
}
```

**What a color you leave out falls back to:**

| Left out                                             | Falls back to                                                          |
|------------------------------------------------------|-------------------------------------------------------------------------|
| `backgroundColor`, `foregroundColor`, `iconColor`     | the color-scheme role of that button                                   |
| `selectedBackgroundColor`, `selectedForegroundColor`, `selectedIconColor` | the color-scheme's switched-on roles           |
| `disabledBackgroundColor`, `disabledForegroundColor`  | 40% of the resting color, whether that came from the theme or the scheme |
| `disabledIconColor`                                   | 40% of the scheme surface color                                        |

So a button whose background or foreground you color yourself dims to your own color, and one you
leave alone dims to the palette's. The icon is the exception in the table above: it always dims to
the scheme surface unless you set `disabledIconColor`.

---

## Keypad page

Top-level keys inside `"keypad"`:

| Key                      | Type   | Description                                                                                                            |
|--------------------------|--------|------------------------------------------------------------------------------------------------------------------------|
| `appBarBlurredSurface`   | object | Blurred surface config. See [Common page fields](#common-page-fields).                                                 |
| `systemUiOverlayStyle`   | object | Status/navigation bars styling.                                                                                        |
| `textField`              | object | Number input field style (top of page).                                                                                |
| `contactName`            | object | Resolved contact name style (under input).                                                                             |
| `keypad`                 | object | Numeric keypad (digit text styles, spacing, padding).                                                                  |
| `actionpad`              | object | Styles of the three buttons under the keypad. See [Action pad](#action-pad).                                           |

**Minimal example:**

```json
{
  "keypad": {
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

### Action pad

`keypad.actionpad` styles the buttons under the numeric keypad. There are three, and each takes a
button style object (see
[Button Configuration](widgets_configuration.md#button-configuration)):

| Key                | Button                                                    |
|--------------------|-----------------------------------------------------------|
| `callStart`        | Place the call (the large one).                           |
| `callTransfer`     | Transfer the call.                                        |
| `backspacePressed` | Backspace. The name is historical: it is the button style, not a pressed state. |

```json
{
  "keypad": {
    "actionpad": {
      "callStart": {
        "backgroundColor": "#75B943",
        "foregroundColor": "#FFFFFF",
        "iconColor": "#FFFFFF"
      },
      "backspacePressed": {
        "backgroundColor": "#00000000",
        "iconColor": "#494949"
      }
    }
  }
}
```

The digits themselves are not buttons here - their text styles live in `keypad.keypad`.

---

## Common page fields

Every page config that has an app bar supports these optional fields:

| Key                     | Type   | Description                                                        |
|-------------------------|--------|--------------------------------------------------------------------|
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

| Key      | Type   | Default | Description                       |
|----------|--------|---------|-----------------------------------|
| `color`  | string | `null`  | Overlay color (hex).              |
| `sigmaX` | double | `null`  | Horizontal gaussian blur sigma. Defaults to 10 when omitted. |
| `sigmaY` | double | `null`  | Vertical gaussian blur sigma. Defaults to 10 when omitted.   |

When `appBarBlurredSurface` is present (even `{}`), the app bar applies a frosted-glass blur. `sigmaX`/`sigmaY` default to 10 when omitted. When `appBarBlurredSurface` is absent (`null`), no blur is applied and the app bar uses the standard theme background.

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
- For toggleable call actions (`muted`, `speaker`, `camera`, `held`) the theme file sets the resting,
  switched-on and disabled looks; see [Call actions](#call-actions).
- Prefer ARGB with partial alpha for layered UIs (e.g., translucent buttons over gradients).
