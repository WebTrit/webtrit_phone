// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_otp_verify.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SessionOtpVerifyRequestToJson(
        SessionOtpVerifyRequest instance) =>
    <String, dynamic>{
      'otpId': instance.otpId,
      'code': instance.code,
    };

SessionOtpVerifyResponse _$SessionOtpVerifyResponseFromJson(
        Map<String, dynamic> json) =>
    SessionOtpVerifyResponse(
      token: json['token'] as String,
    );
