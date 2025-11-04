import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:share_plus/share_plus.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../models/models.dart';

class ErrorDetailsScreen extends StatelessWidget {
  const ErrorDetailsScreen({required this.title, required this.fields, super.key});

  final String title;
  final List<ErrorFieldModel> fields;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: shareError,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: fields.length,
              itemBuilder: (context, index) {
                return CopyToClipboard(
                  data: fields[index].details,
                  child: ListTile(
                    title: Text(fields[index].title),
                    subtitle: Text(fields[index].details),
                  ),
                );
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.aod_outlined),
            title: Text(context.l10n.settings_ListViewTileTitle_logRecordsConsole),
            trailing: const Icon(Icons.navigate_next),
            onTap: () => context.router.push(const LogRecordsConsoleScreenPageRoute()),
          ),
        ],
      ),
    );
  }

  void shareError() {
    final text = '$title\n${fields.map((field) => '${field.title}: ${field.details}').join('\n')}';
    SharePlus.instance.share(ShareParams(text: text, title: 'Error details'));
  }
}
