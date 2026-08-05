import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../mocks/mocks.dart';

void main() {
  group('TranscriptionModelRepositoryPrefsImpl', () {
    test('returns null when nothing is stored', () {
      final repository = TranscriptionModelRepositoryPrefsImpl(MockAppPreferences());

      expect(repository.getTranscriptionModel(), isNull);
    });

    test('round-trips a tier selection', () async {
      final repository = TranscriptionModelRepositoryPrefsImpl(MockAppPreferences());

      await repository.setTranscriptionModel(const LocalTranscriptionModelTier('small'));

      expect(repository.getTranscriptionModel(), const LocalTranscriptionModelTier('small'));
    });

    test('round-trips the off selection', () async {
      final repository = TranscriptionModelRepositoryPrefsImpl(MockAppPreferences());

      await repository.setTranscriptionModel(const LocalTranscriptionModelOff());

      expect(repository.getTranscriptionModel(), const LocalTranscriptionModelOff());
    });

    test('setting null clears the stored value', () async {
      final repository = TranscriptionModelRepositoryPrefsImpl(MockAppPreferences());
      await repository.setTranscriptionModel(const LocalTranscriptionModelTier('small'));

      await repository.setTranscriptionModel(null);

      expect(repository.getTranscriptionModel(), isNull);
    });

    test('clear removes the stored value', () async {
      final repository = TranscriptionModelRepositoryPrefsImpl(MockAppPreferences());
      await repository.setTranscriptionModel(const LocalTranscriptionModelOff());

      await repository.clear();

      expect(repository.getTranscriptionModel(), isNull);
    });
  });
}
