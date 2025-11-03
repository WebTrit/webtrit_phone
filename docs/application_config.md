# Setup App Configuration

## Table of Contents

- [Login Screen Configuration](#login-screen-configuration)
- [Setup Main Configuration](#setup-main-configuration)
- [Bottom Menu Configuration](#bottom-menu-configuration)
- [Setup Call Configuration](#setup-call-configuration)
- [Transfer Configuration](#transfer-configuration)
- [Setup Settings Configuration](#setup-settings-configuration)
- [Settings Sections](#settings-sections)
- [Settings Items](#settings-items)
- [Embedded pages](#embedded-pages)
- [Embedded Resources](#embedded-resources)

---

## Login Configuration

The `loginConfig` section defines the app’s login screen behavior and embedded onboarding logic.

```json
{
  "loginConfig": {
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

# Setup Main Configuration

The **main configuration** defines the bottom navigation structure and core feature availability for
the application.

---

## Structure

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
          "icon": "0xe03a",
          "useCdrs": false
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

---

## Bottom Menu Configuration

Each entry in the `tabs` array defines a **navigation tab** within the app’s main bottom bar.  
The configuration is parsed into `BottomMenuTabScheme` union variants depending on the `type` value.

### Common Fields

| Field       | Type     | Default | Description                                                                                                  |
|-------------|----------|---------|--------------------------------------------------------------------------------------------------------------|
| `enabled`   | `bool`   | `true`  | Whether the tab is visible and active in the UI.                                                             |
| `initial`   | `bool`   | `false` | Whether the tab should be selected by default at startup.                                                    |
| `type`      | `string` | —       | Defines which tab variant to render (`favorites`, `recents`, `contacts`, `keypad`, `messaging`, `embedded`). |
| `titleL10n` | `string` | —       | Localization key for the tab title.                                                                          |
| `icon`      | `string` | —       | Material icon codepoint (hex string).                                                                        |

---

## Tab Variants

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
  "useCdrs": false
}
```

- `useCdrs`: *(optional)* whether to fetch recent data from remote CDR history.

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

---

## Notes

- `type` acts as a discriminator for `BottomMenuTabScheme` union parsing.
- Any unrecognized `type` will cause deserialization to fail, so ensure it matches one of the known
  variants.
- You can reorder or disable tabs freely; the app dynamically adapts to the provided configuration.
- `cacheSelectedTab: true` means the app remembers the last active tab across sessions.

## Setup Call Configuration

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

## Transfer Configuration

- `enableBlindTransfer`: Enables blind call transfer
- `enableAttendedTransfer`: Enables attended call transfer

## Setup Settings Configuration

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

## Embedded pages

Embedded pages allow extending the WebTrit app with custom web content. These pages can be
integrated either as a bottom
menu tab or as a settings item.
[Embedded configuration](embedded_pages.md)

## Embedded Resources

The `embeddedResources` section defines the resources that can be embedded within the application.
Each resource can
either be a local file or a URL to an external page. If using a local file, ensure it is placed in
the `assets`
directory and provide the correct path.

```json
{
  "embeddedResources": [
    {
      "id": 1,
      "uri": "https://webtrit-app.web.app/example/example_embedded_login.html",
      "toolbar": {
        "showToolbar": true,
        "titleL10n": "login_requestCredentials_title"
      }
    },
    {
      "id": 4,
      "uri": "https://webtrit.com/legal/privacy-policy-for-webtrit-app/",
      "toolbar": {
        "showToolbar": true,
        "titleL10n": "settings_ListViewTileTitle_termsConditions"
      }
    }
  ]
}
```

- `id`: Unique resource identifier.
- `uri`: URL or resource path.
- `toolbar`: Toolbar settings for the embedded page.
    - `showToolbar`: Boolean to show or hide the toolbar.
    - `titleL10n`: Localized title for the toolbar.
