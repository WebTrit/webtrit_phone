import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('UserInfoCubit');

/// A simple cubit that gets and listen user information used to store data during the user's session.
class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit(this._userRepository) : super(const UserInfoState()) {
    _userInfoSub = _userRepository.getAndListen().listen(_handleUserInfo);
  }

  final UserRepository _userRepository;
  StreamSubscription? _userInfoSub;

  void _handleUserInfo(UserInfo? userInfo) async {
    _logger.finer('_handleUserInfo: $userInfo');
    emit(UserInfoState(userInfo: userInfo));
  }

  @override
  Future<void> close() {
    _userInfoSub?.cancel();
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
