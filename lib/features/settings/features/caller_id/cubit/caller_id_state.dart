part of 'caller_id_cubit.dart';

final class CallerIDSettingsState with EquatableMixin {
  /// Whether the caller ID should be shown or not
  /// false means the caller ID is hidden on outgoing calls
  /// according to https://datatracker.ietf.org/doc/html/rfc3323#section-4.1.1.3
  final bool showID;

  /// The selected caller ID for overriding on outgoing calls
  /// Null means default caller ID is used, aka no override
  final String? selectedID;

  /// The default caller ID for the user
  final String defaultID;

  /// List of available caller IDs for that user
  final List<String> availableIDs;

  CallerIDSettingsState._(this.showID, this.selectedID, this.defaultID, this.availableIDs);

  @override
  List<Object?> get props => [showID, selectedID, defaultID, availableIDs];

  @override
  String toString() {
    return 'CallerIDState(showID: $showID, selectedID: $selectedID, defaultID: $defaultID, availableIDs: $availableIDs)';
  }

  factory CallerIDSettingsState.initWithPrefs(AppPreferences appPreferences) {
    final showID = appPreferences.getShowCallerID();
    final selectedID = appPreferences.getSelectedCallerID();

    return CallerIDSettingsState._(showID, selectedID, '', []);
  }

  CallerIDSettingsState copyWithUserInfo(UserInfo userInfo) {
    final mainNumber = userInfo.numbers.main;
    final additionalNumbers = userInfo.numbers.additional ?? [];

    return CallerIDSettingsState._(showID, selectedID, mainNumber, additionalNumbers);
  }

  CallerIDSettingsState copyWithShow(bool showID) {
    return CallerIDSettingsState._(showID, selectedID, defaultID, availableIDs);
  }

  CallerIDSettingsState copyWithSelected(String? selectedID) {
    return CallerIDSettingsState._(showID, selectedID, defaultID, availableIDs);
  }
}
