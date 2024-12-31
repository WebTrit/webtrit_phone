import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('UserInfoCubit');

/// A simple cubit that gets and listen user information used to store data during the user's session.
class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit(this._userRepository) : super(const UserInfoState()) {
    fetchUserInfo();
    _userInfoSub = _userRepository.infoUpdates().listen(_handleUserInfo);
    _connectivitySub = Connectivity().onConnectivityChanged.listen(_handleConnectivity);
  }

  final UserRepository _userRepository;
  late final StreamSubscription _userInfoSub;
  late final StreamSubscription _connectivitySub;

  void _handleUserInfo(UserInfo userInfo) async {
    emit(UserInfoState(userInfo: userInfo));
  }

  void _handleConnectivity(List<ConnectivityResult> crs) {
    if (crs.any((cr) => cr != ConnectivityResult.none)) fetchUserInfo();
  }

  void fetchUserInfo() async {
    try {
      final info = await _userRepository.getInfo();
      _handleUserInfo(info);
    } catch (e, s) {
      _logger.warning('Failed to get user info', e, s);
    }
  }

  @override
  Future<void> close() {
    _userInfoSub.cancel();
    _connectivitySub.cancel();
    return super.close();
  }
}

class UserInfoState extends Equatable {
  const UserInfoState({this.userInfo});
  final UserInfo? userInfo;

  @override
  List<Object?> get props => [userInfo];

  @override
  toString() => 'UserInfoState(userInfo: $userInfo)';
}
