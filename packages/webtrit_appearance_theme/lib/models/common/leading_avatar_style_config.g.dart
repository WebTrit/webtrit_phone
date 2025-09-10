// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leading_avatar_style_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeadingAvatarStyleConfigImpl _$$LeadingAvatarStyleConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$LeadingAvatarStyleConfigImpl(
      backgroundColor: json['backgroundColor'] as String?,
      radius: (json['radius'] as num?)?.toDouble(),
      initialsTextStyle: json['initialsTextStyle'] == null
          ? null
          : TextStyleConfig.fromJson(
              json['initialsTextStyle'] as Map<String, dynamic>),
      placeholderIcon: json['placeholderIcon'] == null
          ? null
          : IconDataConfig.fromJson(
              json['placeholderIcon'] as Map<String, dynamic>),
      loading: json['loading'] == null
          ? null
          : LoadingOverlayStyleConfig.fromJson(
              json['loading'] as Map<String, dynamic>),
      smartIndicator: json['smartIndicator'] == null
          ? null
          : SmartIndicatorStyleConfig.fromJson(
              json['smartIndicator'] as Map<String, dynamic>),
      registeredBadge: json['registeredBadge'] == null
          ? null
          : RegisteredBadgeStyleConfig.fromJson(
              json['registeredBadge'] as Map<String, dynamic>),
      presenceBadge: json['presenceBadge'] == null
          ? null
          : PresenceBadgeStyleConfig.fromJson(
              json['presenceBadge'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LeadingAvatarStyleConfigImplToJson(
        _$LeadingAvatarStyleConfigImpl instance) =>
    <String, dynamic>{
      'backgroundColor': instance.backgroundColor,
      'radius': instance.radius,
      'initialsTextStyle': instance.initialsTextStyle?.toJson(),
      'placeholderIcon': instance.placeholderIcon?.toJson(),
      'loading': instance.loading?.toJson(),
      'smartIndicator': instance.smartIndicator?.toJson(),
      'registeredBadge': instance.registeredBadge?.toJson(),
      'presenceBadge': instance.presenceBadge?.toJson(),
    };

_$LoadingOverlayStyleConfigImpl _$$LoadingOverlayStyleConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$LoadingOverlayStyleConfigImpl(
      showByDefault: json['showByDefault'] as bool? ?? false,
      padding: json['padding'] == null
          ? PaddingConfig.default2
          : PaddingConfig.fromJson(json['padding'] as Map<String, dynamic>),
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$LoadingOverlayStyleConfigImplToJson(
        _$LoadingOverlayStyleConfigImpl instance) =>
    <String, dynamic>{
      'showByDefault': instance.showByDefault,
      'padding': instance.padding,
      'strokeWidth': instance.strokeWidth,
    };

_$SmartIndicatorStyleConfigImpl _$$SmartIndicatorStyleConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$SmartIndicatorStyleConfigImpl(
      backgroundColor: json['backgroundColor'] as String?,
      icon: json['icon'] == null
          ? null
          : IconDataConfig.fromJson(json['icon'] as Map<String, dynamic>),
      sizeFactor: (json['sizeFactor'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$SmartIndicatorStyleConfigImplToJson(
        _$SmartIndicatorStyleConfigImpl instance) =>
    <String, dynamic>{
      'backgroundColor': instance.backgroundColor,
      'icon': instance.icon,
      'sizeFactor': instance.sizeFactor,
    };

_$RegisteredBadgeStyleConfigImpl _$$RegisteredBadgeStyleConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$RegisteredBadgeStyleConfigImpl(
      registeredColor: json['registeredColor'] as String?,
      unregisteredColor: json['unregisteredColor'] as String?,
      sizeFactor: (json['sizeFactor'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$RegisteredBadgeStyleConfigImplToJson(
        _$RegisteredBadgeStyleConfigImpl instance) =>
    <String, dynamic>{
      'registeredColor': instance.registeredColor,
      'unregisteredColor': instance.unregisteredColor,
      'sizeFactor': instance.sizeFactor,
    };

_$PresenceBadgeStyleConfigImpl _$$PresenceBadgeStyleConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$PresenceBadgeStyleConfigImpl(
      availableColor: json['availableColor'] as String?,
      unavailableColor: json['unavailableColor'] as String?,
      sizeFactor: (json['sizeFactor'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$PresenceBadgeStyleConfigImplToJson(
        _$PresenceBadgeStyleConfigImpl instance) =>
    <String, dynamic>{
      'availableColor': instance.availableColor,
      'unavailableColor': instance.unavailableColor,
      'sizeFactor': instance.sizeFactor,
    };
