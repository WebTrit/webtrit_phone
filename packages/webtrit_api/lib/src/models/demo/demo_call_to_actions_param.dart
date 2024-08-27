// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'demo_call_to_actions_param.freezed.dart';

part 'demo_call_to_actions_param.g.dart';

@freezed
class DemoCallToActionsParam with _$DemoCallToActionsParam {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory DemoCallToActionsParam({
    required String email,
    required String tab,
  }) = _DemoCallToActionsParam;

  factory DemoCallToActionsParam.fromJson(Map<String, dynamic> json) => _$DemoCallToActionsParamFromJson(json);
}
