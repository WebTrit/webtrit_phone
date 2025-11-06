// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_bar_style_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppBarStyleConfig _$AppBarStyleConfigFromJson(Map<String, dynamic> json) => AppBarStyleConfig(
  backgroundColor: json['backgroundColor'] as String?,
  foregroundColor: json['foregroundColor'] as String?,
  primary: json['primary'] as bool? ?? true,
  showBackButton: json['showBackButton'] as bool? ?? true,
);

Map<String, dynamic> _$AppBarStyleConfigToJson(AppBarStyleConfig instance) => <String, dynamic>{
  'backgroundColor': instance.backgroundColor,
  'foregroundColor': instance.foregroundColor,
  'primary': instance.primary,
  'showBackButton': instance.showBackButton,
};
