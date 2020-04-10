import 'package:flutter/material.dart';

mixin PageSnackBarMixin {
  void hideSnackBar(BuildContext context) {
    Scaffold.of(context)..removeCurrentSnackBar();
  }

  void showSnackBar(BuildContext context, String data) {
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Text(data),
      ));
  }

  void showErrorSnackBar(BuildContext context, String data) {
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        backgroundColor: Colors.red[900],
        content: Text(data),
      ));
  }
}
