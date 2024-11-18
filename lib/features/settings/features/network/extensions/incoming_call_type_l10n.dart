import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import 'package:webtrit_phone/models/models.dart';

extension IncomingCallTypeL10n on IncomingCallType {
  String titleL10n(BuildContext context) {
    return switch (this) {
      IncomingCallType.pushNotification => context.l10n.settings_network_incomingCallType_pushNotification_title,
      IncomingCallType.socket => context.l10n.settings_network_incomingCallType_socket_title,
    };
  }

  String descriptionL10n(BuildContext context) {
    return switch (this) {
      IncomingCallType.pushNotification => context.l10n.settings_network_incomingCallType_pushNotification_description,
      IncomingCallType.socket => context.l10n.settings_network_incomingCallType_socket_description,
    };
  }
}
