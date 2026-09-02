import 'package:json_annotation/json_annotation.dart';

/// Lifecycle status of a session as reported by the core.
///
/// [unknown] is a decoding fallback only - the core never sends it. It keeps an
/// added server-side status from breaking the session list on an older app.
@JsonEnum(fieldRename: FieldRename.snake)
enum UserSessionStatus { unknown, active, inactive, missing, expired, invalid, error }
