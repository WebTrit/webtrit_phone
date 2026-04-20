import 'dart:convert';

import 'package:test/test.dart';

import 'package:webtrit_signaling/src/events/events.dart';
import 'package:webtrit_signaling/src/handshakes/handshakes.dart';

void main() {
  final stateHandshakeJson = '''
  {
    "handshake": "state",
    "keepalive_interval": 30000,
    "timestamp": 1662114679648,
    "registration": {
      "status": "registered"
    },
    "lines": [
      {
        "call_id": "qwertyuiopasdfghjklzxcvbnm",
        "call_logs": [
          [
            1662114479751,
            {
              "event": "incoming_call",
              "transaction": "transaction-1",
              "callee": "123",
              "caller": "456"
            }
          ]
        ]
      },
      null,
      null
    ]
  }
  ''';

  final stateHandshake = StateHandshake(
    keepaliveInterval: Duration(seconds: 30),
    timestamp: 1662114679648,
    registration: Registration(status: RegistrationStatus.registered),
    lines: [
      Line(
        callId: 'qwertyuiopasdfghjklzxcvbnm',
        callLogs: [
          CallEventLog(
            timestamp: 1662114479751,
            callEvent: IncomingCallEvent(
              transaction: 'transaction-1',
              line: 0,
              callId: 'qwertyuiopasdfghjklzxcvbnm',
              callee: '123',
              caller: '456',
            ),
          ),
        ],
      ),
      null,
      null,
    ],
    presenceInfos: [],
    dialogInfos: [],
    guestLine: null,
  );

  test('$StateHandshake fromJson', () {
    expect(StateHandshake.fromJson(json.decode(stateHandshakeJson) as Map<String, dynamic>), equals(stateHandshake));
  });

  test('$StateHandshake fromJson with dialog_infos state "trying" does not throw', () {
    final jsonWithTrying =
        json.decode('''
    {
      "handshake": "state",
      "keepalive_interval": 30000,
      "timestamp": 1662114679648,
      "registration": {"status": "registered"},
      "lines": [null, null],
      "dialog_infos": [{
        "id": "dlg-1",
        "entity_number": "124111",
        "state": "trying",
        "call_id": "abc123",
        "direction": "recipient",
        "arrival_version": "1",
        "arrival_time": "2026-04-19T16:07:00.000000Z"
      }],
      "presence_infos": [],
      "guest_line": {"call_id": null, "call_logs": []}
    }
    ''')
            as Map<String, dynamic>;

    expect(() => StateHandshake.fromJson(jsonWithTrying), returnsNormally);

    final result = StateHandshake.fromJson(jsonWithTrying);
    expect(result.dialogInfos.length, equals(1));
    expect(result.dialogInfos.first.state, equals(SignalingDialogState.trying));
  });

  test('$StateHandshake fromJson with unknown dialog_infos state falls back to unknown', () {
    final jsonWithUnknown =
        json.decode('''
    {
      "handshake": "state",
      "keepalive_interval": 30000,
      "timestamp": 1662114679648,
      "registration": {"status": "registered"},
      "lines": [null, null],
      "dialog_infos": [{
        "id": "dlg-2",
        "entity_number": "124111",
        "state": "some_future_state",
        "call_id": null,
        "direction": null,
        "arrival_version": "1",
        "arrival_time": "2026-04-19T16:07:00.000000Z"
      }],
      "presence_infos": [],
      "guest_line": {"call_id": null, "call_logs": []}
    }
    ''')
            as Map<String, dynamic>;

    final result = StateHandshake.fromJson(jsonWithUnknown);
    expect(result.dialogInfos.first.state, equals(SignalingDialogState.unknown));
  });

  test('$StateHandshake fromJson with null dialog_infos state falls back to unknown', () {
    final jsonWithNull =
        json.decode('''
    {
      "handshake": "state",
      "keepalive_interval": 30000,
      "timestamp": 1662114679648,
      "registration": {"status": "registered"},
      "lines": [null, null],
      "dialog_infos": [{
        "id": "dlg-3",
        "entity_number": "124111",
        "state": null,
        "call_id": null,
        "direction": null,
        "arrival_version": "1",
        "arrival_time": "2026-04-19T16:07:00.000000Z"
      }],
      "presence_infos": [],
      "guest_line": {"call_id": null, "call_logs": []}
    }
    ''')
            as Map<String, dynamic>;

    final result = StateHandshake.fromJson(jsonWithNull);
    expect(result.dialogInfos.first.state, equals(SignalingDialogState.unknown));
  });
}
