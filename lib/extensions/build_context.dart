import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/theme/styles/styles.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

extension BuildContextSnackBar on BuildContext {
  void removeCurrentSnackBar() {
    ScaffoldMessenger.of(this).removeCurrentSnackBar();
  }

  void hideCurrentSnackBar() {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    String data, {
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 3),
  }) {
    return _show(content: data, action: action, duration: duration);
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrorSnackBar(
    String data, {
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 5),
  }) {
    final themeData = Theme.of(this);
    final callStatusStyles = themeData.extension<SnackBarStyles>()?.primary;

    return _show(
      content: data,
      action: action,
      duration: duration,
      backgroundColor: callStatusStyles?.errorBackgroundColor ?? themeData.colorScheme.error,
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showFloatingSnackBar(
    String data, {
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 1),
  }) {
    return _show(content: data, action: action, duration: duration, behavior: SnackBarBehavior.floating);
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSuccessSnackBar(
    String data, {
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 5),
  }) {
    final themeData = Theme.of(this);
    final callStatusStyles = themeData.extension<SnackBarStyles>()?.primary;

    return _show(
      content: data,
      action: action,
      duration: duration,
      backgroundColor: callStatusStyles?.successBackgroundColor ?? themeData.colorScheme.tertiary,
    );
  }

  /// Shows the one snack bar the app has, so every message is announced the
  /// same way and can be found by the same id.
  ///
  /// A message that offers something to do waits for the answer instead of
  /// timing out (and gets a close button, so it can always be dismissed):
  /// three seconds is not enough to notice an action, let alone to reach it
  /// with a screen reader.
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _show({
    required String content,
    required SnackBarAction? action,
    required Duration duration,
    Color? backgroundColor,
    SnackBarBehavior? behavior,
  }) {
    return (ScaffoldMessenger.of(this)..removeCurrentSnackBar()).showSnackBar(
      SnackBar(
        content: SemanticId(identifier: appSnackBarId, child: Text(content)),
        action: action,
        backgroundColor: backgroundColor,
        behavior: behavior,
        duration: duration,
        showCloseIcon: action != null,
      ),
    );
  }

  T? readOrNull<T>() {
    try {
      return read<T>();
    } on ProviderNotFoundException catch (_) {
      return null;
    }
  }
}
