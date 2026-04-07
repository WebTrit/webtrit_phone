import 'signaling_module.dart';
import 'signaling_service_config.dart';

/// Factory function that creates a [SignalingModule] from a [SignalingServiceConfig].
///
/// Must be a top-level function annotated with [@pragma('vm:entry-point')] on
/// Android so that [PluginUtilities] can serialize it for the background isolate.
typedef SignalingModuleFactory = SignalingModule Function(SignalingServiceConfig config);
