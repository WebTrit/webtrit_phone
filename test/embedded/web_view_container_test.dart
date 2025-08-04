import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webtrit_phone/widgets/webview/web_view_container.dart';

class MockCanLaunch extends Mock {
  Future<bool> call(Uri uri);
}

class MockLaunch extends Mock {
  Future<bool> call(Uri uri, {LaunchMode mode});
}

void main() {
  late MockCanLaunch mockCanLaunch;
  late MockLaunch mockLaunch;
  late NavigationRequestHandler handler;

  setUp(() {
    mockCanLaunch = MockCanLaunch();
    mockLaunch = MockLaunch();
    handler = NavigationRequestHandler(
      canLaunchUrlFn: mockCanLaunch.call,
      launchUrlFn: mockLaunch.call,
    );
  });

  test('navigate to internal http URL', () async {
    final result = await handler.handle(const NavigationRequest(
      url: 'https://example.com',
      isMainFrame: true,
    ));

    expect(result, NavigationDecision.navigate);
  });

  test('prevent navigation for tel: scheme', () async {
    final result = await handler.handle(const NavigationRequest(
      url: 'tel:+380979826361',
      isMainFrame: true,
    ));

    expect(result, NavigationDecision.prevent);
  });

  test('prevent navigation if external URL param is missing', () async {
    final result = await handler.handle(const NavigationRequest(
      url: 'app://openinexternalbrowser',
      isMainFrame: true,
    ));

    expect(result, NavigationDecision.prevent);
  });

  test('prevent navigation if external URL param is invalid', () async {
    final result = await handler.handle(const NavigationRequest(
      url: 'app://openinexternalbrowser?url=:::::',
      isMainFrame: true,
    ));

    expect(result, NavigationDecision.prevent);
  });

  test('prevent if canLaunchUrl returns false', () async {
    final targetUri = Uri.parse('https://webtrit.com');

    when(() => mockCanLaunch(targetUri)).thenAnswer((_) async => false);

    final result = await handler.handle(const NavigationRequest(
      url: 'app://openinexternalbrowser?url=https://webtrit.com',
      isMainFrame: true,
    ));

    expect(result, NavigationDecision.prevent);
  });

  test('prevent if launchUrl returns false', () async {
    final targetUri = Uri.parse('https://webtrit.com');

    when(() => mockCanLaunch(targetUri)).thenAnswer((_) async => true);
    when(() => mockLaunch(targetUri, mode: LaunchMode.externalApplication)).thenAnswer((_) async => false);

    final result = await handler.handle(const NavigationRequest(
      url: 'app://openinexternalbrowser?url=https://webtrit.com',
      isMainFrame: true,
    ));

    expect(result, NavigationDecision.prevent);
  });

  test('prevent after successful external launch (by design)', () async {
    final targetUri = Uri.parse('https://webtrit.com');

    when(() => mockCanLaunch(targetUri)).thenAnswer((_) async => true);
    when(() => mockLaunch(targetUri, mode: LaunchMode.externalApplication)).thenAnswer((_) async => true);

    final result = await handler.handle(const NavigationRequest(
      url: 'app://openinexternalbrowser?url=https://webtrit.com',
      isMainFrame: true,
    ));

    expect(result, NavigationDecision.prevent);
  });
}
