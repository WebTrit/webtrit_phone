part of 'embedded_cubit.dart';

enum EmbeddedIntents {
  reloadWebView,
}

@freezed
class EmbeddedState with _$EmbeddedState {
  const EmbeddedState._();

  const factory EmbeddedState({
    @Default({}) Map<String, dynamic> payload,
    @Default('') String currentUrl,
    @Default(false) bool canGoBack,
    EmbeddedIntents? intent,
  }) = _Initial;

  bool get isReadyToInjectedScript => payload.isNotEmpty;

  bool get isReloadWebView => intent == EmbeddedIntents.reloadWebView;
}
