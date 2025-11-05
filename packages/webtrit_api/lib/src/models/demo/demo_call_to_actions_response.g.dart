// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demo_call_to_actions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DemoCallToActionsResponse _$DemoCallToActionsResponseFromJson(
  Map<String, dynamic> json,
) =>
    DemoCallToActionsResponse(
      actions: (json['actions'] as List<dynamic>)
          .map(
            (e) => DemoCallToActionsResponseActions.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
    );

Map<String, dynamic> _$DemoCallToActionsResponseToJson(
  DemoCallToActionsResponse instance,
) =>
    <String, dynamic>{
      'actions': instance.actions.map((e) => e.toJson()).toList(),
    };

DemoCallToActionsResponseActions _$DemoCallToActionsResponseActionsFromJson(
  Map<String, dynamic> json,
) =>
    DemoCallToActionsResponseActions(
      title: json['title'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String,
      extraData: DemoCallToActionsResponseActionsExtraData.fromJson(
        json['extra_data'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$DemoCallToActionsResponseActionsToJson(
  DemoCallToActionsResponseActions instance,
) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'extra_data': instance.extraData.toJson(),
    };

DemoCallToActionsResponseActionsExtraData
    _$DemoCallToActionsResponseActionsExtraDataFromJson(
  Map<String, dynamic> json,
) =>
        DemoCallToActionsResponseActionsExtraData(
          apiToken: json['api_token'] as String,
          tokenExpires: json['token_expires'] as String,
        );

Map<String, dynamic> _$DemoCallToActionsResponseActionsExtraDataToJson(
  DemoCallToActionsResponseActionsExtraData instance,
) =>
    <String, dynamic>{
      'api_token': instance.apiToken,
      'token_expires': instance.tokenExpires,
    };
