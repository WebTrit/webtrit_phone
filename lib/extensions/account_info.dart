import 'package:webtrit_api/webtrit_api.dart';

extension AccountInfoFormatting on AccountInfo {
  String get name {
    final names = [firstname, lastname].where((name) => name != null);
    return names.join(' ').trim();
  }

  String get balanceWithCurrency {
    return '${balance.toStringAsFixed(2)} $currency';
  }

  String get numberWithExtension {
    if (ext != null) {
      return '$login (ext: $ext)';
    } else {
      return login;
    }
  }
}
