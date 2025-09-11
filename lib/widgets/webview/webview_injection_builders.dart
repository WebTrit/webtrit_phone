import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';

import 'web_view_container.dart';

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
    BuildContext context, {
    String functionName = 'onMediaQueryReady',
  }) {
    final mq = MediaQuery.of(context);
    final theme = Theme.of(context);

    final payload = <String, dynamic>{
      'brightness': theme.brightness.name,
      'devicePixelRatio': mq.devicePixelRatio,
      'topSafeInset': mq.viewPadding.top.round(),
      'bottomSafeInset': mq.viewPadding.bottom.round(),
    };

    return DefaultPayloadInjectionStrategy(
      functionName: functionName,
      initialPayload: payload,
    );
  }

  /// Creates a [PageInjectionStrategy] that injects **device labels**
  /// (from [AppLabelsProvider]) and optional `urls` into the WebView.
  ///
  /// This strategy is asynchronous because it may query storage
  /// or system services to build the labels.
  static PageInjectionStrategy deviceInfo(
    BuildContext context, {
    String functionName = 'onDeviceInfoReady',
  }) {
    final labels = context.read<AppLabelsProvider>().build();

    return DefaultPayloadInjectionStrategy(
      functionName: functionName,
      initialPayload: labels,
    );
  }

  /// Factory that returns a list of [PageInjectionStrategy] including
  /// optional defaults based on flags.
  ///
  /// - [includeMediaQuery]: inject MediaQuery/theme data
  /// - [includeDeviceInfo]: inject device/app info + optional URLs
  static List<PageInjectionStrategy> resolve(
    BuildContext context, {
    List<PageInjectionStrategy> custom = const [],
    bool includeMediaQuery = true,
    bool includeDeviceInfo = true,
  }) {
    final strategies = <PageInjectionStrategy>[];

    strategies.addAll(custom);

    if (includeMediaQuery) {
      strategies.add(mediaQuery(context));
    }

    if (includeDeviceInfo) {
      strategies.add(deviceInfo(context));
    }

    return strategies;
  }

  /// Creates a [PageInjectionStrategy] from an **arbitrary payload map**.
  ///
  /// Useful when you want to pass custom structured data
  /// into the WebView without creating a new strategy type.
  static PageInjectionStrategy payload(
    Map<String, dynamic> payload, {
    String functionName = 'onPayloadDataReady',
  }) {
    return DefaultPayloadInjectionStrategy(
      functionName: functionName,
      initialPayload: payload,
    );
  }
}
