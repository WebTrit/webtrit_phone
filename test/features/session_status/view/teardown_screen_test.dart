import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// ignore: depend_on_referenced_packages
import 'package:plugin_platform_interface/plugin_platform_interface.dart' show MockPlatformInterfaceMixin;
// ignore: depend_on_referenced_packages
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart'
    show SignalingServicePlatform;

import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/features/session_status/view/teardown_screen.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

// ---------------------------------------------------------------------------
// Fakes / Mocks
// ---------------------------------------------------------------------------

class _MockAppBloc extends MockBloc<AppEvent, AppState> implements AppBloc {}

/// Fake platform that records the order in which operations are invoked.
/// Shared [callLog] lets tests verify ordering across stopService and add().
class _FakePlatform extends Fake with MockPlatformInterfaceMixin implements SignalingServicePlatform {
  final List<String> callLog = [];

  @override
  Future<void> stopService() async => callLog.add('stopService');
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

Widget _buildSubject(_MockAppBloc appBloc) {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: BlocProvider<AppBloc>.value(value: appBloc, child: const TeardownScreen()),
  );
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  late _MockAppBloc appBloc;
  late _FakePlatform platform;

  setUpAll(() {
    registerFallbackValue(const AppCleanupRequested());
  });

  setUp(() {
    appBloc = _MockAppBloc();
    platform = _FakePlatform();
    SignalingServicePlatform.instance = platform;
  });

  group('TeardownScreen', () {
    testWidgets('calls stopService() during initState', (tester) async {
      await tester.pumpWidget(_buildSubject(appBloc));

      expect(platform.callLog, contains('stopService'));
    });

    testWidgets('dispatches AppCleanupRequested on the first frame', (tester) async {
      await tester.pumpWidget(_buildSubject(appBloc));
      await tester.pump(); // flush addPostFrameCallback

      verify(() => appBloc.add(const AppCleanupRequested())).called(1);
    });

    testWidgets('stopService() is called before AppCleanupRequested', (tester) async {
      when(() => appBloc.add(any())).thenAnswer((invocation) {
        if (invocation.positionalArguments.first is AppCleanupRequested) {
          platform.callLog.add('AppCleanupRequested');
        }
      });

      await tester.pumpWidget(_buildSubject(appBloc));
      await tester.pump();

      expect(platform.callLog, ['stopService', 'AppCleanupRequested']);
    });
  });
}
