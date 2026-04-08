import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:webtrit_signaling_service/webtrit_signaling_service.dart';

// ---------------------------------------------------------------------------
// Config fixture -- intentionally invalid URL so the WebSocket fails fast
// without needing a real server.
// ---------------------------------------------------------------------------

const _kConfig = SignalingServiceConfig(
  coreUrl: 'wss://127.0.0.1:1',
  tenantId: 'integration-test',
  token: 'test-token',
);

// ---------------------------------------------------------------------------

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late WebtritSignalingService service;

  setUp(() {
    service = WebtritSignalingService(config: _kConfig);
  });

  tearDown(() async {
    await service.dispose().timeout(const Duration(seconds: 15));
  });

  // -------------------------------------------------------------------------
  // connect()
  // -------------------------------------------------------------------------

  group('Lifecycle -- connect()', () {
    testWidgets('connect() does not throw', (WidgetTester _) async {
      expect(() => service.connect(), returnsNormally);
    });

    testWidgets('persistent mode does not throw', (WidgetTester _) async {
      final s = WebtritSignalingService(config: _kConfig, mode: SignalingServiceMode.persistent);
      addTearDown(() => s.dispose());
      expect(() => s.connect(), returnsNormally);
    });

    testWidgets('pushBound mode does not throw', (WidgetTester _) async {
      final s = WebtritSignalingService(config: _kConfig, mode: SignalingServiceMode.pushBound);
      addTearDown(() => s.dispose());
      expect(() => s.connect(), returnsNormally);
    });

    testWidgets('calling connect() multiple times is idempotent', (WidgetTester _) async {
      service.connect();
      service.connect();
      service.connect();
      // No throw, no hang.
    });
  });

  // -------------------------------------------------------------------------
  // attach()
  // -------------------------------------------------------------------------

  group('Lifecycle -- attach()', () {
    testWidgets('attach() completes without error before connect()', (WidgetTester _) async {
      await expectLater(WebtritSignalingService.attach(), completes);
    });

    testWidgets('attach() completes without error after connect()', (WidgetTester _) async {
      service.connect();
      await Future<void>.delayed(const Duration(milliseconds: 300));
      await expectLater(WebtritSignalingService.attach(), completes);
    });
  });

  // -------------------------------------------------------------------------
  // dispose()
  // -------------------------------------------------------------------------

  group('Lifecycle -- dispose()', () {
    testWidgets('dispose() before connect() completes without error', (WidgetTester _) async {
      await expectLater(service.dispose(), completes);
    });

    testWidgets('dispose() after connect() completes without error', (WidgetTester _) async {
      service.connect();
      await Future<void>.delayed(const Duration(milliseconds: 300));
      await expectLater(service.dispose(), completes);
    });

    testWidgets('second dispose() completes without error', (WidgetTester _) async {
      await service.dispose();
      await expectLater(service.dispose(), completes);
    });
  });

  // -------------------------------------------------------------------------
  // restart cycle
  // -------------------------------------------------------------------------

  group('Lifecycle -- restart cycle', () {
    testWidgets('fresh instance after dispose() works without error', (WidgetTester _) async {
      service.connect();
      await Future<void>.delayed(const Duration(milliseconds: 300));
      await service.dispose();

      // Replace with a fresh instance; tearDown will dispose it.
      service = WebtritSignalingService(config: _kConfig);
      expect(() => service.connect(), returnsNormally);
    });

    testWidgets('two full create/connect/dispose cycles complete without error', (WidgetTester _) async {
      for (var i = 0; i < 2; i++) {
        final s = WebtritSignalingService(config: _kConfig);
        s.connect();
        await Future<void>.delayed(const Duration(milliseconds: 200));
        await s.dispose();
      }
      // setUp-created service is still alive for tearDown.
    });
  });
}
