import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ExtAppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.exit_to_app,
            ),
            onPressed: () async {
              if (await _confirmUnregister(context) == true) {
                // TODO: move logout logic to some bloc
                final token = await SecureStorage().readToken();
                if (token != null) {
                  await SecureStorage().deleteToken();
                  final webtritApiClient = context.read<WebtritApiClient>();
                  await webtritApiClient.sessionLogout(token);
                }

                context.read<AppBloc>().add(const AppUnregistered());
              }
            },
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Form(
            child: FutureBuilder(
              future: SecureStorage().readWebRegistrationInitialUrl(),
              builder: (context, AsyncSnapshot<String?> snapshot) {
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
                        decoration: const InputDecoration(
                          labelText: 'Registration initial url',
                          helperText: '', // reserve space for validator message
                        ),
                        onFieldSubmitted: (_) async {
                          final fromState = Form.of(context)!;
                          if (fromState.validate()) {
                            fromState.save();
                            await SecureStorage().writeWebRegistrationInitialUrl(webRegistrationInitialUrl!);
                            context.showSnackBar('Registration initial url saved');
                          }
                        },
                        onSaved: (value) {
                          webRegistrationInitialUrl = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
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
                                    final fromState = Form.of(context)!;
                                    if (fromState.validate()) {
                                      fromState.save();
                                      await SecureStorage().writeWebRegistrationInitialUrl(webRegistrationInitialUrl!);
                                      context.showSnackBar('Registration initial url saved');
                                    }
                                  },
                          ),
                          TextButton(
                            child: Text('Delete'.toUpperCase()),
                            onPressed: !isDone
                                ? null
                                : () async {
                                    await SecureStorage().deleteWebRegistrationInitialUrl();
                                    context.showSnackBar('Registration initial url deleted');
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
          const SizedBox(
            height: 40,
          ),
          const Text('Current token:'),
          Container(
            alignment: Alignment.center,
            height: 50,
            child: FutureBuilder(
              future: SecureStorage().readToken(),
              builder: (context, AsyncSnapshot<String?> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final token = snapshot.data;
                  if (token != null) {
                    return Text(
                      snapshot.data!,
                      style: const TextStyle(fontSize: 20),
                    );
                  } else {
                    return const Text(
                      'empty',
                      style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                    );
                  }
                } else {
                  return const CircularProgressIndicator();
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
                  context.showSnackBar('Token deleted');
                  setState(() {});
                },
              );
            },
          ),
          const SizedBox(
            height: 40,
          ),
          TextButton(
            child: Text('Open OS App Settings'.toUpperCase()),
            onPressed: () async {
              await openAppSettings();
            },
          ),
          const SizedBox(
            height: 40,
          ),
          TextButton(
            child: Text('Open log records console'.toUpperCase()),
            onPressed: () {
              context.goNamed('log-records-console');
            },
          ),
        ],
      ),
    );
  }

  Future<bool?> _confirmUnregister(BuildContext context) {
    return showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm unregister"),
          content: const Text("Are you sure you want to unregister?"),
          actions: [
            // usually buttons at the bottom of the dialog
            TextButton(
              child: Text("No".toUpperCase()),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text("Yes".toUpperCase()),
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
