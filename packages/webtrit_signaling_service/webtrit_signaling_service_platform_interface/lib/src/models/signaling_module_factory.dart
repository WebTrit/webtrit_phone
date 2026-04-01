import 'signaling_module_interface.dart';
import 'signaling_service_config.dart';

/// Factory function that creates a [SignalingModuleInterface] from a [SignalingServiceConfig].
///
/// Must be a top-level function annotated with [@pragma('vm:entry-point')] on
/// Android so that [PluginUtilities] can serialize it for the background isolate.
typedef SignalingModuleFactory = SignalingModuleInterface Function(SignalingServiceConfig config);
