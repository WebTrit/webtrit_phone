// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'demo_call_to_actions_response.freezed.dart';

part 'demo_call_to_actions_response.g.dart';

@unfreezed
class DemoCallToActionsResponse with _$DemoCallToActionsResponse {
  factory DemoCallToActionsResponse({
    required List<DemoCallToActionsResponseActions> actions,
  }) = _DemoCallToActionsResponse;

  factory DemoCallToActionsResponse.fromJson(Map<String, dynamic> json) => _$DemoCallToActionsResponseFromJson(json);
}

@unfreezed
class DemoCallToActionsResponseActions with _$DemoCallToActionsResponseActions {
  factory DemoCallToActionsResponseActions({
    required String description,
    @JsonKey(name: 'extra_data') required DemoCallToActionsResponseActionsExtraData extraData,
    required String title,
    required String url,
  }) = _DemoCallToActionsResponseActions;

  factory DemoCallToActionsResponseActions.fromJson(Map<String, dynamic> json) =>
      _$DemoCallToActionsResponseActionsFromJson(json);
}

@unfreezed
class DemoCallToActionsResponseActionsExtraData with _$DemoCallToActionsResponseActionsExtraData {
  factory DemoCallToActionsResponseActionsExtraData({
    @JsonKey(name: 'api_token') required String apiToken,
    @JsonKey(name: 'token_expires') required String tokenExpires,
  }) = _DemoCallToActionsResponseActionsExtraData;

  factory DemoCallToActionsResponseActionsExtraData.fromJson(Map<String, dynamic> json) =>
      _$DemoCallToActionsResponseActionsExtraDataFromJson(json);
}
