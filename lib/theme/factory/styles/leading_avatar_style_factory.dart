import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/models.dart';
import 'package:webtrit_phone/theme/extension/extension.dart';
import 'package:webtrit_phone/theme/styles/styles.dart';

import '../theme_style_factory.dart';

class LeadingAvatarStyleFactory implements ThemeStyleFactory<LeadingAvatarStyles> {
  LeadingAvatarStyleFactory(this.colors, this.config, this.defaultFontFamily);

  final ColorScheme colors;
  final LeadingAvatarStyleConfig? config;
  final String? defaultFontFamily;

  @override
  LeadingAvatarStyles create() {
    return LeadingAvatarStyles(
      primary: LeadingAvatarStyle(
        backgroundColor: _bgColor(),
        radius: config?.radius,
        initialsTextStyle: _mapInitialsTextStyle(config?.initialsTextStyle),
        placeholderIcon: null,
        loadingOverlay: _mapLoading(config?.loading),
        smartIndicator: _mapSmart(config?.smartIndicator),
        registeredBadge: _mapRegistered(config?.registeredBadge),
        presenceBadge: _mapPresence(config?.presenceBadge),
        nameColors: _mapNameColors(config?.nameColors),
      ),
    );
  }

  TextStyle? _mapInitialsTextStyle(TextStyleConfig? config) {
    if (config == null) return null;

    return config
        .toTextStyle(defaultFontFamily: defaultFontFamily)
        .copyWith(color: config.color?.toColor() ?? colors.onSecondaryContainer);
  }

  Color _bgColor() => config?.backgroundColor?.toColor() ?? colors.secondaryContainer;

  LoadingOverlayStyle? _mapLoading(LoadingOverlayStyleConfig? c) {
    if (c == null) return null;
    return LoadingOverlayStyle(
      showByDefault: c.showByDefault,
      padding: c.padding.toEdgeInsets(),
      strokeWidth: c.strokeWidth,
    );
  }

  SmartIndicatorStyle? _mapSmart(SmartIndicatorStyleConfig? c) {
    if (c == null) return null;
    return SmartIndicatorStyle(
      backgroundColor: c.backgroundColor?.toColor() ?? colors.surfaceContainerLowest,
      icon: null,
      sizeFactor: c.sizeFactor,
    );
  }

  RegisteredBadgeStyle? _mapRegistered(RegisteredBadgeStyleConfig? c) {
    if (c == null) return null;
    return RegisteredBadgeStyle(
      registeredColor: c.registeredColor?.toColor(),
      unregisteredColor: c.unregisteredColor?.toColor(),
      sizeFactor: c.sizeFactor,
    );
  }

  /// Name-derived colors are on by default: a theme without a `nameColors` block still gets them,
  /// only an explicit `"enabled": false` turns them off.
  NameColorsStyle _mapNameColors(NameColorsStyleConfig? c) {
    if (c == null) return const NameColorsStyle();
    return NameColorsStyle(enabled: c.enabled, palette: c.palette?.map((hex) => hex.toColor()).toList());
  }

  PresenceBadgeStyle? _mapPresence(PresenceBadgeStyleConfig? c) {
    if (c == null) return null;
    return PresenceBadgeStyle(
      availableColor: c.availableColor?.toColor() ?? colors.tertiary,
      unavailableColor: c.unavailableColor?.toColor() ?? colors.onSurfaceVariant,
      sizeFactor: c.sizeFactor,
    );
  }
}
