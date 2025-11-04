// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_field_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TextFieldConfigImpl _$$TextFieldConfigImplFromJson(
  Map<String, dynamic> json,
) => _$TextFieldConfigImpl(
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
);

Map<String, dynamic> _$$TextFieldConfigImplToJson(
  _$TextFieldConfigImpl instance,
) => <String, dynamic>{
  'decoration': instance.decoration?.toJson(),
  'style': instance.style?.toJson(),
  'textAlign': instance.textAlign,
  'showCursor': instance.showCursor,
  'keyboardType': instance.keyboardType,
};
