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

    test('only REPORTEDLY when the sign is their own on-the-phone activity', () {
      // The server publishes that activity from the moment of dialling, so it
      // cannot tell a ringing phone from a conversation - it is worth showing,
      // but it must not reach the state that paints a contact as uncallable.
      expect(
        ContactPresence.resolve(
          presenceInfo: [
            _presence(available: true, activities: const [PresenceActivity.onThePhone]),
          ],
          dialogInfo: const [],
        ),
        ContactPresence.onCallReported,
      );
    });

    test('and a proven call outranks what they published about themselves', () {
      expect(
        ContactPresence.resolve(
          presenceInfo: [
            _presence(available: true, activities: const [PresenceActivity.vacation]),
          ],
          dialogInfo: [_dialog(DialogState.confirmed)],
        ),
        ContactPresence.onCall,
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

    test('while an activity that is merely elsewhere is not that', () {
      expect(
        ContactPresence.resolve(
          presenceInfo: [
            _presence(available: true, activities: const [PresenceActivity.vacation]),
          ],
          dialogInfo: const [],
        ),
        ContactPresence.away,
      );
    });
  });

  group('a contact who is simply elsewhere', () {
    const elsewhere = [
      PresenceActivity.away,
      PresenceActivity.sleeping,
      PresenceActivity.permanentAbsence,
      PresenceActivity.meal,
      PresenceActivity.meeting,
      PresenceActivity.appointment,
      PresenceActivity.vacation,
      PresenceActivity.travel,
      PresenceActivity.inTransit,
    ];

    for (final activity in elsewhere) {
      test('${activity.name} lands in one class, whatever the mark can draw', () {
        expect(
          ContactPresence.resolve(
            presenceInfo: [
              _presence(available: true, activities: [activity]),
            ],
            dialogInfo: const [],
          ),
          ContactPresence.away,
        );
      });
    }

    test('and says so even while publishing themselves as unreachable', () {
      // Saying WHY they are absent is more use than the bare fact of it, so
      // the activity outranks the flag here. Either way the mark stays quiet:
      // this class takes the same colour as plain unavailable and differs by
      // its glyph, see the badge.
      expect(
        ContactPresence.resolve(
          presenceInfo: [
            _presence(available: false, activities: const [PresenceActivity.sleeping]),
          ],
          dialogInfo: const [],
        ),
        ContactPresence.away,
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
