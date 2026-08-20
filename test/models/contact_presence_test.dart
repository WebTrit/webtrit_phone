import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/models/models.dart';

DialogInfo _dialog(DialogState state) => DialogInfo(
  id: 'dlg-${state.name}',
  entityNumber: '555002',
  state: state,
  callId: 'call-1',
  direction: DialogDirection.recipient,
  localTag: 'lt',
  localNumber: '555002',
  localDisplayName: null,
  remoteTag: 'rt',
  remoteNumber: '555003',
  remoteDisplayName: null,
  arrivalVersion: '1',
  arrivalTime: DateTime(2026, 8, 19),
);

PresenceInfo _presence({required bool available, List<PresenceActivity> activities = const []}) => PresenceInfo(
  id: 'p1',
  number: '555002',
  available: available,
  note: '',
  statusIcon: null,
  device: null,
  timeOffsetMin: null,
  timestamp: null,
  activities: activities,
  source: PresenceInfoSource.direct,
  arrivalTime: DateTime(2026, 8, 19),
);

void main() {
  group('a contact is on a call', () {
    test('when the switch reports an established call', () {
      expect(
        ContactPresence.resolve(
          presenceInfo: [_presence(available: true)],
          dialogInfo: [_dialog(DialogState.confirmed)],
        ),
        ContactPresence.onCall,
      );
    });

    test('even when their published status says they are unreachable', () {
      expect(
        ContactPresence.resolve(
          presenceInfo: [_presence(available: false)],
          dialogInfo: [_dialog(DialogState.confirmed)],
        ),
        ContactPresence.onCall,
      );
    });

    test('NOT when the only sign is their own on-the-phone activity', () {
      // The server publishes that activity from the moment of dialling, so it
      // cannot tell a ringing phone from a conversation - it must not reach
      // the state that paints a contact as uncallable.
      expect(
        ContactPresence.resolve(
          presenceInfo: [
            _presence(available: true, activities: const [PresenceActivity.onThePhone]),
          ],
          dialogInfo: const [],
        ),
        ContactPresence.available,
      );
    });
  });

  group('a contact asks not to be called', () {
    for (final activity in [PresenceActivity.doNotDisturb, PresenceActivity.busy]) {
      test('${activity.name} makes them busy', () {
        expect(
          ContactPresence.resolve(
            presenceInfo: [
              _presence(available: true, activities: [activity]),
            ],
            dialogInfo: const [],
          ),
          ContactPresence.busy,
        );
      });
    }

    test('and stays busy even when they publish themselves as unreachable', () {
      expect(
        ContactPresence.resolve(
          presenceInfo: [
            _presence(available: false, activities: const [PresenceActivity.doNotDisturb]),
          ],
          dialogInfo: const [],
        ),
        ContactPresence.busy,
      );
    });

    test('while an activity that is merely elsewhere leaves them available', () {
      expect(
        ContactPresence.resolve(
          presenceInfo: [
            _presence(available: true, activities: const [PresenceActivity.vacation]),
          ],
          dialogInfo: const [],
        ),
        ContactPresence.available,
      );
    });
  });

  group('a ringing phone is not a call', () {
    for (final state in [DialogState.trying, DialogState.proceeding, DialogState.early]) {
      test('${state.name} leaves the contact available', () {
        expect(
          ContactPresence.resolve(presenceInfo: [_presence(available: true)], dialogInfo: [_dialog(state)]),
          ContactPresence.available,
        );
      });
    }

    test('a call that ended leaves the contact available', () {
      expect(
        ContactPresence.resolve(
          presenceInfo: [_presence(available: true)],
          dialogInfo: [_dialog(DialogState.terminated)],
        ),
        ContactPresence.available,
      );
    });
  });

  group('without a call', () {
    test('an available contact is available', () {
      expect(
        ContactPresence.resolve(presenceInfo: [_presence(available: true)], dialogInfo: const []),
        ContactPresence.available,
      );
    });

    test('a contact who published nothing is unavailable', () {
      expect(ContactPresence.resolve(presenceInfo: const [], dialogInfo: const []), ContactPresence.unavailable);
    });

    test('a contact who closed their presence is unavailable', () {
      expect(
        ContactPresence.resolve(presenceInfo: [_presence(available: false)], dialogInfo: const []),
        ContactPresence.unavailable,
      );
    });
  });
}
