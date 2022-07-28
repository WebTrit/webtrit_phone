import 'package:flutter/material.dart';

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
    return (ScaffoldMessenger.of(this)..removeCurrentSnackBar()).showSnackBar(SnackBar(
      content: Text(data),
      action: action,
      backgroundColor: Theme.of(this).colorScheme.error,
    ));
  }
}
