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
      inputValue: json['inputValue'] == null
          ? null
          : InputValueConfig.fromJson(
              json['inputValue'] as Map<String, dynamic>,
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
      'inputValue': instance.inputValue?.toJson(),
    };

InputValueConfig _$InputValueConfigFromJson(Map<String, dynamic> json) =>
    InputValueConfig(
      includePrefixInData: json['includePrefixInData'] as bool?,
      initialValue: json['initialValue'] as String?,
    );

Map<String, dynamic> _$InputValueConfigToJson(InputValueConfig instance) =>
    <String, dynamic>{
      'includePrefixInData': instance.includePrefixInData,
      'initialValue': instance.initialValue,
    };
