// Autogenerated from Pigeon (v3.1.3), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name
// @dart = 2.12
import 'dart:async';
import 'dart:typed_data' show Uint8List, Int32List, Int64List, Float64List;

import 'package:flutter/foundation.dart' show WriteBuffer, ReadBuffer;
import 'package:flutter/services.dart';

enum PHandleTypeEnum {
  generic,
  number,
  email,
}

enum PEndCallReasonEnum {
  failed,
  remoteEnded,
  unanswered,
  answeredElsewhere,
  declinedElsewhere,
  missed,
}

enum PIncomingCallErrorEnum {
  unknown,
  unentitled,
  callUuidAlreadyExists,
  filteredByDoNotDisturb,
  filteredByBlockList,
}

class PIOSOptions {
  PIOSOptions({
    required this.localizedName,
    this.ringtoneSound,
    this.iconTemplateImageAssetName,
    required this.maximumCallGroups,
    required this.maximumCallsPerCallGroup,
    this.supportsHandleTypeGeneric,
    this.supportsHandleTypePhoneNumber,
    this.supportsHandleTypeEmailAddress,
    required this.supportsVideo,
    required this.includesCallsInRecents,
  });

  String localizedName;
  String? ringtoneSound;
  String? iconTemplateImageAssetName;
  int maximumCallGroups;
  int maximumCallsPerCallGroup;
  bool? supportsHandleTypeGeneric;
  bool? supportsHandleTypePhoneNumber;
  bool? supportsHandleTypeEmailAddress;
  bool supportsVideo;
  bool includesCallsInRecents;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['localizedName'] = localizedName;
    pigeonMap['ringtoneSound'] = ringtoneSound;
    pigeonMap['iconTemplateImageAssetName'] = iconTemplateImageAssetName;
    pigeonMap['maximumCallGroups'] = maximumCallGroups;
    pigeonMap['maximumCallsPerCallGroup'] = maximumCallsPerCallGroup;
    pigeonMap['supportsHandleTypeGeneric'] = supportsHandleTypeGeneric;
    pigeonMap['supportsHandleTypePhoneNumber'] = supportsHandleTypePhoneNumber;
    pigeonMap['supportsHandleTypeEmailAddress'] = supportsHandleTypeEmailAddress;
    pigeonMap['supportsVideo'] = supportsVideo;
    pigeonMap['includesCallsInRecents'] = includesCallsInRecents;
    return pigeonMap;
  }

  static PIOSOptions decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return PIOSOptions(
      localizedName: pigeonMap['localizedName']! as String,
      ringtoneSound: pigeonMap['ringtoneSound'] as String?,
      iconTemplateImageAssetName: pigeonMap['iconTemplateImageAssetName'] as String?,
      maximumCallGroups: pigeonMap['maximumCallGroups']! as int,
      maximumCallsPerCallGroup: pigeonMap['maximumCallsPerCallGroup']! as int,
      supportsHandleTypeGeneric: pigeonMap['supportsHandleTypeGeneric'] as bool?,
      supportsHandleTypePhoneNumber: pigeonMap['supportsHandleTypePhoneNumber'] as bool?,
      supportsHandleTypeEmailAddress: pigeonMap['supportsHandleTypeEmailAddress'] as bool?,
      supportsVideo: pigeonMap['supportsVideo']! as bool,
      includesCallsInRecents: pigeonMap['includesCallsInRecents']! as bool,
    );
  }
}

class POptions {
  POptions({
    required this.ios,
  });

  PIOSOptions ios;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['ios'] = ios.encode();
    return pigeonMap;
  }

  static POptions decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return POptions(
      ios: PIOSOptions.decode(pigeonMap['ios']!)
,
    );
  }
}

class PHandle {
  PHandle({
    required this.type,
    required this.value,
  });

  PHandleTypeEnum type;
  String value;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['type'] = type.index;
    pigeonMap['value'] = value;
    return pigeonMap;
  }

  static PHandle decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return PHandle(
      type: PHandleTypeEnum.values[pigeonMap['type']! as int]
,
      value: pigeonMap['value']! as String,
    );
  }
}

class PEndCallReason {
  PEndCallReason({
    required this.value,
  });

  PEndCallReasonEnum value;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['value'] = value.index;
    return pigeonMap;
  }

  static PEndCallReason decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return PEndCallReason(
      value: PEndCallReasonEnum.values[pigeonMap['value']! as int]
,
    );
  }
}

