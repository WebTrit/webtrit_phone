import 'package:webtrit_phone/repositories/repositories.dart';

const userInfo = UserInfo(
  balance: Balance(amount: 100, currency: 'USD', balanceType: BalanceType.prepaid),
  sip: UserSipInfo(login: '1234567890'),
  firstName: 'Agent',
  lastName: 'Smith',
  companyName: 'WebTrit',
);
