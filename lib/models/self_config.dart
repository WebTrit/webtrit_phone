import 'package:equatable/equatable.dart';

@Deprecated('Moved to custom_pages feature')
sealed class SelfConfig {
  const SelfConfig();

  factory SelfConfig.unsupported() => const SelfConfigUnsupported();
  factory SelfConfig.supported({required Uri url, required DateTime expiresAt}) =>
      SelfConfigSupported(url: url, expiresAt: expiresAt);
}

@Deprecated('Moved to custom_pages feature')
final class SelfConfigUnsupported extends SelfConfig {
  const SelfConfigUnsupported();
}

@Deprecated('Moved to custom_pages feature')
final class SelfConfigSupported extends SelfConfig with EquatableMixin {
  SelfConfigSupported({
    required this.url,
    required this.expiresAt,
  });

  final Uri url;
  final DateTime expiresAt;

  @override
  List<Object> get props => [url, expiresAt];

  @override
  bool get stringify => true;

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}
