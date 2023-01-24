import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../recents.dart';
import 'recents_scaffold.dart';

class RecentsScreen extends StatelessWidget {
  const RecentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = context.read<RecentsBloc>().state.filter;
    return RecentsScaffold(
      initialFilter: filter,
    );
  }
}
