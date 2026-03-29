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
    service = WebtritSignalingService();
  });

  tearDown(() async {
    await service.dispose().timeout(const Duration(seconds: 15));
  });

  // -------------------------------------------------------------------------
  // start()
  // -------------------------------------------------------------------------

  group('Lifecycle -- start()', () {
    testWidgets('completes without error', (WidgetTester _) async {
      await expectLater(service.start(_kConfig), completes);
    });

    testWidgets('accepts persistent mode', (WidgetTester _) async {
      await expectLater(service.start(_kConfig, mode: SignalingServiceMode.persistent), completes);
    });

    testWidgets('accepts pushBound mode', (WidgetTester _) async {
      await expectLater(service.start(_kConfig, mode: SignalingServiceMode.pushBound), completes);
    });

    testWidgets('calling start() twice replaces the session', (WidgetTester _) async {
      await service.start(_kConfig);
      await expectLater(service.start(_kConfig), completes);
    });
  });

  // -------------------------------------------------------------------------
  // attach()
  // -------------------------------------------------------------------------

  group('Lifecycle -- attach()', () {
    testWidgets('completes without error before start()', (WidgetTester _) async {
      await expectLater(service.attach(), completes);
    });

    testWidgets('completes without error after start()', (WidgetTester _) async {
      await service.start(_kConfig);
      await Future<void>.delayed(const Duration(milliseconds: 300));
      await expectLater(service.attach(), completes);
    });
  });

  // -------------------------------------------------------------------------
  // dispose()
  // -------------------------------------------------------------------------

  group('Lifecycle -- dispose()', () {
    testWidgets('dispose() before start completes without error', (WidgetTester _) async {
      await expectLater(service.dispose(), completes);
    });

    testWidgets('dispose() after start completes without error', (WidgetTester _) async {
      await service.start(_kConfig);
      await Future<void>.delayed(const Duration(milliseconds: 300));
      await expectLater(service.dispose(), completes);
    });

    testWidgets('second dispose() is a no-op', (WidgetTester _) async {
      await service.dispose();
      await expectLater(service.dispose(), completes);
    });
  });

  // -------------------------------------------------------------------------
  // restart cycle
  // -------------------------------------------------------------------------

  group('Lifecycle -- restart cycle', () {
    testWidgets('start -> dispose -> start works without error', (WidgetTester _) async {
      await service.start(_kConfig);
      await Future<void>.delayed(const Duration(milliseconds: 300));
      await service.dispose();

      // Second start must work -- this verifies C3 fix (_eventsController resurrection).
      await expectLater(service.start(_kConfig), completes);
    });

    testWidgets('two full restart cycles complete without error', (WidgetTester _) async {
      for (var i = 0; i < 2; i++) {
        await service.start(_kConfig);
        await Future<void>.delayed(const Duration(milliseconds: 200));
        await service.dispose();
      }
      // Final start so tearDown can dispose normally.
      await service.start(_kConfig);
    });
  });
}
