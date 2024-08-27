// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demo_call_to_actions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DemoCallToActionsResponseImpl _$$DemoCallToActionsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$DemoCallToActionsResponseImpl(
      actions: (json['actions'] as List<dynamic>)
          .map((e) => DemoCallToActionsResponseActions.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DemoCallToActionsResponseImplToJson(
        _$DemoCallToActionsResponseImpl instance) =>
    <String, dynamic>{
      'actions': instance.actions,
    };

_$DemoCallToActionsResponseActionsImpl
    _$$DemoCallToActionsResponseActionsImplFromJson(
            Map<String, dynamic> json) =>
        _$DemoCallToActionsResponseActionsImpl(
          title: json['title'] as String?,
          description: json['description'] as String?,
          url: json['url'] as String,
          extraData: DemoCallToActionsResponseActionsExtraData.fromJson(
              json['extra_data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$DemoCallToActionsResponseActionsImplToJson(
        _$DemoCallToActionsResponseActionsImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'extra_data': instance.extraData,
    };

_$DemoCallToActionsResponseActionsExtraDataImpl
    _$$DemoCallToActionsResponseActionsExtraDataImplFromJson(
            Map<String, dynamic> json) =>
        _$DemoCallToActionsResponseActionsExtraDataImpl(
          apiToken: json['api_token'] as String,
          tokenExpires: json['token_expires'] as String,
        );

Map<String, dynamic> _$$DemoCallToActionsResponseActionsExtraDataImplToJson(
        _$DemoCallToActionsResponseActionsExtraDataImpl instance) =>
    <String, dynamic>{
      'api_token': instance.apiToken,
      'token_expires': instance.tokenExpires,
    };
