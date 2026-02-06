import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/blocs/app/app_bloc.dart';

final _logger = Logger('TeardownScreen');

class TeardownScreen extends StatefulWidget {
  const TeardownScreen({super.key});

  @override
  State<TeardownScreen> createState() => _TeardownScreenState();
}

class _TeardownScreenState extends State<TeardownScreen> {
  @override
  void initState() {
    super.initState();
    _logger.fine('TeardownScreen.initState');

    // Schedule the cleanup event after the widget is mounted.
    // Using addPostFrameCallback ensures the navigation transition
    // has definitely started processing.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _logger.fine('TeardownScreen.addPostFrameCallback');
        context.read<AppBloc>().add(AppCleanupRequested());
      } else {
        _logger.fine('TeardownScreen.addPostFrameCallback: widget is not mounted');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator(), SizedBox(height: 16), Text('Signing out...')],
        ),
      ),
    );
  }
}
