import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import '../models/models.dart';
import 'error_details_screen.dart';

@RoutePage()
class ErrorDetailsScreenPage extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  ErrorDetailsScreenPage({required this.title, required this.fields});

  final String title;
  final List<ErrorFieldModel> fields;

  @override
  Widget build(BuildContext context) {
    return ErrorDetailsScreen(title: title, fields: fields);
  }
}
