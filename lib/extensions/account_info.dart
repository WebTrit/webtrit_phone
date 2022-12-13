import 'package:webtrit_api/webtrit_api.dart';

import 'iterable.dart';

extension AccountInfoFormatting on AccountInfo {
  String get name {
    return [firstname, lastname].readableJoin();
  }

  String? get balanceWithCurrency {
    final creditLimit = this.creditLimit;
    switch (billingModel) {
      case BillingModel.debit:
        return '${balance.toStringAsFixed(2)} $currency';
      case BillingModel.credit:
        if (creditLimit != null) {
          return '${creditLimit.toStringAsFixed(2)} $currency';
        } else {
          return null;
        }
      default:
        return null;
    }
  }

  String get numberWithExtension {
    if (ext != null) {
      return '$login (ext: $ext)';
    } else {
      return login;
    }
  }
}
