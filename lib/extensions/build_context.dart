import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/styles/styles.dart';

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
    return (ScaffoldMessenger.of(this)..removeCurrentSnackBar()).showSnackBar(SnackBar(
      content: Text(data),
      action: action,
      duration: duration,
    ));
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrorSnackBar(
    String data, {
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 5),
  }) {
    final themeData = Theme.of(this);
    final callStatusStyles = themeData.extension<SnackBarStyles>()?.primary;

    return (ScaffoldMessenger.of(this)..removeCurrentSnackBar()).showSnackBar(SnackBar(
      content: Text(data),
      action: action,
      backgroundColor: callStatusStyles?.errorBackgroundColor ?? themeData.colorScheme.error,
    ));
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showFloatingSnackBar(
    String data, {
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 1),
  }) {
    return (ScaffoldMessenger.of(this)..removeCurrentSnackBar()).showSnackBar(SnackBar(
      content: Text(data),
      behavior: SnackBarBehavior.floating,
      action: action,
      duration: duration,
    ));
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSuccessSnackBar(
    String data, {
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 5),
  }) {
    final themeData = Theme.of(this);
    final callStatusStyles = themeData.extension<SnackBarStyles>()?.primary;

    return (ScaffoldMessenger.of(this)..removeCurrentSnackBar()).showSnackBar(SnackBar(
      content: Text(data),
      action: action,
      backgroundColor: callStatusStyles?.successBackgroundColor ?? themeData.colorScheme.tertiary,
    ));
  }
}
