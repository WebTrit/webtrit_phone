import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/services.dart';
import 'package:webtrit_phone/app/assets.gen.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

import 'login_embedded_screen.dart';

@RoutePage()
class LoginEmbeddedScreenPage extends StatelessWidget {
  const LoginEmbeddedScreenPage({
    required this.loginEmbedded,
    Key? key,
  }) : super(key: key);

  final LoginEmbedded loginEmbedded;

  Future<String> _loadHtml() async {
    return await rootBundle.loadString(Assets.html.index);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _loadHtml(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final html = snapshot.data!;
          return BlocProvider(
            create: (context) => LoginEmbeddedCubit(
              context.read<NotificationsBloc>(),
              context.read<LoginCubit>(),
            ),
            child: LoginEmbeddedScreen(
              title: loginEmbedded.titleL10n != null ? context.parseL10n(loginEmbedded.titleL10n!) : null,
              initialUrl: Uri.dataFromString(
                html,
                mimeType: 'text/html',
                encoding: Encoding.getByName('utf-8'),
              ),
              showToolbar: loginEmbedded.showToolbar,
            ),
          );
        } else {
          return const Center(child: Text('Unexpected error'));
        }
      },
    );
  }
}
