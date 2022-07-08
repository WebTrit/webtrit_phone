import 'package:flutter/material.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

class AccountInfoListTile extends StatelessWidget {
  const AccountInfoListTile({
    Key? key,
    this.info,
    this.onEditPressed,
  }) : super(key: key);

  final AccountInfo? info;
  final VoidCallback? onEditPressed;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final info = this.info;
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
      trailing: onEditPressed == null
          ? null
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: onEditPressed,
                ),
              ],
            ),
      isThreeLine: true,
    );
  }
}
