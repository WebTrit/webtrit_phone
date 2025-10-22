part of 'embedded_cubit.dart';

enum EmbeddedIntents {
  reloadWebView,
}

@freezed
class EmbeddedState with _$EmbeddedState {
  const EmbeddedState({
    this.payload = const {},
    this.currentUrl = '',
    this.canGoBack = false,
    this.payloadReady = false,
    this.intent,
  });

  @override
  final Map<String, dynamic> payload;
  @override
  final String currentUrl;
  @override
  final bool canGoBack;
  @override
  final bool payloadReady;
  @override
  final EmbeddedIntents? intent;

  bool get isReadyToInjectedScript => payloadReady;

  bool get isReloadWebView => intent == EmbeddedIntents.reloadWebView;
}