class PIncomingCallError {
  PIncomingCallError({
    required this.value,
  });

  PIncomingCallErrorEnum value;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['value'] = value.index;
    return pigeonMap;
  }

  static PIncomingCallError decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return PIncomingCallError(
      value: PIncomingCallErrorEnum.values[pigeonMap['value']! as int]
,
    );
  }
}

class _PHostApiCodec extends StandardMessageCodec {
  const _PHostApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is PEndCallReason) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else 
    if (value is PHandle) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else 
    if (value is PHandle) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else 
    if (value is PIOSOptions) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else 
    if (value is PIncomingCallError) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else 
    if (value is POptions) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    } else 
{
      super.writeValue(buffer, value);
    }
  }
  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:       
        return PEndCallReason.decode(readValue(buffer)!);
      
      case 129:       
        return PHandle.decode(readValue(buffer)!);
      
      case 130:       
        return PHandle.decode(readValue(buffer)!);
      
      case 131:       
        return PIOSOptions.decode(readValue(buffer)!);
      
      case 132:       
        return PIncomingCallError.decode(readValue(buffer)!);
      
      case 133:       
        return POptions.decode(readValue(buffer)!);
      
      default:      
        return super.readValueOfType(type, buffer);
      
    }
  }
}

class PHostApi {
  /// Constructor for [PHostApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  PHostApi({BinaryMessenger? binaryMessenger}) : _binaryMessenger = binaryMessenger;

  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _PHostApiCodec();

  Future<bool> isSetUp() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PHostApi.isSetUp', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(null) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else if (replyMap['result'] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyMap['result'] as bool?)!;
    }
  }

  Future<void> setUp(POptions arg_options) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PHostApi.setUp', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_options]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> tearDown() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PHostApi.tearDown', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(null) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<PIncomingCallError?> reportNewIncomingCall(String arg_uuidString, PHandle arg_handle, String? arg_displayName, bool arg_hasVideo) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PHostApi.reportNewIncomingCall', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_uuidString, arg_handle, arg_displayName, arg_hasVideo]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return (replyMap['result'] as PIncomingCallError?);
    }
  }

  Future<void> reportConnectingOutgoingCall(String arg_uuidString) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PHostApi.reportConnectingOutgoingCall', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_uuidString]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> reportConnectedOutgoingCall(String arg_uuidString) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PHostApi.reportConnectedOutgoingCall', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_uuidString]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> reportUpdateCall(String arg_uuidString, PHandle? arg_handle, String? arg_displayName, bool? arg_hasVideo) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PHostApi.reportUpdateCall', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_uuidString, arg_handle, arg_displayName, arg_hasVideo]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> reportEndCall(String arg_uuidString, PEndCallReason arg_reason) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PHostApi.reportEndCall', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_uuidString, arg_reason]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> startCall(String arg_uuidString, PHandle arg_handle, String? arg_displayNameOrContactIdentifier, bool arg_video) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PHostApi.startCall', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_uuidString, arg_handle, arg_displayNameOrContactIdentifier, arg_video]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> answerCall(String arg_uuidString) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PHostApi.answerCall', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_uuidString]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> endCall(String arg_uuidString) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PHostApi.endCall', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_uuidString]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> setHeld(String arg_uuidString, bool arg_onHold) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PHostApi.setHeld', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_uuidString, arg_onHold]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> setMuted(String arg_uuidString, bool arg_muted) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PHostApi.setMuted', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_uuidString, arg_muted]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> sendDTMF(String arg_uuidString, String arg_key) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PHostApi.sendDTMF', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_uuidString, arg_key]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }
}

class _PDelegateFlutterApiCodec extends StandardMessageCodec {
  const _PDelegateFlutterApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is PHandle) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else 
    if (value is PIncomingCallError) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else 
{
      super.writeValue(buffer, value);
    }
  }
  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:       
        return PHandle.decode(readValue(buffer)!);
      
      case 129:       
        return PIncomingCallError.decode(readValue(buffer)!);
      
      default:      
        return super.readValueOfType(type, buffer);
      
    }
  }
}
abstract class PDelegateFlutterApi {
  static const MessageCodec<Object?> codec = _PDelegateFlutterApiCodec();

