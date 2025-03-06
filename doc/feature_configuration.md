# Setup App Features Scheme

## Table of Contents

- [Mode Select Actions](#mode-select-actions)
- [Setup Main Configuration](#setup-main-configuration)
- [Bottom Menu Configuration](#bottom-menu-configuration)
- [Setup Call Configuration](#setup-call-configuration)
- [Transfer Configuration](#transfer-configuration)
- [Setup Settings Configuration](#setup-settings-configuration)
- [Settings Sections](#settings-sections)
- [Settings Items](#settings-items)
- [Embedded Resources](#embedded-resources)

---

## Mode Select Actions

Settings for login mode selection buttons:

- `enabled`: Determines if the button is active
- `embeddedResourceId`: ID of the resource for the embedded page (if applicable)
- `type`: Action type (login, embedded)
- `titleL10n`: Localized button title

## Setup Main Configuration

The main configuration defines the navigation structure.

## Bottom Menu Configuration

```json
{
  "bottomMenu": {
    "cacheSelectedTab": true,
    "tabs": [
      {
        "enabled": true,
        "type": "favorites",
        "titleL10n": "main_BottomNavigationBarItemLabel_favorites",
        "icon": "0xe5fd"
      },
      {
        "enabled": true,
        "type": "recents",
        "titleL10n": "main_BottomNavigationBarItemLabel_recents",
        "icon": "0xe03a"
      },
      {
        "enabled": true,
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
        "type": "messaging",
        "titleL10n": "main_BottomNavigationBarItemLabel_chats",
        "icon": "0xe155"
      },
      {
        "enabled": false,
        "type": "embedded1",
        "titleL10n": "embaded1TitleL10n",
        "icon": "0xe2ce",
        "embeddedResourceId": 2
      }
    ]
  }
}
```

- `cacheSelectedTab`: Saves the last selected tab
- `tabs`: List of bottom menu tabs

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

## Embedded Resources

```json
{
  "embeddedResources": [
    {
      "id": 1,
      "uri": "asset://assets/themes/custom_signup.html",
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

- `id`: Unique resource identifier
- `uri`: URL or resource path
- `toolbar`: Toolbar settings for the embedded page

