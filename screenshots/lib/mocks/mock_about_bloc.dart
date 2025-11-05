import 'package:bloc_test/bloc_test.dart';
import 'package:pub_semver/pub_semver.dart';

import 'package:webtrit_phone/features/features.dart';

class MockAboutBloc extends MockBloc<AboutEvent, AboutState>
    implements AboutBloc {
  MockAboutBloc();

  // Single source of truth for the default/base state
  static AboutState _defaultState() => AboutState(
        progress: false,
        embeddedLinks: const [],
        appName: 'WebTrit Phone',
        packageName: 'com.webtrit.phone',
        storeBuildVersion: '1.2.3',
        storeBuildNumber: '456',
        appVersion: '1.2.3+456',
        appIdentifier: 'com.webtrit.phone',
        coreUrl: Uri.parse('https://core.example.com'),
        fcmPushToken: 'fcm-token-demo',
        coreVersion: null,
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
    final initial = (base ?? _defaultState()).copyWith(progress: true);
    _seed(mock, initial);
    return mock;
  }

  factory MockAboutBloc.success({Version? coreVersion, AboutState? base}) {
    final mock = MockAboutBloc();
    final initial = (base ?? _defaultState()).copyWith(
      progress: false,
      coreVersion: coreVersion ?? Version.parse('3.4.5'),
    );
    _seed(mock, initial);
    return mock;
  }

  factory MockAboutBloc.failure({AboutState? base}) {
    final mock = MockAboutBloc();
    final initial = (base ?? _defaultState()).copyWith(
      progress: false,
      coreVersion: null,
    );
    _seed(mock, initial);
    return mock;
  }
}
