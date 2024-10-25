class AutoprovisionConfig {
  final String configToken;
  final String? oldToken;
  final String tenantId;
  final String oldTenantId;
  final String coreUrl;
  final String oldCoreUrl;

  const AutoprovisionConfig({
    required this.configToken,
    required this.tenantId,
    required this.oldTenantId,
    this.oldToken,
    required this.coreUrl,
    required this.oldCoreUrl,
  });

  @override
  String toString() {
    return 'configToken: $configToken,oldToken: $oldToken, tenantId: $tenantId, oldTenantId: $oldTenantId,  coreUrl: $coreUrl, oldCoreUrl: $oldCoreUrl';
  }
}
