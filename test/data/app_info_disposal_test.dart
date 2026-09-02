import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/startup_wave.dart';
import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/data.dart';

class _DisposableAppIdProvider implements AppIdProvider, Disposable {
  final controller = StreamController<String>.broadcast();
  var disposed = false;

  @override
  Future<String> getId() async => 'app-id';

  @override
  Stream<String> get onIdChange => controller.stream;

  @override
  Future<void> dispose() async {
    disposed = true;
    await controller.close();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('dispose releases the app-id subscription and provider', () async {
    final provider = _DisposableAppIdProvider();
    final appInfo = await AppInfo.init(provider);

    await appInfo.dispose();

    expect(provider.disposed, isTrue);
    expect(provider.controller.hasListener, isFalse);
  });

  test('startup wave rolls AppInfo back when a sibling fails', () async {
    final provider = _DisposableAppIdProvider();
    final appInfo = await AppInfo.init(provider);

    await expectLater(
      settleStartupWave([
        StartupOperation(Future.value(appInfo)),
        StartupOperation(Future<Object>.error(StateError('failed'))),
      ]),
      throwsStateError,
    );

    expect(provider.disposed, isTrue);
    expect(provider.controller.hasListener, isFalse);
  });
}
