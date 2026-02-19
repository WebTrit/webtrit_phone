# Color Scheme Description

This document outlines the application's color system, which is based on Material 3. It defines the
base color roles
used to build the `ThemeData` and explains how these colors interact with other theme
configurations.

## Table of Contents

- [Overview](#overview)
- [Configuration Files](#configuration-files)
- [Base Color Roles](#base-color-roles)
- [Usage](#usage)
- [Reference](#reference)

---

## Overview

The application uses a dynamic color scheme derived from a single **seed color**. This seed
generates a full tonal
palette for primary, secondary, tertiary, and other color roles, ensuring a consistent and
harmonious UI. The generated
scheme can be overridden with specific color values for fine-grained control.

---

## Configuration Files

The base color scheme is defined in the following files:

- `original.color_scheme.dark.config.json` - Dark mode configuration
- `original.color_scheme.light.config.json` - Light mode configuration

---

## Base Color Roles

The color scheme is based on the Material 3 color system. The roles below are generated from a *
*Seed Color**
of `#F95A14` and then overridden with the specified values.

| Role                           | Color     |
|:-------------------------------|:----------|
| **Primary**                    | `#5CACE3` |
| **On Primary**                 | `#FFFFFF` |
| **Primary Container**          | `#B9E3F9` |
| **On Primary Container**       | `#123752` |
| **Primary Fixed**              | `#A5C6E4` |
| **Primary Fixed Dim**          | `#75A1C5` |
| **On Primary Fixed**           | `#092D4A` |
| **On Primary Fixed Variant**   | `#A5C6E4` |
| **Secondary**                  | `#123752` |
| **On Secondary**               | `#FFFFFF` |
| **Secondary Container**        | `#EEF3F6` |
| **On Secondary Container**     | `#1F618F` |
| **Secondary Fixed**            | `#848581` |
| **Secondary Fixed Dim**        | `#4C4D4A` |
| **On Secondary Fixed**         | `#30302F` |
| **On Secondary Fixed Variant** | `#848581` |
| **Tertiary**                   | `#75B943` |
| **On Tertiary**                | `#FFFFFF` |
| **Tertiary Container**         | `#E1F7C1` |
| **On Tertiary Container**      | `#2E5200` |
| **Tertiary Fixed**             | `#B8E078` |
| **Tertiary Fixed Dim**         | `#8CC14E` |
| **On Tertiary Fixed**          | `#224400` |
| **On Tertiary Fixed Variant**  | `#B8E078` |
| **Error**                      | `#E74C3C` |
| **On Error**                   | `#FFFFFF` |
| **Error Container**            | `#F5B7B1` |
| **On Error Container**         | `#8B1E13` |
| **Outline**                    | `#4C4D4A` |
| **Outline Variant**            | `#CDCFC9` |
| **Surface**                    | `#EEF3F6` |
| **On Surface**                 | `#30302F` |
| **Surface Dim**                | `#DDE0E3` |
| **Surface Bright**             | `#FFFFFF` |
| **Surface Container Lowest**   | `#F8FBFD` |
| **Surface Container Low**      | `#F0F3F5` |
| **Surface Container**          | `#EEF3F6` |
| **Surface Container High**     | `#E2E6E9` |
| **Surface Container Highest**  | `#DDE0E3` |
| **On Surface Variant**         | `#848581` |
| **Inverse Surface**            | `#30302F` |
| **On Inverse Surface**         | `#EEF3F6` |
| **Inverse Primary**            | `#1F618F` |
| **Shadow**                     | `#000000` |
| **Scrim**                      | `#000000` |
| **Surface Tint**               | `#F95A14` |

---

## Usage

These color roles form the foundation of the app's `ThemeData`. Most standard Flutter widgets will
automatically adapt
to these colors.

However, for more specific styling, the colors of individual components can be customized via other
configuration
files, such as `widgets_configuration.md`. When a color is hardcoded in a widget's configuration (
e.g.,
`"backgroundColor": "#75B943"`), it will take precedence over the base theme color. This allows for
both broad,
theme-based styling and fine-tuned, component-specific overrides.

---

## Reference

- [Material 3 Color Roles](https://m3.material.io/styles/color/roles/color-roles)

