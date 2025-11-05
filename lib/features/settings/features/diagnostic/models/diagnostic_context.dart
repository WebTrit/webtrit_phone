/// Provides shared configuration for the diagnostic screen,
/// avoiding the need to pass values explicitly through constructors.
///
/// Bundles common dependencies and feature flags to simplify access
/// and reduce repetitive logic across widgets.
///
/// - [isLocalContactsFeatureEnabled]: Indicates whether the local contacts feature is enabled.
class DiagnosticScreenContext {
  final bool isLocalContactsFeatureEnabled;

  DiagnosticScreenContext({required this.isLocalContactsFeatureEnabled});
}
