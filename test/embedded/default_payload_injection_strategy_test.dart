import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: depend_on_referenced_packages
import 'package:plugin_platform_interface/plugin_platform_interface.dart' show MockPlatformInterfaceMixin;

import 'package:webtrit_phone/widgets/webview/web_view_container.dart';

class FakeWebViewPlatform extends Fake with MockPlatformInterfaceMixin implements WebViewPlatform {}

class MockWebViewController extends Mock implements WebViewController {}

class MockWebViewPlatform extends Mock implements WebViewPlatform {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late DefaultPayloadInjectionStrategy strategy;
  late MockWebViewController controller;
  late MockBuildContext context;

  setUpAll(() {
    WebViewPlatform.instance = FakeWebViewPlatform();

    registerFallbackValue(Uri.parse('https://fallback.com'));
    registerFallbackValue(JavaScriptMode.unrestricted);
  });

  setUp(() {
    strategy = DefaultPayloadInjectionStrategy();
    controller = MockWebViewController();
    context = MockBuildContext();

    when(() => controller.runJavaScript(any())).thenAnswer((_) async {});
  });

  tearDown(() {
    strategy.disposeForTesting();
  });

  test('does not inject if only setData is called (no controller)', () {
    strategy.setPayload({'foo': 'bar'});

    verifyNever(() => controller.runJavaScript(any()));
  });

  test('does not inject if only onPageReady is called (no payload)', () {
    strategy.onPageReadyForTesting(controller, context);

    verifyNever(() => controller.runJavaScript(any()));
  });

  test('injects when setData is called before onPageReady', () {
    final payload = {'key': 'value'};
    strategy.setPayload(payload);

    strategy.onPageReadyForTesting(controller, context);

    final expectedJson = const JsonEncoder().convert(payload);
    final expectedScript = '''
      if (typeof window.onPayloadDataReady === 'function') {
        window.onPayloadDataReady($expectedJson);
      }
    ''';

    verify(() => controller.runJavaScript(expectedScript)).called(1);
  });

  test('injects when setData is called after onPageReady', () {
    strategy.onPageReadyForTesting(controller, context);

    final payload = {'after': 123};
    strategy.setPayload(payload);

    final expectedJson = const JsonEncoder().convert(payload);
    final expectedScript = '''
      if (typeof window.onPayloadDataReady === 'function') {
        window.onPayloadDataReady($expectedJson);
      }
    ''';

    verify(() => controller.runJavaScript(expectedScript)).called(1);
  });

  test('does not inject if payload is empty', () {
    strategy.onPageReadyForTesting(controller, context);
    strategy.setPayload({});

    verifyNever(() => controller.runJavaScript(any()));
  });

  test('dispose removes listener and prevents injection after', () {
    strategy.onPageReadyForTesting(controller, context);
    strategy.disposeForTesting();

    strategy.setPayload({'shouldNot': true});

    verifyNever(() => controller.runJavaScript(any()));
  });
}
