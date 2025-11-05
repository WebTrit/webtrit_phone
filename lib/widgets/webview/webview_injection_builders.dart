import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

import 'web_view_container.dart';
import 'webview_injection_console_logging.dart';

/// A collection of static builder methods for creating common
/// [PageInjectionStrategy] instances used with [WebViewContainer].
///
/// These builders provide ready-made payload strategies for
/// MediaQuery data, device information, custom payloads, or
/// even a no-op strategy when injection is not needed.
class PageInjectionBuilders {
  /// Creates a [PageInjectionStrategy] that injects basic
  /// **MediaQuery and theme data** into the WebView.
  ///
  /// Injected payload includes:
  /// - `brightness`: current theme brightness (`light` or `dark`)
  /// - `devicePixelRatio`: screen density
  /// - `topSafeInset`: top safe area (status bar height)
  /// - `bottomSafeInset`: bottom safe area (system gesture area)
  static PageInjectionStrategy mediaQuery(
    MediaQueryMetrics mediaQueryMetrics, {
    String functionName = 'onMediaQueryReady',
  }) {
    return DefaultPayloadInjectionStrategy(functionName: functionName, initialPayload: mediaQueryMetrics.toJson());
  }

  /// Creates a [PageInjectionStrategy] that injects **device labels**
  /// (from [AppLabelsProvider]) and optional `urls` into the WebView.
  ///
  /// This strategy is asynchronous because it may query storage
  /// or system services to build the labels.
  static PageInjectionStrategy deviceInfo(Map<String, String> deviceInfo, {String functionName = 'onDeviceInfoReady'}) {
    return DefaultPayloadInjectionStrategy(functionName: functionName, initialPayload: deviceInfo);
  }

  /// Creates a [PageInjectionStrategy] that injects the console logger wrapper.
  /// Forwards console.* to a JS channel (default: 'ConsoleLog').
  static PageInjectionStrategy consoleLogging() {
    return ConsoleLoggingInjectionStrategy();
  }

  /// Factory that returns a list of [PageInjectionStrategy] including
  /// optional defaults based on flags.
  ///
  /// - [mediaQueryMetricsData]: inject MediaQuery/theme data
  /// - [deviceInfoData]: inject device/app info
  /// - [includeConsoleLogging]: wrap console.* and forward via JS channel
  /// - [consoleChannelName]: JS channel name (defaults to 'ConsoleLog')
  static List<PageInjectionStrategy> resolve({
    List<PageInjectionStrategy> custom = const [],
    MediaQueryMetrics? mediaQueryMetricsData,
    Map<String, String>? deviceInfoData,
    bool includeConsoleLogging = true,
  }) {
    final strategies = <PageInjectionStrategy>[];

    // Should be included first to capture logs from other injections.
    if (includeConsoleLogging) {
      strategies.add(consoleLogging());
    }

    if (mediaQueryMetricsData != null) {
      strategies.add(mediaQuery(mediaQueryMetricsData));
    }

    if (deviceInfoData != null) {
      strategies.add(deviceInfo(deviceInfoData));
    }

    strategies.addAll(custom);

    return strategies;
  }

  /// Creates a [PageInjectionStrategy] from an **arbitrary payload map**.
  ///
  /// Useful when you want to pass custom structured data
  /// into the WebView without creating a new strategy type.
  static PageInjectionStrategy payload(Map<String, dynamic> payload, {String functionName = 'onPayloadDataReady'}) {
    return DefaultPayloadInjectionStrategy(functionName: functionName, initialPayload: payload);
  }
}
