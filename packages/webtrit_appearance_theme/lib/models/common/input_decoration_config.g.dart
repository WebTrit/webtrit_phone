// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'input_decoration_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InputDecorationConfig _$InputDecorationConfigFromJson(
  Map<String, dynamic> json,
) =>
    InputDecorationConfig(
      hintText: json['hintText'] as String?,
      hintStyle: json['hintStyle'] == null
          ? null
          : TextStyleConfig.fromJson(json['hintStyle'] as Map<String, dynamic>),
      labelText: json['labelText'] as String?,
      labelStyle: json['labelStyle'] == null
          ? null
          : TextStyleConfig.fromJson(
              json['labelStyle'] as Map<String, dynamic>),
      helperText: json['helperText'] as String?,
      helperStyle: json['helperStyle'] == null
          ? null
          : TextStyleConfig.fromJson(
              json['helperStyle'] as Map<String, dynamic>),
      errorStyle: json['errorStyle'] == null
          ? null
          : TextStyleConfig.fromJson(
              json['errorStyle'] as Map<String, dynamic>),
      prefixText: json['prefixText'] as String?,
      prefixStyle: json['prefixStyle'] == null
          ? null
          : TextStyleConfig.fromJson(
              json['prefixStyle'] as Map<String, dynamic>),
      suffixText: json['suffixText'] as String?,
      suffixStyle: json['suffixStyle'] == null
          ? null
          : TextStyleConfig.fromJson(
              json['suffixStyle'] as Map<String, dynamic>),
      fillColor: json['fillColor'] as String?,
      filled: json['filled'] as bool?,
      border: json['border'] == null
          ? null
          : BorderConfig.fromJson(json['border'] as Map<String, dynamic>),
      enabledBorder: json['enabledBorder'] == null
          ? null
          : BorderConfig.fromJson(
              json['enabledBorder'] as Map<String, dynamic>),
      focusedBorder: json['focusedBorder'] == null
          ? null
          : BorderConfig.fromJson(
              json['focusedBorder'] as Map<String, dynamic>),
      errorBorder: json['errorBorder'] == null
          ? null
          : BorderConfig.fromJson(json['errorBorder'] as Map<String, dynamic>),
      focusedErrorBorder: json['focusedErrorBorder'] == null
          ? null
          : BorderConfig.fromJson(
              json['focusedErrorBorder'] as Map<String, dynamic>,
            ),
      disabledBorder: json['disabledBorder'] == null
          ? null
          : BorderConfig.fromJson(
              json['disabledBorder'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InputDecorationConfigToJson(
  InputDecorationConfig instance,
) =>
    <String, dynamic>{
      'hintText': instance.hintText,
      'hintStyle': instance.hintStyle?.toJson(),
      'labelText': instance.labelText,
      'labelStyle': instance.labelStyle?.toJson(),
      'helperText': instance.helperText,
      'helperStyle': instance.helperStyle?.toJson(),
      'errorStyle': instance.errorStyle?.toJson(),
      'prefixText': instance.prefixText,
      'prefixStyle': instance.prefixStyle?.toJson(),
      'suffixText': instance.suffixText,
      'suffixStyle': instance.suffixStyle?.toJson(),
      'fillColor': instance.fillColor,
      'filled': instance.filled,
      'border': instance.border?.toJson(),
      'enabledBorder': instance.enabledBorder?.toJson(),
      'focusedBorder': instance.focusedBorder?.toJson(),
      'errorBorder': instance.errorBorder?.toJson(),
      'focusedErrorBorder': instance.focusedErrorBorder?.toJson(),
      'disabledBorder': instance.disabledBorder?.toJson(),
    };

BorderConfig _$BorderConfigFromJson(Map<String, dynamic> json) => BorderConfig(
      type: json['type'] as String? ?? 'underline',
      borderRadius: (json['borderRadius'] as num?)?.toDouble(),
      borderColor: json['borderColor'] as String?,
      borderWidth: (json['borderWidth'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$BorderConfigToJson(BorderConfig instance) =>
    <String, dynamic>{
      'type': instance.type,
      'borderRadius': instance.borderRadius,
      'borderColor': instance.borderColor,
      'borderWidth': instance.borderWidth,
    };
