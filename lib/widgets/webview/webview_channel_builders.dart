import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:webtrit_phone/widgets/webview/extensions/extensions.dart';

import 'models/models.dart';
import 'web_view_container.dart';

final _logger = Logger('WebViewContainer');

/// A utility class for constructing common [JSChannelStrategy] instances.
///
/// Provides factory methods for:
/// - Creating a simple channel with a single event handler.
/// - Creating a router-based channel that dispatches by event name.
/// - Creating a console logger channel to capture and forward
///   `console.*` messages from the WebView.
/// - Resolving a combined list of strategies including custom ones.
class JavaScriptChannelBuilders {
  /// Creates a [JSChannelStrategy] with a single event handler.
  ///
  /// - [name]: The channel name, must match the name used in the web page.
  /// - [onEvent]: Handler invoked when a valid [JsonJsEvent] is received.
  /// - [onMalformed]: Optional handler for raw messages that fail JSON parsing.
  static JSChannelStrategy channel({
    required String name,
    required JsonEventHandler onEvent,
    void Function(String raw)? onMalformed,
  }) {
    return JSChannelStrategy(
      name: name,
      onEvent: onEvent,
      onMalformed: onMalformed,
    );
  }

  /// Creates a [JSChannelStrategy] that routes events to different handlers
  /// based on the [JsonJsEvent.event] field.
  ///
  /// - [name]: The channel name, must match the name used in the web page.
  /// - [routes]: A map of event names to their handlers.
  /// - [onUnknown]: Optional handler when the event name is not in [routes].
  /// - [onMalformed]: Optional handler for raw messages that fail JSON parsing.
  static JSChannelStrategy router({
    required String name,
    required Map<String, JsonEventHandler> routes,
    void Function(JsonJsEvent e)? onUnknown,
    void Function(String raw)? onMalformed,
  }) {
    return JSChannelStrategy.route(
      name: name,
      routes: routes,
      onUnknown: onUnknown,
      onMalformed: onMalformed,
    );
  }

  /// Creates a [JSChannelStrategy] for logging JavaScript console messages.
  ///
  /// This channel captures `console.log`, `console.info`, `console.warn`,
  /// `console.error`, and `console.debug` from the WebView and forwards them
  /// into Dart's logging system.
  ///
  /// Supports two formats:
  /// 1. **JSON format**: `{ "event": "info", "data": { "message": "..." } }`
  /// 2. **Legacy raw string format**: `"INFO: some message"`
  ///
  /// - [name]: The channel name to use, defaults to `"ConsoleLog"`.
  static JSChannelStrategy consoleLogger({String name = 'ConsoleLog'}) {
    String pickLevel(String s) => s.toUpperCase();

    void log(String level, String message) {
      switch (level) {
        case 'ERROR':
          _logger.webViewLog(level: 'ERROR', message: message);
          break;
        case 'WARN':
        case 'WARNING':
          _logger.webViewLog(level: 'WARN', message: message);
          break;
        case 'INFO':
          _logger.webViewLog(level: 'INFO', message: message);
          break;
        case 'DEBUG':
          _logger.webViewLog(level: 'DEBUG', message: message);
          break;
        case 'LOG':
        default:
          _logger.webViewLog(level: 'LOG', message: message);
          break;
      }
    }

    // Fallback for legacy raw string messages like "WARN: something".
    void handleLegacyRaw(String raw) {
      final t = raw.trim();
      final idx = t.indexOf(':');
      if (idx > 0) {
        final lvl = pickLevel(t.substring(0, idx).trim());
        final msg = t.substring(idx + 1).trim();
        log(lvl, msg);
      } else {
        log('INFO', t);
      }
    }

    return JSChannelStrategy(
      name: name,
      onEvent: (_, it) {
        final level = pickLevel(it.event);
        final msg = it.data?['message']?.toString() ?? it.raw.toString();
        log(level, msg);
      },
      onMalformed: handleLegacyRaw,
    );
  }

  static const _pageVersionKey = 'cached_page_version';

  /// Default handler for the `pageVersion` event.
  /// - Saves latest page version to local storage.
  /// - If version differs from cached one, triggers a hard reload.
  static JSChannelStrategy pageVersion() {
    return JSChannelStrategy.route(
      routes: {
        'pageVersion': (controller, it) async {
          final newVersion = it.data?['pageVersion']?.toString();
          if (newVersion == null) {
            _logger.warning('pageVersion event without version');
            return;
          }

          final prefs = await SharedPreferences.getInstance();
          final oldVersion = prefs.getString(_pageVersionKey);

          _logger.info('Received page version: $newVersion (cached: $oldVersion)');
          if (oldVersion != newVersion) {
            _logger.info('Page version changed: $oldVersion -> $newVersion, reloading...');
            await prefs.setString(_pageVersionKey, newVersion);
            await controller.reload();
          } else {
            _logger.fine('Page version unchanged: $newVersion');
          }
        },
      },
      onUnknown: (e) => _logger.fine('Unknown event : ${e.event}'),
    );
  }

  /// Combines multiple [JSChannelStrategy] instances into a list.
  ///
  /// - [custom]: Any feature-specific strategies to include.
  /// - [includeConsoleLogger]: Whether to add the [consoleLogger] channel.
  /// - [includePageVersionHandler]: Whether to add the default [pageVersion] handler.
  ///
  /// Returns the final list of strategies to be attached to the WebView.
  static List<JSChannelStrategy> resolve({
    List<JSChannelStrategy> custom = const [],
    bool includeConsoleLogger = true,
    bool includePageVersionHandler = true,
    Future<void> Function()? onHardReload,
  }) {
    final list = <JSChannelStrategy>[...custom];

    if (includeConsoleLogger) {
      list.add(consoleLogger());
    }

    if (includePageVersionHandler) {
      list.add(pageVersion());
    }

    return list;
  }
}
