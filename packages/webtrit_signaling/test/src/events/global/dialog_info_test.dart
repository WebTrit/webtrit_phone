import 'package:test/test.dart';

import 'package:webtrit_signaling/src/events/global/dialog_info.dart';

void main() {
  Map<String, dynamic> baseJson({required String state, String? direction}) => {
    'id': 'dlg-1',
    'entity_number': '124111',
    'state': state,
    'call_id': 'abc123',
    'direction': direction,
    'arrival_version': '1',
    'arrival_time': '2026-04-19T16:07:00.000000Z',
  };

  group('SignalingDialogState parsing', () {
    test('parses "trying" → SignalingDialogState.trying', () {
      final info = SignalingDialogInfo.fromJson(baseJson(state: 'trying'));
      expect(info.state, SignalingDialogState.trying);
    });

    test('parses "proceeding" → SignalingDialogState.proceeding', () {
      final info = SignalingDialogInfo.fromJson(baseJson(state: 'proceeding'));
      expect(info.state, SignalingDialogState.proceeding);
    });

    test('parses "early" → SignalingDialogState.early', () {
      final info = SignalingDialogInfo.fromJson(baseJson(state: 'early'));
      expect(info.state, SignalingDialogState.early);
    });

    test('parses "confirmed" → SignalingDialogState.confirmed', () {
      final info = SignalingDialogInfo.fromJson(baseJson(state: 'confirmed'));
      expect(info.state, SignalingDialogState.confirmed);
    });

    test('parses "terminated" → SignalingDialogState.terminated', () {
      final info = SignalingDialogInfo.fromJson(baseJson(state: 'terminated'));
      expect(info.state, SignalingDialogState.terminated);
    });

    test('unknown future state falls back to SignalingDialogState.unknown', () {
      final info = SignalingDialogInfo.fromJson(baseJson(state: 'some_future_state'));
      expect(info.state, SignalingDialogState.unknown);
    });

    test('null state falls back to SignalingDialogState.unknown', () {
      final json = baseJson(state: 'placeholder')..['state'] = null;
      final info = SignalingDialogInfo.fromJson(json);
      expect(info.state, SignalingDialogState.unknown);
    });
  });

  group('SignalingDialogDirection parsing', () {
    test('parses "initiator" → SignalingDialogDirection.initiator', () {
      final info = SignalingDialogInfo.fromJson(baseJson(state: 'confirmed', direction: 'initiator'));
      expect(info.direction, SignalingDialogDirection.initiator);
    });

    test('parses "recipient" → SignalingDialogDirection.recipient', () {
      final info = SignalingDialogInfo.fromJson(baseJson(state: 'confirmed', direction: 'recipient'));
      expect(info.direction, SignalingDialogDirection.recipient);
    });

    test('unknown direction falls back to null', () {
      final info = SignalingDialogInfo.fromJson(baseJson(state: 'confirmed', direction: 'unknown_direction'));
      expect(info.direction, isNull);
    });

    test('null direction → null', () {
      final info = SignalingDialogInfo.fromJson(baseJson(state: 'confirmed'));
      expect(info.direction, isNull);
    });
  });
}
