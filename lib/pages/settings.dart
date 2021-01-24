import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class SettingsPage extends StatefulWidget with PageSnackBarMixin {
  const SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ExtAppBar(
        title: Text('Settings'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
            ),
            onPressed: () async {
              if (await _confirmUnregister(context)) {
                context.read<AppBloc>().add(AppUnregistered());
              }
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Current toke:'),
            Container(
              alignment: Alignment.center,
              height: 50,
              child: FutureBuilder(
                future: SecureStorage.readToken(),
                builder: (context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final token = snapshot.data;
                    if (token != null) {
                      return Text(
                        snapshot.data,
                        style: TextStyle(fontSize: 20),
                      );
                    } else {
                      return Text(
                        'empty',
                        style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                      );
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
            TextButton(
              child: Text('Delete token'.toUpperCase()),
              onPressed: () async {
                await SecureStorage.deleteToken();
                setState(() {});
              },
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _confirmUnregister(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Confirm unregister"),
          content: new Text("Are you sure you want to unregister?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("No".toUpperCase()),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            new TextButton(
              child: new Text("Yes".toUpperCase()),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
