import 'package:equatable/equatable.dart';

class UserInfo extends Equatable {
  const UserInfo({
    this.status,
    this.balance,
    required this.numbers,
    this.email,
    this.firstName,
    this.lastName,
    this.aliasName,
    this.companyName,
    this.timeZone,
  });

  final UserInfoStatus? status;
  final Balance? balance;
  final Numbers numbers;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? aliasName;
  final String? companyName;
  final String? timeZone;

  @override
  List<Object?> get props => [status, balance, numbers, email, firstName, lastName, aliasName, companyName, timeZone];
}

class Numbers extends Equatable {
  const Numbers({this.main, this.ext, this.additional, this.sms});

  final String? main;
  final String? ext;
  final List<String>? additional;
  final List<String>? sms;

  @override
  List<Object?> get props => [main, ext, additional, sms];
}

class Balance extends Equatable {
  const Balance({this.balanceType, this.amount, this.creditLimit, this.currency});

  final BalanceType? balanceType;
  final double? amount;
  final double? creditLimit;
  final String? currency;

  @override
  List<Object?> get props => [balanceType, amount, creditLimit, currency];
}

enum UserInfoStatus { active, limited, blocked }

enum BalanceType { unknown, inapplicable, prepaid, postpaid }

enum BillingModel { debit, rechargeVoucher, credit, alias, internal, beneficiary, unknown }
