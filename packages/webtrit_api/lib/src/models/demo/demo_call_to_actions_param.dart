// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'demo_call_to_actions_param.freezed.dart';

part 'demo_call_to_actions_param.g.dart';

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class DemoCallToActionsParam with _$DemoCallToActionsParam {
  const DemoCallToActionsParam({required this.email, required this.tab});

  @override
  final String email;

  @override
  final String tab;

  factory DemoCallToActionsParam.fromJson(Map<String, dynamic> json) =>
      _$DemoCallToActionsParamFromJson(json);

  Map<String, dynamic> toJson() => _$DemoCallToActionsParamToJson(this);
}
