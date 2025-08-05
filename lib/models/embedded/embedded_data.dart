import 'embedded_payload_data.dart';

/// Defines the strategy for handling reconnections in an embedded resource context.
enum ReconnectStrategy {
  /// Do nothing; assume page handles its own recovery
  none,

  /// Call JS bridge to notify app about reconnection (e.g., reinject token)
  notifyOnly,

  /// Reload the same URI without forcing full restart of the app
  softReload,

  /// Reloads the full WebView, discarding app state (may break SPA)
  hardReload,
}

class EmbeddedData {
  EmbeddedData({
    required this.id,
    required this.uri,
    required this.reconnectStrategy,
    this.titleL10n,
    this.payload = const [],
    this.enableConsoleLogCapture = false,
  });

  /// The URI representing either a local asset file path or a remote URL.
  final int id;

  /// The unique identifier for the embedded resource, used to link it with other features or components.
  final Uri uri;

  /// The list of payload data to be passed to the embedded resource.
  final List<EmbeddedPayloadData> payload;

  /// The flag to enable capturing `console.*` logs from inside the WebView.
  final bool enableConsoleLogCapture;

  /// The strategy to apply when the network reconnects.
  final ReconnectStrategy reconnectStrategy;

  /// The key to use to look up the localized title.
  final String? titleL10n;
}
