import 'package:flutter/material.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import 'iterable.dart';

extension UserInfoFormatting on UserInfo {
  String? get name {
    if (aliasName != null) {
      return aliasName;
    } else if (firstName != null && lastName != null) {
      return [firstName, lastName].readableJoin();
    } else {
      return firstName ?? lastName;
    }
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

  /// Returns the main number without leading/trailing whitespace.
  String get cleanMainNumber => numbers.main?.trim() ?? '';

  /// Returns the extension number without leading/trailing whitespace.
  String get cleanExtNumber => numbers.ext?.trim() ?? '';

  /// Formats the user's phone number for display.
  ///
  /// This method uses localization to format the main number and extension number.
  /// It determines the appropriate format ('full', 'simple', 'only_ext', or 'empty')
  /// based on whether the main number and extension number are present.
  ///
  /// - 'full': When both main and extension numbers are available.
  /// - 'simple': When only the main number is available.
  /// - 'only_ext': When only the extension number is available.
  /// - 'empty': When neither is available.
  String formatPhoneNumber(BuildContext context) {
    final style = cleanMainNumber.isNotEmpty
        ? (cleanExtNumber.isNotEmpty ? 'full' : 'simple')
        : (cleanExtNumber.isNotEmpty ? 'only_ext' : 'empty');
    return context.l10n.formatPhone(style, cleanMainNumber, cleanExtNumber);
  }
}
