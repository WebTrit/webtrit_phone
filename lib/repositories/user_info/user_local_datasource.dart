import 'dart:async';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/mappers/json/user_info_mapper.dart';
import 'package:webtrit_phone/models/models.dart';

abstract interface class UserLocalDatasource {
  UserInfo? getInfo();

  Future<void> setInfo(UserInfo userInfo);

  Future<void> clear();
}

class UserLocalDatasourcePrefsImpl with UserInfoJsonMapper implements UserLocalDatasource {
  UserLocalDatasourcePrefsImpl(this._appPreferences);

  final AppPreferences _appPreferences;
  final _prefsKey = 'user-info';

  @override
  UserInfo? getInfo() {
    final jsonString = _appPreferences.getString(_prefsKey);
    if (jsonString == null) return null;
    return userInfoFromJson(jsonString);
  }

  @override
  Future<void> setInfo(UserInfo userInfo) async {
    final jsonString = userInfoToJson(userInfo);
    await _appPreferences.setString(_prefsKey, jsonString);
  }

  @override
  Future<void> clear() async {
    await _appPreferences.remove(_prefsKey);
  }
}
