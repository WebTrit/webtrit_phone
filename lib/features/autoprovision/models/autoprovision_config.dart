class AutoprovisionConfig {
  const AutoprovisionConfig({
    required this.configToken,
    this.oldToken,
    required this.tenantId,
    required this.oldTenantId,
    required this.coreUrl,
    required this.oldCoreUrl,
  });

  final String configToken;
  final String? oldToken;
  final String tenantId;
  final String oldTenantId;
  final String coreUrl;
  final String oldCoreUrl;

  @override
  String toString() {
    return 'configToken: $configToken, oldToken: $oldToken, tenantId: $tenantId, oldTenantId: $oldTenantId, coreUrl: $coreUrl, oldCoreUrl: $oldCoreUrl';
  }
}
