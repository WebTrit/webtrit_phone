import 'package:webtrit_api/webtrit_api.dart' as api;

import 'package:webtrit_phone/models/models.dart';

mixin UserInfoApiMapper {
  UserInfo userInfoFromApi(api.UserInfo userInfo) {
    return UserInfo(
      status: userInfoStatusFromApi(userInfo.status),
      balance: userInfo.balance == null ? null : balanceFromApi(userInfo.balance!),
      numbers: numbersFromApi(userInfo.numbers),
      email: userInfo.email,
      firstName: userInfo.firstName,
      lastName: userInfo.lastName,
      aliasName: userInfo.aliasName,
      companyName: userInfo.companyName,
      timeZone: userInfo.timeZone,
    );
  }

  UserInfoStatus? userInfoStatusFromApi(api.UserInfoStatus? status) {
    if (status == null) return null;
    return UserInfoStatus.values.byName(status.name);
  }

  Balance balanceFromApi(api.Balance balance) {
    return Balance(
      balanceType: balanceTypeFromApi(balance.balanceType),
      amount: balance.amount,
      creditLimit: balance.creditLimit,
      currency: balance.currency,
    );
  }

  BalanceType? balanceTypeFromApi(api.BalanceType? balanceType) {
    if (balanceType == null) return null;
    return BalanceType.values.byName(balanceType.name);
  }

  BillingModel? billingModelFromApi(api.BillingModel? billingModel) {
    if (billingModel == null) return null;
    return BillingModel.values.byName(billingModel.name);
  }

  Numbers numbersFromApi(api.Numbers numbers) {
    return Numbers(main: numbers.main, ext: numbers.ext, additional: numbers.additional, sms: numbers.sms);
  }
}
