import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../bloc/embaded_cubit.dart';

class EmbeddedScreen extends StatelessWidget {
  const EmbeddedScreen({
    super.key,
    required this.initialUri,
    required this.title,
  });

  final Uri initialUri;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: title,
      ),
      body: BlocBuilder<EmbadedCubit, EmbadedState>(
        builder: (context, state) => WebViewScaffold(
          initialUri: initialUri,
          showToolbar: false,
        ),
      ),
    );
  }
}
