import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

import '../bloc/embedded_cubit.dart';
import 'embedded_screen.dart';

@RoutePage()
class EmbeddedScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const EmbeddedScreenPage({
    required this.data,
  });

  final EmbeddedData data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmbeddedCubit(),
      child: EmbeddedScreen(
        initialUri: data.uri,
        appBar: AppBar(
          leading: const AutoLeadingButton(),
          title: Text(context.parseL10n(data.titleL10n!)),
        ),
      ),
    );
  }
}
