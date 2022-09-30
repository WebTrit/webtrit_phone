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
    registration: Registration(
      status: RegistrationStatus.registered,
    ),
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
  );

  test('$StateHandshake fromJson', () {
    expect(
      StateHandshake.fromJson(json.decode(stateHandshakeJson) as Map<String, dynamic>),
      equals(stateHandshake),
    );
  });
}
