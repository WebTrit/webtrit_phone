import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';

part 'session.g.dart';

@freezed
@JsonSerializable()
class Session with _$Session {
  const Session({this.coreUrl, this.token, this.tenantId = '', this.userId = ''});

  @override
  final String? coreUrl;

  @override
  final String? token;

  @override
  final String tenantId;

  @override
  final String userId;

  factory Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);

  bool get isLoggedIn => coreUrl != null && token != null;
}
