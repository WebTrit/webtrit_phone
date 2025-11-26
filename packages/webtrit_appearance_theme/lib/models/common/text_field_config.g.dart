// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_field_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextFieldConfig _$TextFieldConfigFromJson(Map<String, dynamic> json) =>
    TextFieldConfig(
      decoration: json['decoration'] == null
          ? null
          : InputDecorationConfig.fromJson(
              json['decoration'] as Map<String, dynamic>,
            ),
      style: json['style'] == null
          ? null
          : TextStyleConfig.fromJson(json['style'] as Map<String, dynamic>),
      textAlign: json['textAlign'] as String? ?? 'center',
      showCursor: json['showCursor'] as bool? ?? true,
      keyboardType: json['keyboardType'] as String? ?? 'none',
      mask: json['mask'] == null
          ? null
          : MaskConfig.fromJson(json['mask'] as Map<String, dynamic>),
      behavior: json['behavior'] == null
          ? null
          : InputBehaviorConfig.fromJson(
              json['behavior'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$TextFieldConfigToJson(TextFieldConfig instance) =>
    <String, dynamic>{
      'decoration': instance.decoration?.toJson(),
      'style': instance.style?.toJson(),
      'textAlign': instance.textAlign,
      'showCursor': instance.showCursor,
      'keyboardType': instance.keyboardType,
      'mask': instance.mask?.toJson(),
      'behavior': instance.behavior?.toJson(),
    };

InputBehaviorConfig _$InputBehaviorConfigFromJson(Map<String, dynamic> json) =>
    InputBehaviorConfig(
      includePrefixInData: json['includePrefixInData'] as bool?,
    );

Map<String, dynamic> _$InputBehaviorConfigToJson(
  InputBehaviorConfig instance,
) => <String, dynamic>{'includePrefixInData': instance.includePrefixInData};
