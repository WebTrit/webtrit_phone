import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_api/webtrit_api.dart';

part 'demo_actions.freezed.dart';

@Freezed(copyWith: false)
class DemoActions with _$DemoActions {
  const DemoActions._();

  factory DemoActions.complete(List<DemoCallToActionsResponseActions> action) = _DemoActionsComplete;

  factory DemoActions.incomplete(List<DemoCallToActionsResponseActions> action) = _DemoActionsIncomplete;

  bool get isComplete => this is _DemoActionsComplete;

  bool get isIncomplete => this is _DemoActionsIncomplete;
}
