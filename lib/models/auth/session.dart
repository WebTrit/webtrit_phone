import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';

part 'session.g.dart';

@freezed
abstract class Session with _$Session {
  const Session._();

  const factory Session({
    String? coreUrl,
    String? token,
    @Default('') String tenantId,
    @Default('') String userId,
  }) = _Session;

  factory Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);

  bool get isLoggedIn => coreUrl != null && token != null;
}
