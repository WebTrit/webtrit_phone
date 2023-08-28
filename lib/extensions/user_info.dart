import 'package:webtrit_api/webtrit_api.dart';

import 'iterable.dart';

extension UserInfoFormatting on UserInfo {
  String get name {
    return [firstName, lastName].readableJoin();
  }

  String? get balanceWithCurrency {
    // TODO: Implement all enums
    final creditLimit = balance?.creditLimit;
    switch (balance?.balanceType) {
      case BalanceType.prepaid:
        return '${balance?.amount?.toStringAsFixed(2)} ${balance?.currency}';
      case BalanceType.postpaid:
        if (creditLimit != null) {
          return '${creditLimit.toStringAsFixed(2)} ${balance?.currency}';
        } else {
          return null;
        }
      default:
        return null;
    }
  }

  String get numberWithExtension {
    final sb = StringBuffer(numbers.main);
    final numbersExt = numbers.ext;
    if (numbersExt != null) {
      sb.write(' (ext: $numbersExt)');
    }
    return sb.toString();
  }
}
