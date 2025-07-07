import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

class FakeWebtritSignalingClient implements WebtritSignalingClient {
  static Future<WebtritSignalingClient> connect(
    Uri url,
    String tenantId,
    String token,
    bool force, {
    required Duration connectionTimeout,
    required TrustedCertificates certs,
  }) async {
    return FakeWebtritSignalingClient();
  }

  @override
  Future<void> disconnect([int? code, String? reason]) async {}

  @override
  Future<void> execute(Request request, [Duration? timeout]) async {}

  @override
  void listen({
    required StateHandshakeHandler onStateHandshake,
    required EventHandler onEvent,
    required ErrorHandler onError,
    required DisconnectHandler onDisconnect,
  }) {}
}

Future<WebtritSignalingClient> testSignalingClientFactory({
  required Uri url,
  required String tenantId,
  required String token,
  required Duration connectionTimeout,
  required TrustedCertificates certs,
  required bool force,
}) async {
  return FakeWebtritSignalingClient();
}
