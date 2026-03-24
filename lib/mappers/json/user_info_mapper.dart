import 'dart:convert';

import 'package:webtrit_phone/models/models.dart';

mixin UserInfoJsonMapper {
  UserInfo userInfoFromJson(String json) {
    return userInfoFromMap(jsonDecode(json));
  }

  String userInfoToJson(UserInfo userInfo) {
    return jsonEncode(userInfoToMap(userInfo));
  }

  UserInfo userInfoFromMap(Map<String, dynamic> map) {
    return UserInfo(
      status: userInfoStatusFromName(map['status'] as String?),
      balance: map['balance'] != null ? balanceFromMap(map['balance'] as Map<String, dynamic>) : null,
      numbers: numbersFromMap(map['numbers'] as Map<String, dynamic>),
      email: map['email'] as String?,
      firstName: map['firstName'] as String?,
      lastName: map['lastName'] as String?,
      aliasName: map['aliasName'] as String?,
      companyName: map['companyName'] as String?,
      timeZone: map['timeZone'] as String?,
    );
  }

  Map<String, dynamic> userInfoToMap(UserInfo userInfo) {
    return {
      'status': userInfo.status?.name,
      'balance': userInfo.balance != null ? balanceToMap(userInfo.balance!) : null,
      'numbers': numbersToMap(userInfo.numbers),
      'email': userInfo.email,
      'firstName': userInfo.firstName,
      'lastName': userInfo.lastName,
      'aliasName': userInfo.aliasName,
      'companyName': userInfo.companyName,
      'timeZone': userInfo.timeZone,
    };
  }

  Balance balanceFromMap(Map<String, dynamic> map) {
    return Balance(
      balanceType: balanceTypeFromName(map['balanceType'] as String?),
      amount: (map['amount'] as num?)?.toDouble(),
      creditLimit: (map['creditLimit'] as num?)?.toDouble(),
      currency: map['currency'] as String?,
    );
  }

  Map<String, dynamic> balanceToMap(Balance balance) {
    return {
      'balanceType': balance.balanceType?.name,
      'amount': balance.amount,
      'creditLimit': balance.creditLimit,
      'currency': balance.currency,
    };
  }

  Numbers numbersFromMap(Map<String, dynamic> map) {
    return Numbers(
      main: map['main'] as String?,
      ext: map['ext'] as String?,
      additional: (map['additional'] as List<dynamic>?)?.whereType<String>().toList(),
      sms: (map['sms'] as List<dynamic>?)?.whereType<String>().toList(),
    );
  }

  Map<String, dynamic> numbersToMap(Numbers numbers) {
    return {'main': numbers.main, 'ext': numbers.ext, 'additional': numbers.additional, 'sms': numbers.sms};
  }

  UserInfoStatus? userInfoStatusFromName(String? name) {
    if (name == null) return null;
    try {
      return UserInfoStatus.values.byName(name);
    } catch (_) {
      return null;
    }
  }

  BalanceType? balanceTypeFromName(String? name) {
    if (name == null) return null;
    try {
      return BalanceType.values.byName(name);
    } catch (_) {
      return null;
    }
  }
}
