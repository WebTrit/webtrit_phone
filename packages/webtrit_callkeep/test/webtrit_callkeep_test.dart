import 'package:flutter_test/flutter_test.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';

void main() {
  final callkeep = Callkeep();

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    callkeep.setUp(const CallkeepOptions(
      ios: CallkeepIOSOptions(localizedName: 'Test',
        maximumCallGroups: 1,
        maximumCallsPerCallGroup: 1,
        supportedHandleTypes: {CallkeepHandleType.number},
      ),
    ));
  });

  tearDown(() {
    callkeep.tearDown();
  });

  test('isSetUp', () async {
    expect(await callkeep.isSetUp(), true);
  });
}
