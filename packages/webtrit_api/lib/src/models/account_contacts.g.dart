// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_contacts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountContactsResponse _$AccountContactsResponseFromJson(
        Map<String, dynamic> json) =>
    AccountContactsResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => AccountContact.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

AccountContact _$AccountContactFromJson(Map<String, dynamic> json) =>
    AccountContact(
      number: json['number'] as String,
      extensionId: json['extension_id'] as String,
      extensionName: json['extension_name'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      email: json['email'] as String?,
      mobile: json['mobile'] as String?,
      companyName: json['company_name'] as String?,
      sipStatus: json['sip_status'] as int,
    );

Map<String, dynamic> _$AccountContactToJson(AccountContact instance) =>
    <String, dynamic>{
      'number': instance.number,
      'extension_id': instance.extensionId,
      'extension_name': instance.extensionName,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'mobile': instance.mobile,
      'company_name': instance.companyName,
      'sip_status': instance.sipStatus,
    };
