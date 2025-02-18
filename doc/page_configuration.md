# Setup Special Page Configuration

## Table of Contents

- [Login Page](#login-page)
- [About Page](#about-page)

The special pages in the application include the login and about pages, each with configurable properties.

#### Login Page

The login page configuration includes:

- `picture`: URL or asset reference for the login page image
- `scale`: Scaling factor for the login page image
- `labelColor`: Color of the labels on the login page
- `modeSelect`: Configures login and signup button styles
    - `buttonLoginStyleType`: Style for the login button (e.g., primary, neutral)
    - `buttonSignupStyleType`: Style for the signup button (e.g., primary, neutral)
- `metadata`: Additional metadata that can be used to associate external resources

**Example Configuration:**

```json
{
  "picture": "asset://assets/login_background.png",
  "scale": 1.2,
  "labelColor": "#FFFFFF",
  "modeSelect": {
    "buttonLoginStyleType": "primary",
    "buttonSignupStyleType": "neutral"
  },
  "metadata": {}
}
```

#### About Page

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
