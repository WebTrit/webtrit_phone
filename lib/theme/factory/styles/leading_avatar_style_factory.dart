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

  /// The theme is read as overrides only: every method below translates what
  /// the config actually names, and whatever it leaves out is filled in from
  /// [LeadingAvatarStyle.defaults] by the merge - never by a value invented
  /// here or in a widget.
  @override
  LeadingAvatarStyles create() {
    return LeadingAvatarStyles(primary: LeadingAvatarStyle.merge(LeadingAvatarStyle.defaults(colors), _fromConfig()));
  }

  LeadingAvatarStyle? _fromConfig() {
    final config = this.config;
    if (config == null) return null;

    return LeadingAvatarStyle(
      backgroundColor: config.backgroundColor?.toColor(),
      radius: config.radius,
      initialsTextStyle: _mapInitialsTextStyle(config.initialsTextStyle),
      loadingOverlay: _mapLoading(config.loading),
      smartIndicator: _mapSmart(config.smartIndicator),
      registeredBadge: _mapRegistered(config.registeredBadge),
      presenceBadge: _mapPresence(config.presenceBadge),
      nameColors: _mapNameColors(config.nameColors),
    );
  }

  TextStyle? _mapInitialsTextStyle(TextStyleConfig? config) {
    if (config == null) return null;

    return config.toTextStyle(defaultFontFamily: defaultFontFamily).copyWith(color: config.color?.toColor());
  }

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
    return SmartIndicatorStyle(backgroundColor: c.backgroundColor?.toColor(), icon: null, sizeFactor: c.sizeFactor);
  }

  RegisteredBadgeStyle? _mapRegistered(RegisteredBadgeStyleConfig? c) {
    if (c == null) return null;
    return RegisteredBadgeStyle(
      registeredColor: c.registeredColor?.toColor(),
      unregisteredColor: c.unregisteredColor?.toColor(),
      sizeFactor: c.sizeFactor,
    );
  }

  NameColorsStyle? _mapNameColors(NameColorsStyleConfig? c) {
    if (c == null) return null;
    return NameColorsStyle(enabled: c.enabled, palette: c.palette?.map((hex) => hex.toColor()).toList());
  }

  PresenceBadgeStyle? _mapPresence(PresenceBadgeStyleConfig? c) {
    if (c == null) return null;
    return PresenceBadgeStyle(
      availableColor: c.availableColor?.toColor(),
      unavailableColor: c.unavailableColor?.toColor(),
      iconColor: c.iconColor?.toColor(),
      sizeFactor: c.sizeFactor,
    );
  }
}
