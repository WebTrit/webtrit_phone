# Setup Special Page Configuration

## Table of Contents

- [Login Page](#login-page)
- [About Page](#about-page)
- [Call Page (Dialing)](#call-page-dialing)

The special pages in the application include the login, about, and call (dialing) pages, each with
configurable properties.

---

### Login Page

The login page configuration includes:

- `picture`: URL or asset reference for the login page image
- `scale`: Scaling factor for the login page image
- `labelColor`: Color of the labels on the login page
- `modeSelect`: Configures login and signup button styles and system UI overlay
    - `systemUiOverlayStyle`: Controls status and navigation bar appearance
        - `statusBarColor`: Background color of the status bar
        - `statusBarIconBrightness`: Brightness of status bar icons (`dark` | `light`)
        - `systemNavigationBarColor`: Background color of navigation bar
        - `systemNavigationBarIconBrightness`: Brightness of nav bar icons (`dark` | `light`)
    - `buttonLoginStyleType`: Style for the login button (e.g., `primary`, `neutral`,
      `neutralOnDark`)
    - `buttonSignupStyleType`: Style for the signup button (e.g., `primary`, `neutral`,
      `neutralOnDark`)
- `metadata`: Additional metadata that can be used to associate external resources

**Example Configuration:**

```json
{
  "picture": "asset://assets/login_background.png",
  "scale": 1.2,
  "labelColor": "#FFFFFF",
  "modeSelect": {
    "systemUiOverlayStyle": {
      "statusBarColor": "#0A0A0A",
      "statusBarIconBrightness": "dark",
      "systemNavigationBarColor": "#0A0A0A",
      "systemNavigationBarIconBrightness": "dark"
    },
    "buttonLoginStyleType": "neutralOnDark",
    "buttonSignupStyleType": "neutralOnDark"
  },
  "metadata": {}
}
```

---

### About Page

The about page configuration includes:

- `picture`: URL or asset reference for the about page image
- `metadata`: Additional metadata for customization

**Example Configuration:**

```json
{
  "picture": "asset://assets/about_background.png",
  "metadata": {}
}
```

---

### Call Page (Dialing)

The call page configuration includes:

- `systemUiOverlayStyle`: Controls status and navigation bar styling
    - `statusBarColor`: Background color of the status bar
    - `statusBarIconBrightness`: Brightness of status bar icons (`dark` | `light`)
    - `systemNavigationBarColor`: Background color of navigation bar
    - `systemNavigationBarIconBrightness`: Brightness of nav bar icons (`dark` | `light`)
- `appBarStyle`: Configures the appearance of the App Bar during a call
    - `backgroundColor`: Background color of the App Bar (hex format)
    - `foregroundColor`: Color for icons and text in the App Bar (hex format)
- `callInfo`: Styling for call information text
    - `usernameTextStyle`: Text style for username
    - `numberTextStyle`: Text style for phone number
    - `callStatusTextStyle`: Text style for call status
    - `processingStatusTextStyle`: Text style for processing status

**Example Configuration:**

```json
{
  "systemUiOverlayStyle": {
    "statusBarColor": "#0A0A0A",
    "statusBarIconBrightness": "dark",
    "systemNavigationBarColor": "#0A0A0A",
    "systemNavigationBarIconBrightness": "dark"
  },
  "appBarStyle": {
    "backgroundColor": "#00000000",
    "foregroundColor": "#EEF3F6"
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
```
