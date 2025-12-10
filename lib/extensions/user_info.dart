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

  String get numberWithExtension {
    final main = numbers.main?.trim() ?? '';
    final ext = numbers.ext?.trim() ?? '';

    if (main.isEmpty && ext.isEmpty) return '';

    final extPart = ext.isNotEmpty ? ' (ext: $ext)' : '';

    return '$main$extPart'.trimLeft();
  }

  String formatPhoneNumber(BuildContext context) {
    if (cleanMainNumber.isEmpty && cleanExtNumber.isEmpty) return '';

    final style = cleanExtNumber.isNotEmpty ? 'full' : 'simple';
    return context.l10n.formatPhone(
        style,
        cleanMainNumber,
        cleanExtNumber,
    );
  }
}
