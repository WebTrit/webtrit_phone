import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/data/data.dart';

class MockSecureStorage extends Mock implements SecureStorage {
  MockSecureStorage() {
    when(() => deleteExternalPageTokenData()).thenAnswer((_) async {});
  }
}
