# Page Configuration

This document describes the **page-level appearance configuration** used by the app. It covers the
Login, About, Call (Dialing), and Keypad pages, and explains how to structure JSON for each section,
including color and typography options, and the new **Call Actions** area.

> This file supersedes previous versions of `page_configuration.md`. It reflects the current DTOs in
`theme_page_config.dart` (Freezed models).

---

## Table of Contents

- [Overview](#overview)
- [Color format & alpha (ARGB)](#color-format--alpha-argb)
- [ThemePageConfig](#themepageconfig)
- [Login Page](#login-page)
- [About Page](#about-page)
- [Call Page (Dialing)](#call-page-dialing)
    - [App Bar](#app-bar)
    - [Call Info](#call-info)
    - [Call Actions](#call-actions)
    - [Light & Dark examples for `actions`](#light--dark-examples-for-actions)
- [Keypad Page](#keypad-page)

---

## Overview

Page configuration is declared via Freezed DTOs and serialized as JSON. Each section is optional;
when a section (or its fields) is omitted, built-in defaults from the app theme are used. This makes
it easy to ship a minimal configuration and progressively override styles as needed.

---

## Color format & alpha (ARGB)

All color fields accept a **HEX string**:

- `#RRGGBB` — opaque color (alpha = `FF` is assumed).
- `#AARRGGBB` — color **with explicit alpha** (recommended if you want glassy/translucent UI). For
  example, `#66FFFFFF` is white at ~40% opacity.

> The `toColor()` converter supports both formats. Use ARGB when you want semi-transparent call
> action backgrounds that blend with gradients.

---

## ThemePageConfig

Root DTO that aggregates per-page configs:

```dart
@Freezed()
class ThemePageConfig {
  const factory ThemePageConfig({
    @Default(LoginPageConfig()) LoginPageConfig login,
    @Default(AboutPageConfig()) AboutPageConfig about,
    @Default(CallPageConfig()) CallPageConfig dialing,
    @Default(KeypadPageConfig()) KeypadPageConfig keypad,
  }) = _ThemePageConfig;
}
```

JSON example (only the `dialing` page shown for brevity):

```json
{
  "dialing": {
  }
}
```

---

## Login Page

**DTO:** `LoginPageConfig`

- `imageSource`: Structured image descriptor (preferred).
- `picture` *(deprecated)*: Raw string path/URL for the logo/picture.
- `scale`: Optional scale factor for the picture.
- `labelColor`: HEX/ARGB color for labels.
- `modeSelect`: `LoginModeSelectPageConfig`
    - `systemUiOverlayStyle`: Status/navigation bars appearance.
    - `buttonLoginStyleType`: Enum preset for the Login button.
    - `buttonSignupStyleType`: Enum preset for the Signup button.
- `otpSigninVerify`: `LoginOtpSigninVerifyScreenPageConfig`
    - `countdownRepeatIntervalSeconds`: Integer. Countdown interval (in seconds) before the “Repeat”
      button becomes active again.
        - `0` → countdown disabled, button is always active.
        - `>0` → countdown active, button enabled after interval.
- `signupVerify`: `LoginSignupVerifyScreenPageConfig`
    - `countdownRepeatIntervalSeconds`: Integer. Countdown interval (in seconds) before the “Repeat”
      button becomes active again.
        - `0` → countdown disabled, button is always active.
        - `>0` → countdown active, button enabled after interval.
- `metadata`: `Metadata` block with arbitrary structured info.

**Minimal example (with countdown disabled for both OTP and Signup verify):**

```json
{
  "login": {
    "imageSource": {
      "asset": "assets/branding/logo.png"
    },
    "labelColor": "#30302F",
    "modeSelect": {
      "systemUiOverlayStyle": {
        "statusBarIconBrightness": "dark",
        "systemNavigationBarIconBrightness": "dark"
      },
      "buttonLoginStyleType": "primary",
      "buttonSignupStyleType": "primary"
    },
    "otpSigninVerify": {
      "countdownRepeatIntervalSeconds": 0
    },
    "signupVerify": {
      "countdownRepeatIntervalSeconds": 0
    },
    "metadata": {}
  }
}
```

**Example with custom countdown:**

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

---

## About Page

**DTO:** `AboutPageConfig`

- `imageSource`: Structured image source (preferred).
- `picture` *(deprecated)*: Raw string path/URL.
- `metadata`: Arbitrary structured info (e.g., version/build).

**Minimal example:**

```json
{
  "about": {
    "imageSource": {
      "asset": "assets/branding/about.png"
    },
    "metadata": {}
  }
}
```

---

## Call Page (Dialing)

**DTO:** `CallPageConfig`

- `systemUiOverlayStyle`: Controls status & navigation bars.
- `appBarStyle`: See [App Bar](#app-bar).
- `callInfo`: See [Call Info](#call-info).
- `actions`: See [Call Actions](#call-actions).

A compact example:

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
    "actions": {
    }
  }
}
```

### App Bar

**DTO:** `AppBarStyleConfig`

- `backgroundColor`: HEX/ARGB.
- `foregroundColor`: HEX/ARGB.
- `primary`: Whether the AppBar is “primary” (app-level) or page-overlay.
- `showBackButton` *(if present in your build)*: Toggles the back chevron.

### Call Info

**DTO:** `CallPageInfoConfig`

- `usernameTextStyle`: `TextStyleConfig` for the main name (e.g. *displaySmall*).
- `numberTextStyle`: Secondary line for the phone number.
- `callStatusTextStyle`: Status (e.g., duration / incoming).
- `processingStatusTextStyle`: For ongoing operations (e.g., “Transferring…”).

### Call Actions

**IMPORTANT: Nesting & placement**  
`actions` is **not** a top-level object. It is a child of the **Call Page** (Dialing) configuration:

```
ThemePageConfig.dialing.actions  // i.e. CallPageConfig.actions
```

**Correct JSON placement:**

```json
{
  "dialing": {
    "actions": {
      "callStart": {
      },
      "hangup": {
      },
      "transfer": {
      },
      "camera": {
      },
      "muted": {
      },
      "speaker": {
      },
      "held": {
      },
      "swap": {
      },
      "key": {
      }
    }
  }
}
```

**DTOs:**

- `CallPageActionsConfig` contains those fields.
- Each field is an `ElevatedButtonWidgetConfig` with:
    - `backgroundColor`: Button fill (HEX/ARGB).
    - `foregroundColor`: Icon/text tint for enabled state.
    - `textColor`: Optional explicit text color (fallbacks to `foregroundColor`).
    - `iconColor`: Icon tint for enabled state.
    - `disabledIconColor`: Icon tint for disabled state.
    - `disabledBackgroundColor`: Fill when disabled.
    - `disabledForegroundColor`: Tint when disabled.

> **State handling:** Toggle-like actions (camera/muted/speaker/held) can switch appearance when
`MaterialState.selected` is active. In app code, this is wired via `MaterialStatesController` and
`ButtonStyle` resolvers.

#### Alpha-driven “glassy” look (recommended)

For semi-transparent circular buttons that blend with a gradient background, use ARGB:

- Normal state: e.g., `"#66FFFFFF"` (≈40% opacity).
- Disabled: e.g., `"#26FFFFFF"` (≈15% opacity).

### Light & Dark examples for `actions`

> **Note:** both examples are shown **inside** `dialing` to emphasize the correct nesting.

**Light theme example (glassy neutral actions):**

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

**Dark theme example:**

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

## Keypad Page

**DTO:** `KeypadPageConfig`

- `systemUiOverlayStyle`: Status/navigation bars appearance.
- `textField`: `TextFieldConfig` for the number input at the top.
- `contactName`: `TextFieldConfig` for resolved contact name.
- `keypad`: `KeypadStyleConfig` (digits grid, spacing, paddings).
- `actionpad`: `ActionPadWidgetConfig` (call buttons, backspace, etc.).

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

### Notes & tips

- `actions` must be nested under `dialing`. It is **not** a root-level section.
- If `actions` are omitted for the Call page, the app falls back to theme defaults.
- For toggle actions, ensure the widget sets `MaterialState.selected` (e.g., via
  `MaterialStatesController`) so the `ButtonStyle` resolvers can switch backgrounds and icon colors.
- Keep disabled styles high-contrast enough to meet a11y guidelines on both light and dark
  backgrounds.