  void continueStartCallIntent(PHandle handle, String? displayName, bool video);
  void didPushIncomingCall(PHandle handle, String? displayName, bool video, String callId, String uuidString, PIncomingCallError? error);
  Future<bool> performStartCall(String uuidString, PHandle handle, String? displayNameOrContactIdentifier, bool video);
  Future<bool> performAnswerCall(String uuidString);
  Future<bool> performEndCall(String uuidString);
  Future<bool> performSetHeld(String uuidString, bool onHold);
  Future<bool> performSetMuted(String uuidString, bool muted);
  Future<bool> performSendDTMF(String uuidString, String key);
  void didActivateAudioSession();
  void didDeactivateAudioSession();
  void didReset();
  static void setup(PDelegateFlutterApi? api, {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.PDelegateFlutterApi.continueStartCallIntent', codec, binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null, 'Argument for dev.flutter.pigeon.PDelegateFlutterApi.continueStartCallIntent was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final PHandle? arg_handle = (args[0] as PHandle?);
          assert(arg_handle != null, 'Argument for dev.flutter.pigeon.PDelegateFlutterApi.continueStartCallIntent was null, expected non-null PHandle.');
          final String? arg_displayName = (args[1] as String?);
          final bool? arg_video = (args[2] as bool?);
          assert(arg_video != null, 'Argument for dev.flutter.pigeon.PDelegateFlutterApi.continueStartCallIntent was null, expected non-null bool.');
          api.continueStartCallIntent(arg_handle!, arg_displayName, arg_video!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.PDelegateFlutterApi.didPushIncomingCall', codec, binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null, 'Argument for dev.flutter.pigeon.PDelegateFlutterApi.didPushIncomingCall was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final PHandle? arg_handle = (args[0] as PHandle?);
          assert(arg_handle != null, 'Argument for dev.flutter.pigeon.PDelegateFlutterApi.didPushIncomingCall was null, expected non-null PHandle.');
          final String? arg_displayName = (args[1] as String?);
          final bool? arg_video = (args[2] as bool?);
          assert(arg_video != null, 'Argument for dev.flutter.pigeon.PDelegateFlutterApi.didPushIncomingCall was null, expected non-null bool.');
          final String? arg_callId = (args[3] as String?);
          assert(arg_callId != null, 'Argument for dev.flutter.pigeon.PDelegateFlutterApi.didPushIncomingCall was null, expected non-null String.');
          final String? arg_uuidString = (args[4] as String?);
          assert(arg_uuidString != null, 'Argument for dev.flutter.pigeon.PDelegateFlutterApi.didPushIncomingCall was null, expected non-null String.');
          final PIncomingCallError? arg_error = (args[5] as PIncomingCallError?);
          api.didPushIncomingCall(arg_handle!, arg_displayName, arg_video!, arg_callId!, arg_uuidString!, arg_error);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.PDelegateFlutterApi.performStartCall', codec, binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null, 'Argument for dev.flutter.pigeon.PDelegateFlutterApi.performStartCall was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final String? arg_uuidString = (args[0] as String?);
          assert(arg_uuidString != null, 'Argument for dev.flutter.pigeon.PDelegateFlutterApi.performStartCall was null, expected non-null String.');
          final PHandle? arg_handle = (args[1] as PHandle?);
          assert(arg_handle != null, 'Argument for dev.flutter.pigeon.PDelegateFlutterApi.performStartCall was null, expected non-null PHandle.');
          final String? arg_displayNameOrContactIdentifier = (args[2] as String?);
          final bool? arg_video = (args[3] as bool?);
          assert(arg_video != null, 'Argument for dev.flutter.pigeon.PDelegateFlutterApi.performStartCall was null, expected non-null bool.');
          final bool output = await api.performStartCall(arg_uuidString!, arg_handle!, arg_displayNameOrContactIdentifier, arg_video!);
          return output;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.PDelegateFlutterApi.performAnswerCall', codec, binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null, 'Argument for dev.flutter.pigeon.PDelegateFlutterApi.performAnswerCall was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final String? arg_uuidString = (args[0] as String?);
          assert(arg_uuidString != null, 'Argument for dev.flutter.pigeon.PDelegateFlutterApi.performAnswerCall was null, expected non-null String.');
          final bool output = await api.performAnswerCall(arg_uuidString!);
          return output;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.PDelegateFlutterApi.performEndCall', codec, binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null, 'Argument for dev.flutter.pigeon.PDelegateFlutterApi.performEndCall was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final String? arg_uuidString = (args[0] as String?);
          assert(arg_uuidString != null, 'Argument for dev.flutter.pigeon.PDelegateFlutterApi.performEndCall was null, expected non-null String.');
          final bool output = await api.performEndCall(arg_uuidString!);
          return output;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.PDelegateFlutterApi.performSetHeld', codec, binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null, 'Argument for dev.flutter.pigeon.PDelegateFlutterApi.performSetHeld was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final String? arg_uuidString = (args[0] as String?);
          assert(arg_uuidString != null, 'Argument for dev.flutter.pigeon.PDelegateFlutterApi.performSetHeld was null, expected non-null String.');
          final bool? arg_onHold = (args[1] as bool?);
          assert(arg_onHold != null, 'Argument for dev.flutter.pigeon.PDelegateFlutterApi.performSetHeld was null, expected non-null bool.');
          final bool output = await api.performSetHeld(arg_uuidString!, arg_onHold!);
          return output;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.PDelegateFlutterApi.performSetMuted', codec, binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null, 'Argument for dev.flutter.pigeon.PDelegateFlutterApi.performSetMuted was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final String? arg_uuidString = (args[0] as String?);
          assert(arg_uuidString != null, 'Argument for dev.flutter.pigeon.PDelegateFlutterApi.performSetMuted was null, expected non-null String.');
          final bool? arg_muted = (args[1] as bool?);
          assert(arg_muted != null, 'Argument for dev.flutter.pigeon.PDelegateFlutterApi.performSetMuted was null, expected non-null bool.');
          final bool output = await api.performSetMuted(arg_uuidString!, arg_muted!);
          return output;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.PDelegateFlutterApi.performSendDTMF', codec, binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null, 'Argument for dev.flutter.pigeon.PDelegateFlutterApi.performSendDTMF was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final String? arg_uuidString = (args[0] as String?);
          assert(arg_uuidString != null, 'Argument for dev.flutter.pigeon.PDelegateFlutterApi.performSendDTMF was null, expected non-null String.');
          final String? arg_key = (args[1] as String?);
          assert(arg_key != null, 'Argument for dev.flutter.pigeon.PDelegateFlutterApi.performSendDTMF was null, expected non-null String.');
          final bool output = await api.performSendDTMF(arg_uuidString!, arg_key!);
          return output;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.PDelegateFlutterApi.didActivateAudioSession', codec, binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          // ignore message
          api.didActivateAudioSession();
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.PDelegateFlutterApi.didDeactivateAudioSession', codec, binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          // ignore message
          api.didDeactivateAudioSession();
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.PDelegateFlutterApi.didReset', codec, binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          // ignore message
          api.didReset();
          return;
        });
      }
    }
  }
}

