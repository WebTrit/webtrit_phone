import 'package:flutter/widgets.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../models/models.dart';

extension IceConnectionIssueL10n on IceConnectionIssue {
  String l10n(BuildContext context) {
    switch (this) {
      case IceConnectionIssue.iceFail:
        return context.l10n.iceConnectionIssue_iceFail;
      case IceConnectionIssue.iceFailNoIcePath:
        return context.l10n.iceConnectionIssue_iceFailNoIcePath;
      case IceConnectionIssue.iceFailNoIcePathViaVpn:
        return context.l10n.iceConnectionIssue_iceFailNoIcePathViaVpn;
    }
  }
}
