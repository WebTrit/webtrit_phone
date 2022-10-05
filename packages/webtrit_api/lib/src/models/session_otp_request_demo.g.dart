// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_otp_request_demo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SessionOtpRequestDemoRequestToJson(
        SessionOtpRequestDemoRequest instance) =>
    <String, dynamic>{
      'type': _$AppTypeEnumMap[instance.type]!,
      'identifier': instance.identifier,
      'email': instance.email,
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

SessionOtpRequestDemoResponse _$SessionOtpRequestDemoResponseFromJson(
        Map<String, dynamic> json) =>
    SessionOtpRequestDemoResponse(
      otpId: json['otpId'] as String,
    );