class _PPushRegistryHostApiCodec extends StandardMessageCodec {
  const _PPushRegistryHostApiCodec();
}

class PPushRegistryHostApi {
  /// Constructor for [PPushRegistryHostApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  PPushRegistryHostApi({BinaryMessenger? binaryMessenger}) : _binaryMessenger = binaryMessenger;

  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _PPushRegistryHostApiCodec();

  Future<String?> pushTokenForPushTypeVoIP() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PPushRegistryHostApi.pushTokenForPushTypeVoIP', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(null) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return (replyMap['result'] as String?);
    }
  }
}

class _PPushRegistryDelegateFlutterApiCodec extends StandardMessageCodec {
  const _PPushRegistryDelegateFlutterApiCodec();
}
abstract class PPushRegistryDelegateFlutterApi {
  static const MessageCodec<Object?> codec = _PPushRegistryDelegateFlutterApiCodec();

  void didUpdatePushTokenForPushTypeVoIP(String? token);
  static void setup(PPushRegistryDelegateFlutterApi? api, {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.PPushRegistryDelegateFlutterApi.didUpdatePushTokenForPushTypeVoIP', codec, binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null, 'Argument for dev.flutter.pigeon.PPushRegistryDelegateFlutterApi.didUpdatePushTokenForPushTypeVoIP was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final String? arg_token = (args[0] as String?);
          api.didUpdatePushTokenForPushTypeVoIP(arg_token);
          return;
        });
      }
    }
  }
}
