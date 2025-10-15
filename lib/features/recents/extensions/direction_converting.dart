import 'package:flutter/material.dart';

import 'package:webtrit_phone/models/models.dart';

// TODO: move file to app level for adequate reuse in call log and recents
extension DirectionConverting on CallDirection {
  IconData icon(bool isComplete) {
    switch (this) {
      case CallDirection.incoming:
        return isComplete ? Icons.call_received : Icons.call_missed;
      case CallDirection.outgoing:
        return isComplete ? Icons.call_made : Icons.call_missed_outgoing;
      case CallDirection.forwarded:
        return isComplete ? Icons.call_merge : Icons.call_split;
    }
  }
}
