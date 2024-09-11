import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';

import '../bloc/embaded_cubit.dart';

@RoutePage()
class TestScreenPage extends StatelessWidget {
  const TestScreenPage({
    required this.id,
  });

  final String? id;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('TestScreenPage: $id'),
    );
  }
}
