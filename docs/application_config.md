# Application Configuration

This document outlines the main application configuration, which controls high-level features,
navigation structure, and screen-specific behaviors.

## Table of Contents

- [Login Configuration](#login-configuration)
  - [Sign-In Tab Order](#sign-in-tab-order)
  - [Login QR Sign-In](#login-qr-sign-in)
  - [Login Common](#login-common)
  - [Login Mode Select](#login-mode-select)
- [Main Configuration](#main-configuration)
  - [Bottom Menu Configuration](#bottom-menu-configuration)
  - [Tab Variants](#tab-variants)
- [Call Configuration](#call-configuration)
  - [Transfer Configuration](#transfer-configuration)
  - [Call Pull Video Strategy](#call-pull-video-strategy)
- [Settings Configuration](#settings-configuration)
  - [Settings Sections](#settings-sections)
  - [Settings Items](#settings-items)
- [Embedded Pages](#embedded-pages)

---

## Login Configuration

The `loginConfig` section defines the app’s login screen behavior and embedded onboarding logic.

```json
{
  "loginConfig": {
    "signinOrder": ["passwordSignin", "otpSignin", "signup"],
    "qr": {
      "enabled": false,
      "formats": [
        { "type": "uri", "schemes": ["csc"] },
        { "type": "json" }
      ],
      "expectedHost": null
    },
    "common": {
      "fullScreenLaunchEmbeddedResourceId": "1"
    },
    "modeSelect": {
      "greetingL10n": "WebTrit",
      "actions": [
        {
          "enabled": true,
          "type": "login",
          "titleL10n": "login_Button_signUpToDemoInstance"
        },
        {
          "enabled": true,
          "type": "embedded",
          "titleL10n": "login_Button_signIn",
          "embeddedId": "1"
        }
      ]
    }
  }
}
```

### Sign-In Tab Order

| Field         | Type           | Default                                    | Description                                                                                                                    |
|---------------|----------------|--------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------|
| `signinOrder` | `List<String>` | `["passwordSignin", "otpSignin", "signup"]` | Order of the sign-in tabs on the login switch screen, by login type name (incl. `qrSignin`). Only the types actually available are shown; the first one is selected by default. Unknown or omitted names are placed last. |

### Login QR Sign-In

The `qr` block enables signing in by scanning a provisioning QR code
(`scheme:user:password@host`). See [qr_signin.md](qr_signin.md) for the payload
format, scheme descriptions and screen behavior.

| Field          | Type           | Default   | Description                                                                                   |
|----------------|----------------|-----------|-----------------------------------------------------------------------------------------------|
| `enabled`      | `bool`         | `false`   | Whether the QR sign-in tab is available. The tab also requires the backend to support password sign-in. |
| `formats`      | `List<Format>` | uri (csc) + json | Accepted payload formats (`{ "type": "uri" | "json", "schemes": [...] }`), probed in this order; `schemes` applies to `uri` only. |
| `expectedHost` | `string?`      | `null`    | Expected host (cloud id) of the code, shared by all formats; mismatching codes are rejected. `null` accepts any host. |

### Login Common

| Field                                | Type      | Description                                                                 |
|--------------------------------------|-----------|-----------------------------------------------------------------------------|
| `fullScreenLaunchEmbeddedResourceId` | `string?` | Optional ID of an embedded resource to launch directly as the login screen. |

### Login Mode Select

Defines how login modes appear on the welcome screen.

| Field          | Type                              | Default            | Description                                           |
|----------------|-----------------------------------|--------------------|-------------------------------------------------------|
| `greetingL10n` | `string?`                         | —                  | Greeting text key.                                    |
| `actions`      | `List<AppConfigModeSelectAction>` | one default action | List of available login actions (native or embedded). |

Each `AppConfigModeSelectAction` includes:

| Field        | Type      | Description                                      |
|--------------|-----------|--------------------------------------------------|
| `enabled`    | `bool`    | Whether the action button is visible.            |
| `type`       | `string`  | Defines the action type (`login` or `embedded`). |
| `titleL10n`  | `string`  | Localized title of the button.                   |
| `embeddedId` | `string?` | Optional ID referencing an embedded resource.    |

---

## Main Configuration

The `mainConfig` section defines the bottom navigation structure and core feature availability for
the application.

```json
{
  "mainConfig": {
    "bottomMenu": {
      "cacheSelectedTab": true,
      "tabs": [
        {
          "enabled": true,
          "initial": false,
          "type": "favorites",
          "titleL10n": "main_BottomNavigationBarItemLabel_favorites",
          "icon": "0xe5fd"
        },
        {
          "enabled": true,
          "initial": false,
          "type": "recents",
          "titleL10n": "main_BottomNavigationBarItemLabel_recents",
          "icon": "0xe03a"
        },
        {
          "enabled": true,
          "initial": false,
          "type": "contacts",
          "titleL10n": "main_BottomNavigationBarItemLabel_contacts",
          "icon": "0xee35",
          "contactSourceTypes": [
            "local",
            "external"
          ]
        },
        {
          "enabled": true,
          "initial": true,
          "type": "keypad",
          "titleL10n": "main_BottomNavigationBarItemLabel_keypad",
          "icon": "0xe1ce"
        },
        {
          "enabled": true,
          "initial": false,
          "type": "messaging",
          "titleL10n": "main_BottomNavigationBarItemLabel_chats",
          "icon": "0xe155"
        },
        {
          "enabled": false,
          "initial": false,
          "type": "embedded",
          "titleL10n": "main_BottomNavigationBarItemLabel_embedded",
          "icon": "0xe2ce",
          "embeddedResourceId": "example_embedded_payload_data"
        }
      ]
    },
    "systemNotificationsEnabled": true
  }
}
```

### Bottom Menu Configuration

Each entry in the `tabs` array defines a **navigation tab** within the app’s main bottom bar.
The configuration is parsed into `BottomMenuTabScheme` union variants depending on the `type` value.

#### Common Fields

| Field       | Type     | Default | Description                                                                                                  |
|-------------|----------|---------|--------------------------------------------------------------------------------------------------------------|
| `enabled`   | `bool`   | `true`  | Whether the tab is visible and active in the UI.                                                             |
| `initial`   | `bool`   | `false` | Whether the tab should be selected by default at startup.                                                    |
| `type`      | `string` | —       | Defines which tab variant to render (`favorites`, `recents`, `contacts`, `keypad`, `messaging`, `embedded`). |
| `titleL10n` | `string` | —       | Localization key for the tab title.                                                                          |
| `icon`      | `string` | —       | Material icon codepoint (hex string).                                                                        |

---

### Tab Variants

### **FavoritesTabScheme**

Simple favorites list screen.

```json
{
  "type": "favorites",
  "enabled": true,
  "titleL10n": "main_BottomNavigationBarItemLabel_favorites",
  "icon": "0xe5fd"
}
```

### **RecentsTabScheme**

Recent calls or history screen.

```json
{
  "type": "recents",
  "enabled": true,
  "titleL10n": "main_BottomNavigationBarItemLabel_recents",
  "icon": "0xe03a",
  "supportsCallHistory": true
}
```

| Field                 | Type      | Default | Description |
| --------------------- | --------- | ------- | ----------- |
| `supportsCallHistory` | `boolean` | `true`  | Local opt-in for remote call history (CDRs). |

Remote call history (CDRs) is shown only when both signals agree: the resolved local flag is `true`
AND the server advertises the `callHistory` adapter capability in system-info. When either is false
the recents tab falls back to the local device call log. The legacy `useCdrs` key is still accepted
on read and migrated to `supportsCallHistory`.

The local flag can be overridden remotely via the Firebase Remote Config boolean
`feature_call_history_enabled`: when set, it takes precedence over the config `supportsCallHistory`
value; when unset it falls back to the config value. The remote override can flip the local opt-in
either way, but it never bypasses the server `callHistory` capability - the capability gate always
applies. Resolution: `(feature_call_history_enabled ?? supportsCallHistory) && callHistory`.

### **ContactsTabScheme**

Contact list screen.

```json
{
  "type": "contacts",
  "enabled": true,
  "titleL10n": "main_BottomNavigationBarItemLabel_contacts",
  "icon": "0xee35",
  "contactSourceTypes": [
    "local",
    "external"
  ]
}
```

- `contactSourceTypes`: which contact sources to display (`local`, `external`, etc.).

### **KeypadTabScheme**

Dial pad screen.

```json
{
  "type": "keypad",
  "enabled": true,
  "initial": true,
  "titleL10n": "main_BottomNavigationBarItemLabel_keypad",
  "icon": "0xe1ce"
}
```

### **MessagingTabScheme**

Messaging or chat tab.

```json
{
  "type": "messaging",
  "enabled": true,
  "titleL10n": "main_BottomNavigationBarItemLabel_chats",
  "icon": "0xe155"
}
```

### **EmbeddedTabScheme**

Embedded web resource tab.

```json
{
  "type": "embedded",
  "enabled": false,
  "titleL10n": "main_BottomNavigationBarItemLabel_embedded",
  "icon": "0xe2ce",
  "embeddedResourceId": "example_embedded_payload_data"
}
```

- `embeddedResourceId`: reference to a resource from the `embeddedResources` array in the root
  configuration.

### Notes

- The `type` field acts as a discriminator for parsing `BottomMenuTabScheme` variants. Unrecognized
  values will cause deserialization to fail.
- Tabs can be reordered or disabled, and the UI will adapt dynamically.
- `cacheSelectedTab: true` enables the app to remember the last active tab across sessions.

## Call Configuration

```json
{
  "callConfig": {
    "videoEnabled": true,
    "transfer": {
      "enableBlindTransfer": true,
      "enableAttendedTransfer": true
    }
  }
}
```

- `videoEnabled`: Enables video calls
- `transfer`: Call forwarding settings

### Transfer Configuration

- `enableBlindTransfer`: Enables blind call transfer.
- `enableAttendedTransfer`: Enables attended call transfer.

### Call Pull Video Strategy

Call Pull lets a user take over (pull) a call that is active on another of their
devices. Pulling a **video** call used to fail: the pull offer was audio-only, so
the server's answer kept the original `m=video` and `setRemoteDescription` rejected
it ("order of m-lines in answer doesn't match order in offer"). The behaviour is
controlled by a strategy configured under the top-level `supported` array:

```json
{
  "supported": [
    {
      "type": "callPull",
      "videoStrategy": "softMute"
    }
  ]
}
```

`videoStrategy` must match a `CallPullVideoStrategy` enum name. If the entry is
omitted or the value is invalid, it defaults to `softMute`.

| Strategy | Pull offer | Local camera | Needs backend `has_video` | Video-call result |
|----------|------------|--------------|---------------------------|-------------------|
| `softMute` (default) | recvonly video m-line | stays off | no | remote video is received, camera off; user can enable it afterwards |
| `hideVideo` | no video m-line | stays off | yes | known-video dialogs are excluded from the pull list |
| `mirror` | `video = has_video` | on for a video pull | yes | a video dialog is pulled as a full video call |

- `softMute`: the offer carries a `recvonly` video m-line (no camera opened), so the
  offer/answer media layouts match without any backend change. This is the safe
  default and works where dialog-info carries no media-type flag (e.g. PortaSwitch).
- `hideVideo`: video dialogs are dropped from the pull list, so only audio calls are
  pullable. Requires the backend to report media type via dialog-info `has_video`.
- `mirror`: the pull mirrors the real media - a video dialog is pulled through the
  normal video-call path (camera-backed video m-line) and an audio dialog as audio.
  Requires `has_video` and a server that answers a matching video answer; it opens
  the local camera on a video pull.

**Runtime override.** The strategy can also be set via the Firebase Remote Config
key `feature_call_pull_video_strategy`, which takes precedence over the configurator
default (resolution order: Remote Config override > configurator default >
`softMute`). On web the realtime Remote Config stream is skipped (see `web.md`), so a
change there applies on the next startup rather than live.

## Settings Configuration

### Settings Sections

```json
{
  "sections": [
    {
      "titleL10n": "settings_ListViewTileTitle_settings",
      "enabled": true,
      "items": [
        {
          "type": "network",
          "titleL10n": "settings_ListViewTileTitle_network",
          "icon": "0xe424"
        },
        {
          "type": "mediaSettings",
          "titleL10n": "settings_ListViewTileTitle_mediaSettings",
          "icon": "0xf1cf"
        },
        {
          "type": "embedded",
          "titleL10n": "settings_ListViewTileTitle_termsConditions",
          "icon": "0xeedf",
          "embeddedResourceId": 4
        }
      ]
    }
  ]
}
```

- `titleL10n`: Localized section title
- `enabled`: Whether the section is active
- `items`: List of settings in the section

### Settings Items

Each settings item includes:

- `type`: Setting type (network, encoding, embedded)
- `titleL10n`: Localized name
- `icon`: Item icon

## Embedded Pages

Embedded pages allow extending the WebTrit app with custom web content. These pages can be
integrated either as a bottom
menu tab or as a settings item.
See [embedded_resources.md](application_embedded_config.md) for full details of the embedded web
pages configuration.
