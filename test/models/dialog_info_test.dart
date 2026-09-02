import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/models/models.dart';

DialogInfo _dialog({DialogState state = DialogState.confirmed, String id = 'dlg-1', bool? hasVideo}) => DialogInfo(
  id: id,
  entityNumber: '111000333',
  state: state,
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
      expect(_dialog(hasVideo: false).pullable, isTrue);
    });

    test('unknown media (hasVideo null) is pullable', () {
      expect(_dialog(hasVideo: null).pullable, isTrue);
    });

    test('video dialog (hasVideo true) is pullable (offer carries an inactive video m-line)', () {
      expect(_dialog(hasVideo: true).pullable, isTrue);
    });

    test('hasVideo does not override the other pullable preconditions', () {
      // Not confirmed -> never pullable, regardless of media type.
      expect(_dialog(state: DialogState.early, id: 'dlg-2', hasVideo: false).pullable, isFalse);
    });
  });

  group('a conversation, as opposed to a ringing phone', () {
    test('an answered call is established', () {
      expect(_dialog(state: DialogState.confirmed).isEstablished, isTrue);
    });

    for (final state in [DialogState.trying, DialogState.proceeding, DialogState.early]) {
      test('a call that is still ringing (${state.name}) is not', () {
        expect(_dialog(state: state).isEstablished, isFalse);
      });
    }

    for (final state in [DialogState.terminated, DialogState.unknown]) {
      test('a call in state ${state.name} is not', () {
        expect(_dialog(state: state).isEstablished, isFalse);
      });
    }
  });

  group('the established call of a contact', () {
    test('is the answered one, not whichever arrived first', () {
      final dialogs = [
        _dialog(state: DialogState.early, id: 'ringing'),
        _dialog(state: DialogState.confirmed, id: 'answered'),
      ];

      expect(dialogs.established?.id, 'answered');
    });

    test('is nothing while every call is still ringing', () {
      expect([_dialog(state: DialogState.early)].established, isNull);
    });

    test('is nothing when the contact has no calls at all', () {
      expect(const <DialogInfo>[].established, isNull);
    });
  });
}
