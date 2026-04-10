import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

class MockSmsRepository extends Mock implements SmsRepository {
  MockSmsRepository() {
    when(() => watchUserSmsNumbers()).thenAnswer((_) => const Stream.empty());
  }
}
