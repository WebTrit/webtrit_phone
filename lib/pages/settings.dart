import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
            ),
            onPressed: () {
              BlocProvider.of<AppBloc>(context).add(AppUnregistered());
            },
          )
        ],
      ),
      body: Center(
        child: Icon(
          Icons.settings,
          size: 120,
        ),
      ),
    );
  }
}
