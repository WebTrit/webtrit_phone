import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../utils/utils.dart';
import '../bloc/embedded_cubit.dart';

import 'embedded_screen.dart';

@RoutePage()
class EmbeddedTabPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const EmbeddedTabPage({
    @PathParam('id') required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    final bottomMenuManager = context.read<FeatureAccess>().bottomMenuFeature;
    final data = bottomMenuManager.getEmbeddedTabById(id);

    final selfConfigRepository = context.read<SelfConfigRepository>();
    final secureStorage = context.read<SecureStorage>();

    final embeddedPayloadBuilder = EmbeddedPayloadBuilder(secureStorage);

    return BlocProvider(
      create: (context) => EmbeddedCubit(
        payload: data.data!.payload,
        selfConfigRepository: selfConfigRepository,
        embeddedPayloadBuilder: embeddedPayloadBuilder,
      ),
      child: EmbeddedScreen(
        initialUri: data.data!.uri,
        appBar: AppBar(
          leading: const AutoLeadingButton(),
          title: Text(context.parseL10n(data.titleL10n)),
        ),
      ),
    );
  }
}
