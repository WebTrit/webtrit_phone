part of 'embedded_cubit.dart';

enum EmbeddedIntents {
  reloadWebView,
}

@freezed
class EmbeddedState with _$EmbeddedState {
  const EmbeddedState._();

  const factory EmbeddedState({
    @Default({}) Map<String, dynamic> payload,
    @Default(false) bool payloadReady,
    @Default(false) bool webViewReady,
    WebResourceError? webResourceError,
    EmbeddedIntents? intent,
  }) = _Initial;

  bool get isReadyToInjectedScript => payloadReady && webViewReady;

  bool get isReloadWebView => intent == EmbeddedIntents.reloadWebView;
}
