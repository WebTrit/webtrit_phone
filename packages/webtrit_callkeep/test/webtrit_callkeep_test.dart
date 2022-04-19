import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';

void main() {
  const MethodChannel channel = MethodChannel('webtrit_callkeep');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await WebtritCallkeep.platformVersion, '42');
  });
}
