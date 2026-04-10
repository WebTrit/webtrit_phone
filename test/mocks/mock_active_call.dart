import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/call/call.dart';

class MockActiveCall extends Fake implements ActiveCall {
  MockActiveCall({
    this.processingStatus = CallProcessingStatus.connected,
    this.wasHungUp = false,
    this.isCameraActive = false,
    this.remoteVideo = false,
    this.held = false,
  });

  @override
  final CallProcessingStatus processingStatus;

  @override
  final bool wasHungUp;

  @override
  final bool isCameraActive;

  @override
  final bool remoteVideo;

  @override
  final bool held;
}
