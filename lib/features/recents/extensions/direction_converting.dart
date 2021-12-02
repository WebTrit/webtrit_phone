import 'package:flutter/material.dart';

import 'package:webtrit_phone/models/models.dart';

extension DirectionConverting on Direction {
  IconData icon(bool isComplete) {
    switch (this) {
      case Direction.incoming:
        return isComplete ? Icons.call_received : Icons.call_missed;
      case Direction.outgoing:
        return isComplete ? Icons.call_made : Icons.call_missed_outgoing;
      default:
        return Icons.close;
    }
  }
}
