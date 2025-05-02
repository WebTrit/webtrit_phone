import 'dart:async';

import 'package:logging/logging.dart';
import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('CallerIDSyncWorker');

class CallerIDSyncWorker {
  CallerIDSyncWorker(this._userRepository, this._appPreferences) {
    _userRepository.getInfo().then(_handleUserInfo);
    _userInfoSub = _userRepository.infoUpdates().listen(_handleUserInfo);
  }

  final UserRepository _userRepository;
  final AppPreferences _appPreferences;
  late final StreamSubscription _userInfoSub;

  void _handleUserInfo(UserInfo userInfo) {
    _logger.fine('Received user info: $userInfo');

    // invalidate selected caller ID if selected id becomes unavailable
    final availableCallerIDs = userInfo.numbers.additional ?? [];
    final selectedCallerID = _appPreferences.getSelectedCallerID();
    if (selectedCallerID != null && !availableCallerIDs.contains(selectedCallerID)) {
      _logger.fine('Selected caller ID $selectedCallerID is no longer available');
      _appPreferences.setSelectedCallerID(null);
    }
  }

  void dispose() {
    _userInfoSub.cancel();
  }
}
