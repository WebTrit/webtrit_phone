// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_compose_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UiComposeSettingsImpl _$$UiComposeSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$UiComposeSettingsImpl(
      bottomMenuTabs: (json['bottomMenuTabs'] as List<dynamic>)
          .map((e) => UiComposeSettingsBottomMenuTabs.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$UiComposeSettingsImplToJson(
        _$UiComposeSettingsImpl instance) =>
    <String, dynamic>{
      'bottomMenuTabs': instance.bottomMenuTabs,
    };

_$UiComposeSettingsBottomMenuTabsImpl
    _$$UiComposeSettingsBottomMenuTabsImplFromJson(Map<String, dynamic> json) =>
        _$UiComposeSettingsBottomMenuTabsImpl(
          title: json['title'] as String,
          icon: const IconDataConverter().fromJson(json['icon'] as String),
          type: json['type'] as String,
          initial: json['initial'] as bool? ?? false,
          data: json['data'] == null
              ? null
              : UiComposeSettingsBottomMenuTabsData.fromJson(
                  json['data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$UiComposeSettingsBottomMenuTabsImplToJson(
        _$UiComposeSettingsBottomMenuTabsImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'icon': const IconDataConverter().toJson(instance.icon),
      'type': instance.type,
      'initial': instance.initial,
      'data': instance.data,
    };

_$UiComposeSettingsBottomMenuTabsDataImpl
    _$$UiComposeSettingsBottomMenuTabsDataImplFromJson(
            Map<String, dynamic> json) =>
        _$UiComposeSettingsBottomMenuTabsDataImpl(
          url: json['url'] as String,
        );

Map<String, dynamic> _$$UiComposeSettingsBottomMenuTabsDataImplToJson(
        _$UiComposeSettingsBottomMenuTabsDataImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
    };
