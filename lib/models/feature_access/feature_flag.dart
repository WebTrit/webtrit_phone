/// Defines the set of feature flags that can be toggled on or off
/// to enable or disable specific parts of the application.
///
/// Each value in this enum represents a distinct feature within the app.
/// By checking the corresponding [FeatureFlag], the application can decide
/// whether to provide repositories, UI components, or routes related to that feature.
enum FeatureFlag {
  voicemail,
}
