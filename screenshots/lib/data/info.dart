import 'package:webtrit_phone/repositories/repositories.dart';

const dAccountInfo = User(
  balance: Balance(amount: 100, currency: 'USD', balanceType: BalanceType.prepaid),
  sip: SipData(login: '1234567890'),
  firstName: 'Agent',
  lastName: 'Smith',
  companyName: 'WebTrit',
);
