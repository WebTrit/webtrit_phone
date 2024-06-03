import 'package:flutter/material.dart';

import '../widgets/error_details_view.dart';

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

  @Deprecated('Use ErrorDetailsScreen instead')
  Future showErrorBottomSheetDialog(String title, List<ErrorFieldModel> fields) {
    return showModalBottomSheet(
      useSafeArea: true,
      context: this,
      builder: (context) => ErrorDetailsView(
        title: title,
        fields: fields,
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSuccessSnackBar(
    String data, {
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 5),
  }) {
    return (ScaffoldMessenger.of(this)..removeCurrentSnackBar()).showSnackBar(SnackBar(
      content: Text(data),
      action: action,
      backgroundColor: Theme.of(this).colorScheme.tertiary,
    ));
  }
}
