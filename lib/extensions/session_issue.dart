import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

extension SessionIssueSeverityColor on SessionIssueSeverity {
  // TODO(Serdun): Move to color scheme
  Color color(BuildContext context) {
    switch (this) {
      case SessionIssueSeverity.critical:
        return Colors.red;
      case SessionIssueSeverity.warning:
        return Colors.orange;
      case SessionIssueSeverity.info:
        return Colors.blueGrey;
    }
  }
}

extension SessionIssueL10n on SessionIssue {
  /// Short title shown where a single line is available (e.g. account row title).
  String title(BuildContext context) {
    switch (id) {
      case SessionIssueId.limitedStandaloneCallMode:
        // Same warning as the diagnostic calling-mode row - reuse its strings.
        return context.l10n.diagnostic_callingMode_standalone_title;
    }
  }

  /// One-line caption summarizing the issue (e.g. account row subtitle).
  String caption(BuildContext context) {
    switch (id) {
      case SessionIssueId.limitedStandaloneCallMode:
        return context.l10n.diagnostic_callingMode_standalone_caption;
    }
  }

  Color color(BuildContext context) => severity.color(context);
}
