import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../bloc/embedded_cubit.dart';

class EmbeddedScreen extends StatelessWidget {
  const EmbeddedScreen({
    super.key,
    required this.initialUri,
    required this.appBar,
  });

  final Uri initialUri;

  final PreferredSizeWidget appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: BlocBuilder<EmbeddedCubit, EmbeddedState>(
        builder: (context, state) => Stack(
          children: [
            if (state.status == EmbeddedStateStatus.ready)
              WebViewScaffold(
                initialUri: initialUri,
                showToolbar: false,
                userAgent: UserAgent.of(context),
                injectedScriptBuilder: () => _buildInjectedScript(state.payload),
              )
          ],
        ),
      ),
    );
  }

  Future<String> _buildInjectedScript(Map<String, dynamic> data) async {
    final jsonString = const JsonEncoder().convert(data);
    return '''
    if (typeof window.onPayloadDataReady === 'function') {
      window.onPayloadDataReady($jsonString);
    }
  ''';
  }
}
