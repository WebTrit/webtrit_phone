import 'package:mocktail/mocktail.dart';
// ignore: depend_on_referenced_packages
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
// ignore: depend_on_referenced_packages
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

/// Preview-only no-op signaling platform.
///
/// Lets real screens that touch the native signaling service render in the
/// screenshot harness, where no platform implementation is registered. In
/// particular `TeardownScreen.initState` calls `stopService()`, which reaches
/// `SignalingServicePlatform.instance` and throws a `StateError` when unset.
// ignore: invalid_use_of_visible_for_testing_member
class MockSignalingServicePlatform extends Mock with MockPlatformInterfaceMixin implements SignalingServicePlatform {}

/// Registers a no-op [SignalingServicePlatform] for the preview, but only when
/// none is set yet, so a real platform implementation is never overwritten.
void ensureMockSignalingServicePlatform() {
  try {
    SignalingServicePlatform.instance;
    return;
  } on StateError catch (_) {
    // Thrown only when no platform is registered; install the no-op fallback.
    final platform = MockSignalingServicePlatform();
    when(() => platform.stopService()).thenAnswer((_) async {});
    SignalingServicePlatform.instance = platform;
  }
}
