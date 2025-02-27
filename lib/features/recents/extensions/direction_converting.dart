import 'package:flutter/material.dart';

import 'package:webtrit_phone/models/models.dart';

extension DirectionConverting on CallDirection {
  IconData icon(bool isComplete) {
    switch (this) {
      case CallDirection.incoming:
        return isComplete ? Icons.call_received : Icons.call_missed;
      case CallDirection.outgoing:
        return isComplete ? Icons.call_made : Icons.call_missed_outgoing;
    }
  }
}
