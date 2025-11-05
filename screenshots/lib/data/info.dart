import 'package:webtrit_phone/repositories/repositories.dart';

const userInfo = UserInfo(
  balance:
      Balance(amount: 100, currency: 'USD', balanceType: BalanceType.prepaid),
  firstName: 'Agent',
  lastName: 'Smith',
  companyName: 'WebTrit',
  numbers: Numbers(main: '999'),
);
