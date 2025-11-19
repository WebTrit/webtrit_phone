import 'package:bloc_test/bloc_test.dart';
import 'package:pub_semver/pub_semver.dart';

import 'package:webtrit_phone/features/features.dart';

class MockAboutBloc extends MockBloc<AboutEvent, AboutState> implements AboutBloc {
  MockAboutBloc();

  // Single source of truth for the default/base state
  static AboutState _defaultState({bool progress = false, Version? coreVersion}) => AboutState(
        progress: false,
        embeddedLinks: const [],
        packageName: 'com.webtrit.phone',
        userAgent: 'WebTrit/0.0.0 (Pixel 9; Android: 16)',
        appIdentifier: 'com.webtrit.phone',
        coreUrl: Uri.parse('https://core.example.com'),
        fcmPushToken: 'fcm-token-demo',
        coreVersion: coreVersion,
      );

  // Small helper to seed the mock with an initial state
  static void _seed(MockAboutBloc mock, AboutState initial) {
    whenListen(
      mock,
      const Stream<AboutState>.empty(),
      initialState: initial,
    );
  }

  factory MockAboutBloc.idle({AboutState? state}) {
    final mock = MockAboutBloc();
    _seed(mock, state ?? _defaultState());
    return mock;
  }

  factory MockAboutBloc.loading({AboutState? base}) {
    final mock = MockAboutBloc();
    final initial = base ?? _defaultState(progress: true);
    _seed(mock, initial);
    return mock;
  }

  factory MockAboutBloc.success({Version? coreVersion, AboutState? base}) {
    final mock = MockAboutBloc();
    final initial = base ?? _defaultState(progress: false, coreVersion: coreVersion ?? Version.parse('3.4.5'));
    _seed(mock, initial);
    return mock;
  }

  factory MockAboutBloc.failure({AboutState? base}) {
    final mock = MockAboutBloc();
    final initial = base ?? _defaultState(progress: false);
    _seed(mock, initial);
    return mock;
  }
}
