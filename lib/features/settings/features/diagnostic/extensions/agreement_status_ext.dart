import 'package:flutter/material.dart';

import 'package:webtrit_phone/models/models.dart';

extension AgreementStatusExt on AgreementStatus {
  // TODO(Serdun): Move to color scheme
  Color get color {
    switch (this) {
      case AgreementStatus.accepted:
        return Colors.green;
      case AgreementStatus.declined:
        return Colors.redAccent;
      case AgreementStatus.pending:
        return Colors.yellow;
    }
  }

  IconData get icon {
    switch (this) {
      case AgreementStatus.accepted:
        return Icons.check_circle;
      case AgreementStatus.declined:
        return Icons.error_outline;
      case AgreementStatus.pending:
        return Icons.pending;
    }
  }
}
