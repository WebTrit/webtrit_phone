import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../bloc/embedded_cubit.dart';
import '../utils/utils.dart';

import 'embedded_screen.dart';

final _logger = Logger('EmbeddedScreenPage');

@RoutePage()
class EmbeddedScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const EmbeddedScreenPage({
    required this.data,
  });

  final EmbeddedData data;

  @override
  Widget build(BuildContext context) {
    final selfConfigRepository = context.readOrNull<CustomPrivateGatewayRepository>();
    final secureStorage = context.read<SecureStorage>();

    if (selfConfigRepository == null) {
      _logger.fine(
          'SelfConfigRepository not found in the widget tree; skipping all injections such as external page token');
    }

    final embeddedPayloadBuilder = EmbeddedPayloadBuilder(secureStorage);

    return BlocProvider(
      create: (context) => EmbeddedCubit(
        customPrivateGatewayRepository: selfConfigRepository,
        embeddedPayloadBuilder: embeddedPayloadBuilder,
        payload: data.payload,
      ),
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
