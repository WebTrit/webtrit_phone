import 'package:webtrit_phone/features/login/models/login_type.dart';

/// Built-in order applied when no explicit order is configured.
///
/// When both are available the regular password login comes first: it is faster
/// for frequent users, while OTP delivery takes a moment anyway.
const kDefaultLoginTypeOrder = <LoginType>[LoginType.passwordSignin, LoginType.otpSignin, LoginType.signup];

/// Returns [types] reordered deterministically on the client.
///
/// The order the backend lists the login options in is intentionally ignored:
/// it is not stable across requests, so relying on it makes the login tabs jump
/// around. [orderConfig] is a list of [LoginType] names (e.g. from a build-time
/// environment value); unknown names are ignored and an empty/invalid config
/// falls back to [kDefaultLoginTypeOrder]. Login types not covered by the
/// resolved order are kept and pushed to the end, preserving their relative
/// order.
List<LoginType> sortLoginTypes(List<LoginType> types, {List<String> orderConfig = const []}) {
  final nameMap = LoginType.values.asNameMap();
  final priority = [
    for (final name in orderConfig)
      if (nameMap.containsKey(name)) nameMap[name]!,
  ];
  final order = priority.isNotEmpty ? priority : kDefaultLoginTypeOrder;

  int rank(LoginType type) {
    final index = order.indexOf(type);
    return index == -1 ? order.length : index;
  }

  final indexed = [for (var i = 0; i < types.length; i++) (i, types[i])];
  indexed.sort((a, b) {
    final byRank = rank(a.$2).compareTo(rank(b.$2));
    return byRank != 0 ? byRank : a.$1.compareTo(b.$1);
  });
  return [for (final entry in indexed) entry.$2];
}
