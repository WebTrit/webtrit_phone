import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/models.dart';
import 'package:webtrit_phone/theme/extension/extension.dart';
import 'package:webtrit_phone/theme/styles/styles.dart';

import '../theme_style_factory.dart';

class LeadingAvatarStyleFactory implements ThemeStyleFactory<LeadingAvatarStyles> {
  LeadingAvatarStyleFactory(this.colors, this.config);

  final ColorScheme colors;
  final LeadingAvatarStyleConfig? config;

  @override
  LeadingAvatarStyles create() {
    return LeadingAvatarStyles(
      primary: LeadingAvatarStyle(
        backgroundColor: _bgColor(),
        radius: config?.radius,
        initialsTextStyle: config?.initialsTextStyle?.toTextStyle(
          fallbackColor: colors.onSecondaryContainer,
        ),
        placeholderIcon: null,
        loadingOverlay: _mapLoading(config?.loading),
        smartIndicator: _mapSmart(config?.smartIndicator),
        registeredBadge: _mapRegistered(config?.registeredBadge),
        presenceBadge: _mapPresence(config?.presenceBadge),
      ),
    );
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

  PresenceBadgeStyle? _mapPresence(PresenceBadgeStyleConfig? c) {
    if (c == null) return null;
    return PresenceBadgeStyle(
      availableColor: c.availableColor?.toColor() ?? colors.tertiary,
      unavailableColor: c.unavailableColor?.toColor() ?? colors.onSurfaceVariant,
      sizeFactor: c.sizeFactor,
    );
  }
}
