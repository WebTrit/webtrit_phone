part of 'call_id_cubit.dart';

sealed class CallIdState {
  CallIdState();

  factory CallIdState.initializing({Exception? error}) = CallIdStateInitializing;
  factory CallIdState.common({bool enabled, List<String> available, String? selected}) = CallIdStateCommon;
}

final class CallIdStateInitializing extends CallIdState with EquatableMixin {
  final Exception? error;

  CallIdStateInitializing({this.error});

  @override
  List<Object?> get props => [error];

  @override
  bool get stringify => true;
}

final class CallIdStateCommon extends CallIdState with EquatableMixin {
  final bool enabled;
  final List<String> available;
  final String? selected;

  CallIdStateCommon({
    this.enabled = false,
    this.available = const [],
    this.selected,
  });

  @override
  List<Object?> get props => [enabled, available, selected];

  @override
  bool get stringify => true;

  CallIdStateCommon copyWithEnabled(bool enabled) {
    return CallIdStateCommon(enabled: enabled, available: available, selected: selected);
  }

  CallIdStateCommon copyWithSelected(String? selected) {
    return CallIdStateCommon(enabled: enabled, available: available, selected: selected);
  }
}
