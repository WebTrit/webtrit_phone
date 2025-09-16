import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/widgets/webview/extensions/extensions.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'models/models.dart';
import 'web_view_container.dart';
import 'webview_injection_console_logging.dart';

final _logger = Logger('WebViewContainer');

/// Options for configuring the reload channel behavior.
class ReloadChannelOptions {
  /// Channel name (must match the name used in the web page).
  final String name;

  /// Debounce delay between consecutive reload requests.
  final Duration debounce;

  /// Max number of reloads allowed within [window].
  final int maxReloads;

  /// Rate-limit window.
  final Duration window;

  /// Callback invoked right before performing the actual reload.
  final void Function(JsonJsEvent e)? onReloadEvent;

  /// Callback invoked when a reload request is rejected due to rate limiting.
  final void Function(JsonJsEvent e)? onRateLimited;

  /// Callback invoked when an unknown event name is received.
  final void Function(JsonJsEvent e)? onUnknown;

  const ReloadChannelOptions({
    this.name = 'WebtritPageReloadChannel',
    this.debounce = const Duration(seconds: 5),
    this.maxReloads = 10,
    this.window = const Duration(minutes: 1),
    this.onReloadEvent,
    this.onRateLimited,
    this.onUnknown,
  });
}

/// A utility class for constructing common [JSChannelStrategy] instances.
///
/// Provides factory methods for:
/// - Creating a simple channel with a single event handler.
/// - Creating a router-based channel that dispatches by event name.
/// - Creating a console logger channel to capture and forward `console.*`.
/// - Creating a reload channel with debounce and rate limiting.
/// - Resolving a combined list of strategies including custom ones.
class JSChannelBuilders {
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
  static JSChannelStrategy consoleLogger({String name = ConsoleLoggingInjectionStrategy.consoleLoggingChannelName}) {
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

    return JSChannelStrategy(
      name: name,
      onEvent: (_, it) {
        final level = pickLevel(it.event);
        final message = it.data?['message']?.toString() ?? it.raw?['message']?.toString() ?? it.raw?.toString() ?? '';
        log(level, message);
      },
    );
  }

  static JSChannelStrategy reloadPageChannel({
    ReloadChannelOptions options = const ReloadChannelOptions(),
  }) {
    final List<DateTime> hits = <DateTime>[];
    Timer? debounceTimer;
    JsonJsEvent? pendingEvent;

    void pruneOldHits(DateTime now) {
      final cutoff = now.subtract(options.window);
      while (hits.isNotEmpty && hits.first.isBefore(cutoff)) {
        hits.removeAt(0);
      }
    }

    Future<void> handle(WebViewController controller, JsonJsEvent e) async {
      pendingEvent = e;
      debounceTimer?.cancel();
      debounceTimer = Timer(options.debounce, () async {
        final now = DateTime.now();
        pruneOldHits(now);

        if (hits.length >= options.maxReloads) {
          _logger.warning(
            '[reload] rate-limited: ${hits.length}/${options.maxReloads} in last ${options.window.inSeconds}s',
          );
          options.onRateLimited?.call(pendingEvent!);
          return;
        }

        options.onReloadEvent?.call(pendingEvent!);

        try {
          hits.add(DateTime.now());
          await controller.reload();
          _logger.info('[reload] WebView reloaded');
        } catch (err, st) {
          _logger.severe('[reload] failed', err, st);
        } finally {
          pendingEvent = null;
        }
      });
    }

    return JSChannelStrategy.route(
      name: options.name,
      routes: {
        'reload': (controller, it) => handle(controller, it),
      },
      onUnknown: options.onUnknown ?? (e) => _logger.fine('[reload] Unknown event: ${e.event}'),
    );
  }

  /// Combines multiple [JSChannelStrategy] instances into a list.
  ///
  /// - [custom]: Any feature-specific strategies to include.
  /// - [enableLogCapture]: Whether to add the [consoleLogger] channel.
  /// - [enablePageVersionHandler]: Whether to add the default [pageVersion] handler.
  ///
  /// Returns the final list of strategies to be attached to the WebView.
  static List<JSChannelStrategy> resolve({
    List<JSChannelStrategy> custom = const [],
    bool enableLogCapture = true,
    bool enablePageVersionHandler = true,
  }) {
    final list = <JSChannelStrategy>[...custom];

    if (enableLogCapture) {
      list.add(consoleLogger());
    }

    if (enablePageVersionHandler) {
      list.add(reloadPageChannel());
    }

    return list;
  }
}
