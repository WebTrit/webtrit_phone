# README

## Overview

This documentation outlines the configuration of the bottom menu for the app, detailing how to set up the tabs, their
properties, and how they are managed within the app.

## Configuration Schema

The configuration for the bottom menu is defined in a JSON structure. Below is the schema for the bottom menu
configuration:

### JSON Schema

```json
{
  "login": {
    "customSignIn": {
      "enabled": false,
      "titleL10n": "login_requestCredentials_title",
      "url": "https://webtrit-app.web.app/example/example_embedded_login.html"
    }
  },
  "main": {
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
          "icon": "0xee35"
        },
        {
          "enabled": true,
          "initial": true,
          "type": "keypad",
          "titleL10n": "main_BottomNavigationBarItemLabel_keypad",
          "icon": "0xe1ce"
        },
        {
          "enabled": false,
          "initial": false,
          "type": "embedded1",
          "titleL10n": "embaded1TitleL10n",
          "icon": "0xe2ce",
          "data": {
            "url": "https://webtrit-app.web.app/example/example_embedded_advertisement.html"
          }
        },
        {
          "enabled": false,
          "initial": false,
          "type": "embedded2",
          "titleL10n": "embaded2TitleL10n",
          "icon": "0xe2ce",
          "data": {
            "url": "https://webtrit-app.web.app/example/example_embedded_call.html"
          }
        },
        {
          "enabled": false,
          "initial": false,
          "type": "embedded3",
          "titleL10n": "embaded3TitleL10n",
          "icon": "0xe2ce",
          "data": {
            "url": "https://webtrit-app.web.app/example/example_embedded_wallet_balance.html"
          }
        }
      ]
    }
  }
}
```

### Properties

- **`cacheSelectedTab`**: A boolean value indicating whether the selected tab should be cached.
- **`tabs`**: An array of objects representing each tab in the bottom menu.

    - **`enabled`**: A boolean value specifying whether the tab is enabled.
    - **`initial`**: A boolean value indicating whether this tab should be initially selected.
    - **`type`**: A string representing the type of the tab (e.g., "favorites", "recents", "contacts", "keypad", "
      embedded1", "embedded2", "embedded3").
    - **`titleL10n`**: A string representing the localization key for the tab's title.
    - **`icon`**: A string representing the icon for the tab in hexadecimal format.
    - **`data`**: An object containing the URL for embedded types.

## Configuring the Bottom Menu

To configure the bottom menu in your app, update the JSON configuration with the desired properties for each tab. The
configuration file should be placed in the following directory:

```
webtrit_phone/assets/themes/original.ui.compose.config.json
```

**The bottom menu will be displayed on the screen in the order of tabs listed in the configuration.** This means that
the appearance and arrangement of the tabs will follow the sequence provided in the JSON structure.

## Summary

- The bottom menu configuration includes properties for caching selected tabs and defining the tabs themselves.
- Each tab can be enabled or disabled, and can be set as initially selected.
- The configuration specifies localization keys for tab titles and icons in hexadecimal format.
- The embedded tabs provide a URL for displaying web content within the app.
- The bottom menu will display tabs in the order they are listed in the JSON configuration.
