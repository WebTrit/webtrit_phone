import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/models/models.dart';

DialogInfo _confirmed({bool? hasVideo}) => DialogInfo(
  id: 'dlg-1',
  entityNumber: '111000333',
  state: DialogState.confirmed,
  callId: 'call-1',
  direction: DialogDirection.initiator,
  localTag: 'lt',
  localNumber: '111000333',
  localDisplayName: null,
  remoteTag: 'rt',
  remoteNumber: '111000444',
  remoteDisplayName: null,
  arrivalVersion: '1',
  arrivalTime: DateTime(2026, 6, 24),
  hasVideo: hasVideo,
);

void main() {
  group('DialogInfo.pullable', () {
    test('audio dialog (hasVideo false) is pullable', () {
      expect(_confirmed(hasVideo: false).pullable, isTrue);
    });

    test('unknown media (hasVideo null) is pullable', () {
      expect(_confirmed(hasVideo: null).pullable, isTrue);
    });

    test('video dialog (hasVideo true) is pullable (offer carries an inactive video m-line)', () {
      expect(_confirmed(hasVideo: true).pullable, isTrue);
    });

    test('hasVideo does not override the other pullable preconditions', () {
      // Not confirmed -> never pullable, regardless of media type.
      final ringing = DialogInfo(
        id: 'dlg-2',
        entityNumber: '111000333',
        state: DialogState.early,
        callId: 'call-2',
        direction: DialogDirection.initiator,
        localTag: 'lt',
        localNumber: '111000333',
        localDisplayName: null,
        remoteTag: 'rt',
        remoteNumber: '111000444',
        remoteDisplayName: null,
        arrivalVersion: '1',
        arrivalTime: DateTime(2026, 6, 24),
        hasVideo: false,
      );
      expect(ringing.pullable, isFalse);
    });
  });
}
