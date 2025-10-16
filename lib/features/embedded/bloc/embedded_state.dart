part of 'embedded_cubit.dart';

enum EmbeddedIntents {
  reloadWebView,
}

@freezed
abstract class EmbeddedState with _$EmbeddedState {
  const EmbeddedState._();

  const factory EmbeddedState({
    @Default({}) Map<String, dynamic> payload,
    @Default('') String currentUrl,
    @Default(false) bool canGoBack,
    @Default(false) bool payloadReady,
    EmbeddedIntents? intent,
  }) = _Initial;

  bool get isReadyToInjectedScript => payloadReady;

  bool get isReloadWebView => intent == EmbeddedIntents.reloadWebView;
}
