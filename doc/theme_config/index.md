# Custom Style Scheme Mechanism

This document outlines the custom color scheme mechanism implemented in our application. This mechanism enables customization of the base theme and specific component colors, as well as the modification of specific screens.


# Base Scheme

The base scheme sets the foundational colors and default fonts used across the application. It's a mandatory JSON file that establishes default values for various components.

    {
      "seedColor": "#F95A14",
      "lightColorSchemeOverride": {
        "primary": "#F95A14",
        "onPrimary": "#FFFFFF",
        "secondary": "#123752",
        "secondaryContainer": "#EEF3F6",
        "onSecondaryContainer": "#1F618F",
        "tertiary": "#75B943",
        "error": "#E74C3C",
        "outline": "#FFFFFF",
        "background": "#FFFFFF",
        "onBackground": "#30302F",
        "surface": "#EEF3F6",
        "onSurface": "#30302F"
      },
      "primaryGradientColors": [
        {
          "color": "#5CACE3",
          "blend": false
        },
        {
          "color": "#123752",
          "blend": false
        }
      ],
      "fontFamily": "Montserrat",
      "primaryOnboardingLogo": "asset://assets/primary_onboardin_logo.svg",
      "secondaryOnboardingLogo": "asset://assets/secondary_onboardin_logo.svg"
    }

-   `seedColor`: The base color used to generate the color palette.
-   `lightColorSchemeOverride`: A light set of colors for various UI elements.
-   `darkColorSchemeOverride`: A dark  set of colors for various UI elements.
-   `primaryGradientColors`: An optional list of colors for a primary gradient.
-   `fontFamily`: The default font family used throughout the application.
-   `primaryOnboardingLogo`: Path to the primary onboarding logo.
-   `secondaryOnboardingLogo`: Path to the secondary onboarding logo.



# Component Overrides

Component overrides allow for specific customization of individual components within the application. This is achieved through a separate JSON file. If a component override file is not provided, the default config  from the base scheme will be used.

- To add a component config extension to your project, you need to include a JSON object specifying the elements that should be overridden in the file:
	> original.widget.light.config.json
	> original.widget.dark.config.json

Example of a component override file:

    {  
      "button": {  
        "primaryElevatedButton": {  
          "backgroundColor": "#14284b",  
          "foregroundColor": "#FFFFFF",  
          "textColor": null  
      }  
      },  
      "group": {  
        "groupTitleListTile": {  
          "backgroundColor": "#14284b"  
          "textColor": "#FFFFFF"  
      },  
        "callActions": {  
          "callStartBackgroundColor": "#30F91B",  
          "hangupBackgroundColor": "#30F91B",  
          "transferBackgroundColor": "#30F91B",  
          "cameraBackgroundColor": "#30F91B",  
          "cameraActiveBackgroundColor": "#30F91B",  
          "mutedBackgroundColor": "#30F91B",  
          "mutedActiveBackgroundColor": "#30F91B",  
          "speakerBackgroundColor": "#30F91B",  
          "speakerActiveBackgroundColor": "#30F91B",  
          "heldBackgroundColor": "#30F91B",  
          "heldActiveBackgroundColor": "#30F91B",  
          "swapBackgroundColor": "#30F91B",  
          "keyBackgroundColor": "#30F91B",  
          "keypadBackgroundColor": "#30F91B",  
          "keypadActiveBackgroundColor": "#30F91B"  
      }  
      },  
      "bar": {  
        "bottomNavigationBar": {  
          "backgroundColor": "#14284b",  
          "selectedItemColor": "#FFFFFF",  
          "unSelectedItemColor": "#BCBCBC"  
      },  
        "extTabBar": {  
          "backgroundColor": "#14284b",  
          "foregroundColor": "#FFFFFF",  
          "selectedItemColor": "#FFFFFF",  
          "unSelectedItemColor": "#BCBCBC"  
      }  
      },  
      "picture": {  
        "onboardingPictureLogo": {  
          "scale": 0.42,  
          "labelColor": "#FFFFFF"  
      },  
        "onboardingLogo": {  
          "scale": 0.25,  
          "labelColor": "#FFFFFF"  
      },  
        "appIcon": {  
          "color": "#30F91B"  
      }  
      },  
      "input": {  
        "primary": {  
          "labelColor": "#14284b",  
          "border": {  
            "disabled": {  
              "typicalColor": "#14284b",  
              "errorColor": null  
      },  
            "focused": {  
              "typicalColor": "#14284b",  
              "errorColor": null  
      },  
            "any": {  
              "typicalColor": "#14284b",  
              "errorColor": null  
      }  
          }  
        }  
      },  
      "text": {  
        "selection": {  
          "cursorColor": "#14284b",  
          "selectionColor": "#14284b33",  
          "selectionHandleColor": "#14284b33"  
      },  
        "linkify": {  
          "styleColor": "#30F91B",  
          "linkifyStyleColor": "#14284b"  
      }  
      },  
      "dialog": {  
        "confirmDialog": {  
          "activeButtonColor1": "#30F91B",  
          "activeButtonColor2": "#8045F9",  
          "defaultButtonColor": "#F90013"  
      }  
      }  
    }

