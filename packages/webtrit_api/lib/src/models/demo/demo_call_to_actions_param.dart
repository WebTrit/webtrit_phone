import 'package:freezed_annotation/freezed_annotation.dart';

part 'demo_call_to_actions_param.freezed.dart';

part 'demo_call_to_actions_param.g.dart';

@freezed
class DemoCallToActionsParam with _$DemoCallToActionsParam {
  factory DemoCallToActionsParam({
    required String email,
    required String tab,
  }) = _DemoCallToActionsParam;

  factory DemoCallToActionsParam.fromJson(Map<String, dynamic> json) => _$DemoCallToActionsParamFromJson(json);
}
