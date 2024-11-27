import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

/// A simple cubit that gets and listen user information used to store data during the user's session.
class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit(this._userRepository) : super(const UserInfoState()) {
    _userRepository.getInfo().then(_handleUserInfo);
    _userInfoSub = _userRepository.infoUpdates().listen(_handleUserInfo);
  }

  final UserRepository _userRepository;
  late final StreamSubscription _userInfoSub;

  Future<void> _handleUserInfo(UserInfo userInfo) async {
    emit(UserInfoState(userInfo: userInfo));
  }

  @override
  Future<void> close() {
    _userInfoSub.cancel();
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
