import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

import '../bloc/settings_bloc.dart';

class AccountInfoListTile extends StatelessWidget {
  const AccountInfoListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        final info = state.info;
        return ListTile(
          leading: LeadingAvatar(
            username: info != null ? '${info.firstname} ${info.lastname}' : '?',
            radius: 50,
          ),
          title: Text(
            info != null ? '${info.firstname} ${info.lastname}' : '',
            style: themeData.textTheme.bodyText1!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            info != null ? '${info.balance.toStringAsFixed(2)} ${info.currency}' : '',
            style: themeData.textTheme.button!.copyWith(
              color: themeData.textTheme.caption!.color,
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              IconButton(
                icon: Icon(Icons.edit_outlined),
                onPressed: null, // TODO implement edit account page
              ),
            ],
          ),
          isThreeLine: true,
        );
      },
    );
  }
}
