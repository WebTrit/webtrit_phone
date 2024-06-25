extension UriExtensions on Uri {
  // Replaces the value following the last occurrence of the specified [path] segment with [value].
  // If the path segment exists but does not have a following value, the value will not be replaced.
  Uri replaceLastPathValue(String path, String value) {
    final updatedSegments = List<String>.from(pathSegments);
    for (int i = updatedSegments.length - 2; i >= 0; i--) {
      if (updatedSegments[i] == path && i + 1 < updatedSegments.length) {
        updatedSegments[i + 1] = value;
        return replace(pathSegments: updatedSegments);
      }
    }
    return this;
  }

  // Checks if the URI path contains the specified [path] segment and has a value following it.
  bool hasPathValue(String path) {
    final segments = pathSegments;
    for (int i = segments.length - 2; i >= 0; i--) {
      if (segments[i] == path && i + 1 < segments.length) {
        return true;
      }
    }
    return false;
  }

  Uri prepareUrlWithoutTenant(List<String> apiSegments, List<String> additionalSegments) {
    final List<String> baseSegments = pathSegments.toList();
    return replace(
      pathSegments: [
        ...baseSegments,
        ...apiSegments,
        ...additionalSegments,
      ],
    );
  }

  Uri prepareUrlWithTenant(
    String tenantKey,
    String tenantId,
    List<String> apiSegments,
    List<String> additionalSegments,
  ) {
    final Uri updatedBaseUrl = replaceLastPathValue(tenantKey, tenantId);
    final List<String> updatedSegments = updatedBaseUrl.hasPathValue(tenantKey)
        ? updatedBaseUrl.pathSegments
        : [
            ...updatedBaseUrl.pathSegments,
            tenantKey,
            tenantId,
          ];

    return updatedBaseUrl.replace(
      pathSegments: [
        ...updatedSegments,
        ...apiSegments,
        ...additionalSegments,
      ],
    );
  }

  Uri prepareRequestUrl(String tenantLey, String tenant, List<String> apiSegments, List<String> additionalSegments) {
    if (tenant.isEmpty) {
      return prepareUrlWithoutTenant(apiSegments, additionalSegments);
    } else {
      return prepareUrlWithTenant(tenantLey, tenant, apiSegments, additionalSegments);
    }
  }
}
