// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leading_avatar_style_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadingAvatarStyleConfig _$LeadingAvatarStyleConfigFromJson(
  Map<String, dynamic> json,
) => LeadingAvatarStyleConfig(
  backgroundColor: json['backgroundColor'] as String?,
  radius: (json['radius'] as num?)?.toDouble(),
  initialsTextStyle: json['initialsTextStyle'] == null
      ? null
      : TextStyleConfig.fromJson(
          json['initialsTextStyle'] as Map<String, dynamic>,
        ),
  placeholderIcon: json['placeholderIcon'] == null
      ? null
      : IconDataConfig.fromJson(
          json['placeholderIcon'] as Map<String, dynamic>,
        ),
  loading: json['loading'] == null
      ? null
      : LoadingOverlayStyleConfig.fromJson(
          json['loading'] as Map<String, dynamic>,
        ),
  smartIndicator: json['smartIndicator'] == null
      ? null
      : SmartIndicatorStyleConfig.fromJson(
          json['smartIndicator'] as Map<String, dynamic>,
        ),
  registeredBadge: json['registeredBadge'] == null
      ? null
      : RegisteredBadgeStyleConfig.fromJson(
          json['registeredBadge'] as Map<String, dynamic>,
        ),
  presenceBadge: json['presenceBadge'] == null
      ? null
      : PresenceBadgeStyleConfig.fromJson(
          json['presenceBadge'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$LeadingAvatarStyleConfigToJson(
  LeadingAvatarStyleConfig instance,
) => <String, dynamic>{
  'backgroundColor': instance.backgroundColor,
  'radius': instance.radius,
  'initialsTextStyle': instance.initialsTextStyle?.toJson(),
  'placeholderIcon': instance.placeholderIcon?.toJson(),
  'loading': instance.loading?.toJson(),
  'smartIndicator': instance.smartIndicator?.toJson(),
  'registeredBadge': instance.registeredBadge?.toJson(),
  'presenceBadge': instance.presenceBadge?.toJson(),
};

LoadingOverlayStyleConfig _$LoadingOverlayStyleConfigFromJson(
  Map<String, dynamic> json,
) => LoadingOverlayStyleConfig(
  showByDefault: json['showByDefault'] as bool? ?? false,
  padding: json['padding'] == null
      ? PaddingConfig.default2
      : PaddingConfig.fromJson(json['padding'] as Map<String, dynamic>),
  strokeWidth: (json['strokeWidth'] as num?)?.toDouble(),
);

Map<String, dynamic> _$LoadingOverlayStyleConfigToJson(
  LoadingOverlayStyleConfig instance,
) => <String, dynamic>{
  'showByDefault': instance.showByDefault,
  'padding': instance.padding,
  'strokeWidth': instance.strokeWidth,
};

SmartIndicatorStyleConfig _$SmartIndicatorStyleConfigFromJson(
  Map<String, dynamic> json,
) => SmartIndicatorStyleConfig(
  backgroundColor: json['backgroundColor'] as String?,
  icon: json['icon'] == null
      ? null
      : IconDataConfig.fromJson(json['icon'] as Map<String, dynamic>),
  sizeFactor: (json['sizeFactor'] as num?)?.toDouble(),
);

Map<String, dynamic> _$SmartIndicatorStyleConfigToJson(
  SmartIndicatorStyleConfig instance,
) => <String, dynamic>{
  'backgroundColor': instance.backgroundColor,
  'icon': instance.icon,
  'sizeFactor': instance.sizeFactor,
};

RegisteredBadgeStyleConfig _$RegisteredBadgeStyleConfigFromJson(
  Map<String, dynamic> json,
) => RegisteredBadgeStyleConfig(
  registeredColor: json['registeredColor'] as String?,
  unregisteredColor: json['unregisteredColor'] as String?,
  sizeFactor: (json['sizeFactor'] as num?)?.toDouble(),
);

Map<String, dynamic> _$RegisteredBadgeStyleConfigToJson(
  RegisteredBadgeStyleConfig instance,
) => <String, dynamic>{
  'registeredColor': instance.registeredColor,
  'unregisteredColor': instance.unregisteredColor,
  'sizeFactor': instance.sizeFactor,
};

PresenceBadgeStyleConfig _$PresenceBadgeStyleConfigFromJson(
  Map<String, dynamic> json,
) => PresenceBadgeStyleConfig(
  availableColor: json['availableColor'] as String?,
  unavailableColor: json['unavailableColor'] as String?,
  sizeFactor: (json['sizeFactor'] as num?)?.toDouble(),
);

Map<String, dynamic> _$PresenceBadgeStyleConfigToJson(
  PresenceBadgeStyleConfig instance,
) => <String, dynamic>{
  'availableColor': instance.availableColor,
  'unavailableColor': instance.unavailableColor,
  'sizeFactor': instance.sizeFactor,
};
