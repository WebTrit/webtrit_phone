import '../styles/styles.dart';

/// Extension to check visual properties of the background style.
extension BackgroundStyleExtension on BackgroundStyle {
  /// Returns true if the background is considered "complex" (e.g., gradient or image),
  /// which typically requires UI adjustments like transparent AppBars.
  bool get isComplex => this is GradientBackgroundStyle || this is ImageBackgroundStyle;
}
