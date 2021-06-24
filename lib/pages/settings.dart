import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with PageSnackBarMixin {
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
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Form(
            child: FutureBuilder(
              future: SecureStorage().readWebRegistrationInitialUrl(),
              builder: (context, AsyncSnapshot<String> snapshot) {
                final isDone = snapshot.connectionState == ConnectionState.done;
                var webRegistrationInitialUrl = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        key: ObjectKey(webRegistrationInitialUrl),
                        initialValue: webRegistrationInitialUrl,
                        decoration: InputDecoration(
                          labelText: 'Registration initial url',
                          helperText: '', // reserve space for validator message
                        ),
                        onFieldSubmitted: (_) async {
                          final fromState = Form.of(context);
                          if (fromState.validate()) {
                            fromState.save();
                            await SecureStorage().writeWebRegistrationInitialUrl(webRegistrationInitialUrl);
                            showSnackBar(context, 'Registration initial url saved');
                          }
                        },
                        onSaved: (value) {
                          webRegistrationInitialUrl = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter not empty url';
                          } else if (!RegExp(
                                  r'https?:\/\/[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)')
                              .hasMatch(value)) {
                            return 'Please enter valid url';
                          }
                          return null;
                        },
                        enabled: isDone,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            child: Text('Save'.toUpperCase()),
                            onPressed: !isDone
                                ? null
                                : () async {
                                    final fromState = Form.of(context);
                                    if (fromState.validate()) {
                                      fromState.save();
                                      await SecureStorage().writeWebRegistrationInitialUrl(webRegistrationInitialUrl);
                                      showSnackBar(context, 'Registration initial url saved');
                                    }
                                  },
                          ),
                          TextButton(
                            child: Text('Delete'.toUpperCase()),
                            onPressed: !isDone
                                ? null
                                : () async {
                                    await SecureStorage().deleteWebRegistrationInitialUrl();
                                    showSnackBar(context, 'Registration initial url deleted');
                                    setState(() {});
                                  },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text('Current token:'),
          Container(
            alignment: Alignment.center,
            height: 50,
            child: FutureBuilder(
              future: SecureStorage().readToken(),
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
          Builder(
            builder: (context) {
              return TextButton(
                child: Text('Delete token'.toUpperCase()),
                onPressed: () async {
                  await SecureStorage().deleteToken();
                  showSnackBar(context, 'Token deleted');
                  setState(() {});
                },
              );
            },
          ),
          SizedBox(
            height: 40,
          ),
          TextButton(
            child: Text('Open OS App Settings'.toUpperCase()),
            onPressed: () async {
              await openAppSettings();
            },
          ),
        ],
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
