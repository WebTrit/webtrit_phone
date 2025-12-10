import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_api/webtrit_api.dart';
import 'package:webtrit_phone/blocs/microphone_status/microphone_status_bloc.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

import '../settings.dart';

class SessionStatusListTile extends StatelessWidget {
  const SessionStatusListTile({super.key, required this.status, this.info, this.onTap, this.contentPadding});

  final SessionStatus status;
  final UserInfo? info;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: onTap,
          child: Column(
            children: [
              ListTile(
                contentPadding: contentPadding,
                leading: CircleAvatar(
                  radius: 12,
                  backgroundColor: themeData.colorScheme.surface.withValues(alpha: 0.5),
                  child: CircleAvatar(radius: 4, backgroundColor: status.color(context)),
                ),
                title: Text(status.l10n(context), key: status.key, style: themeData.textTheme.labelLarge),
                trailing: const Icon(Icons.arrow_right),
              ),
              BlocBuilder<MicrophoneStatusBloc, MicrophoneStatusState>(
                builder: (context, microphoneStatusState) {
                  return Visibility(
                    visible: microphoneStatusState.microphonePermissionGranted != null &&
                        !microphoneStatusState.microphonePermissionGranted!,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: ShapeDecoration(color: Theme.of(context).colorScheme.error, shape: StadiumBorder()),
                      child: Row(
                        spacing: 5,
                        children: [
                          Icon(Icons.warning_amber, color: Colors.white, size: 14,),
                          Flexible(
                            child: Text(
                              context.l10n.settings_missingMicrophoneIndicator_title,
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