### primaryElevatedButton

> Overid **primary** component which used for default application style button
> - **primary**: *~~not implemented~~*
> - neutral: *not implemented*
> - primaryOnDark: *not implemented*
> - neutralOnDark:  *not implemented*,
-   `backgroundColor`: Button background color.
-   `foregroundColor`:  Button foregroun color.
-   `textColor`: Text cololr

### groupTitleListTile

> A widget commonly used for general purposes to organize and group multiple elements.
-   `backgroundColor`: Widget background color.
-   `textColor`: Text color.

### callActions

> Represents various call action buttons in the user interface on call screen.

-   `callStartBackgroundColor`: Background color for the call start button.
-   `hangupBackgroundColor`: Background color for the hang-up button.
-   `transferBackgroundColor`: Background color for the transfer button.
-   `cameraBackgroundColor`: Background color for the camera button.
-   `cameraActiveBackgroundColor`: Background color for the active camera button.
-   `mutedBackgroundColor`: Background color for the muted button.
-   `mutedActiveBackgroundColor`: Background color for the active muted button.
-   `speakerBackgroundColor`: Background color for the speaker button.
-   `speakerActiveBackgroundColor`: Background color for the active speaker button.
-   `heldBackgroundColor`: Background color for the held call button.
-   `heldActiveBackgroundColor`: Background color for the active held call button.
-   `swapBackgroundColor`: Background color for the swap button.
-   `keyBackgroundColor`: Background color for the key button.
-   `keypadBackgroundColor`: Background color for the keypad button.
-   `keypadActiveBackgroundColor`: Background color for the active keypad button.

### bottomNavigationBar

> Defines the appearance of the bottom navigation bar.

-   `backgroundColor`: Background color of the bottom navigation bar.
-   `selectedItemColor`: Color of the selected item in the bottom navigation bar.
-   `unSelectedItemColor`: Color of unselected items in the bottom navigation bar.

### extTabBar

> Extends the functionality of the tab bar with additional customization options.

-   `backgroundColor`: Background color of the extended tab bar.
-   `foregroundColor`: Foreground color of the extended tab bar.
-   `selectedItemColor`: Color of the selected item in the extended tab bar.
-   `unSelectedItemColor`: Color of unselected items in the extended tab bar.

### onboardingPictureLogo

> Configures the appearance of the logo in the onboarding picture.

  -   `scale`: Scaling factor for the logo, calculated as the width of the screen multiplied by the local style's scale factor (if available, otherwise defaulting to 0.42).
-   `labelColor`: Color of the label associated with the logo.

### onboardingLogo

> Configures the appearance of the logo in the onboarding section.

-   `scale`: Scaling factor for the logo, calculated as the height of the screen multiplied by the local style's scale factor (if available, otherwise defaulting to 0.25).
-   `labelColor`: Color of the label associated with the logo.

### appIcon

> Defines the color of the application icon.

-   `color`: Color of the application icon.

### primary

> Defines primary input field styles.

-   `labelColor`: Color of the input field label.
-   `border`:
    -   `disabled`:
        -   `typicalColor`: Border color for disabled state.
        -   `errorColor`: Border color for disabled state with an error.
    -   `focused`:
        -   `typicalColor`: Border color for focused state.
        -   `errorColor`: Border color for focused state with an error.
    -   `any`:
        -   `typicalColor`: Default border color.
        -   `errorColor`: Border color for any state with an error.

### selection

> Defines styles for text selection.

-   `cursorColor`: Color of the text cursor.
-   `selectionColor`: Color of the text selection.
-   `selectionHandleColor`: Color of the text selection handle.

### linkify

> Styles for linkified text.

-   `styleColor`: Color of the link style.
-   `linkifyStyleColor`: Color of the linkified text style.

### confirmDialog

> Represents a confirmation dialog with customizable button colors.

-   `activeButtonColor1`: Color of the first active button.
-   `activeButtonColor2`: Color of the second active button.
-   `defaultButtonColor`: Default color for buttons.

# Page-Specific Overrides

Page-specific overrides allow for further customization on a per-page basis. This is achieved through another separate JSON file. It provides a way to modify specific aspects of a page's appearance.

- To add a page config extension to your project, you need to include a JSON object specifying the elements that should be overridden in the file:
	> original.page.light.config.json
	> original.page.dark.config.json

Example of a component override file:

    {
      "login": {
        "modeSelect": {
          "buttonLoginStyleType": "primaryOnDark",
          "buttonSignupStyleType": "primaryOnDark"
        }
      },
      "about": {
        "picture": "asset://assets/secondary_onboardin_logo.svg"
      }
    }



-   In the `login` page example, button styles are overridden using predefined styles likely defined elsewhere in your system.
-   In the `about` page example, the path to the displayed logo is overridden.

### modeSelect

> Contains styles related to the login process.
-   `buttonLoginStyleType`: Style type for the login button, set to "primaryOnDark".
-   `buttonSignupStyleType`:Style type for the signup button, set to "primaryOnDark".

### about

> Contains information related to the about section.

-   `picture`: Path to the secondary onboarding logo image, located at "asset://assets/secondary_onboardin_logo.svg".
