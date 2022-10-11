// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_otp_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SessionOtpRequestRequestToJson(
        SessionOtpRequestRequest instance) =>
    <String, dynamic>{
      'type': _$AppTypeEnumMap[instance.type]!,
      'identifier': instance.identifier,
      'phone': instance.phone,
    };

const _$AppTypeEnumMap = {
  AppType.smart: 'smart',
  AppType.web: 'web',
  AppType.linux: 'linux',
  AppType.macos: 'macos',
  AppType.windows: 'windows',
  AppType.android: 'android',
  AppType.androidHms: 'android_hms',
  AppType.ios: 'ios',
};

SessionOtpRequestResponse _$SessionOtpRequestResponseFromJson(
        Map<String, dynamic> json) =>
    SessionOtpRequestResponse(
      otpId: json['otp_id'] as String,
      notificationType:
          $enumDecode(_$OtpNotificationTypeEnumMap, json['notification_type']),
      fromEmail: json['from_email'] as String?,
    );

const _$OtpNotificationTypeEnumMap = {
  OtpNotificationType.email: 'email',
};

Map<String, dynamic> _$SessionOtpRequestDemoRequestToJson(
        SessionOtpRequestDemoRequest instance) =>
    <String, dynamic>{
      'type': _$AppTypeEnumMap[instance.type]!,
      'identifier': instance.identifier,
      'email': instance.email,
    };

SessionOtpRequestDemoResponse _$SessionOtpRequestDemoResponseFromJson(
        Map<String, dynamic> json) =>
    SessionOtpRequestDemoResponse(
      otpId: json['otp_id'] as String,
      notificationType:
          $enumDecode(_$OtpNotificationTypeEnumMap, json['notification_type']),
      fromEmail: json['from_email'] as String?,
    );
