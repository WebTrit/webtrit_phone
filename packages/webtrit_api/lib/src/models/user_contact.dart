import 'package:freezed_annotation/freezed_annotation.dart';

import 'common.dart';

part 'user_contact.freezed.dart';

part 'user_contact.g.dart';

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class UserContact with _$UserContact {
  const UserContact({
    this.userId,
    this.sipStatus,
    required this.numbers,
    this.email,
    this.firstName,
    this.lastName,
    this.aliasName,
    this.companyName,
    this.isCurrentUser,
    this.isRegisteredUser,
  });

  @override
  final String? userId;

  @override
  final SipStatus? sipStatus;

  @override
  final Numbers numbers;

  @override
  final String? email;

  @override
  final String? firstName;

  @override
  final String? lastName;

  @override
  final String? aliasName;

  @override
  final String? companyName;

  @override
  final bool? isCurrentUser;

  @override
  final bool? isRegisteredUser;

  factory UserContact.fromJson(Map<String, Object?> json) =>
      _$UserContactFromJson(json);

  Map<String, Object?> toJson() => _$UserContactToJson(this);
}

@JsonEnum(fieldRename: FieldRename.snake)
enum SipStatus { registered, notregistered }
