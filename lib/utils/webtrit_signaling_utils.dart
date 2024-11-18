class WebtritSignalingUtils {
  WebtritSignalingUtils._();

  static Uri parseCoreUrlToSignalingUrl(String coreUrl) {
    final uri = Uri.parse(coreUrl);
    return uri.replace(scheme: uri.scheme.endsWith('s') ? 'wss' : 'ws');
  }
}
