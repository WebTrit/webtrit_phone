import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

/// Resolved set of locales the app exposes for selection and auto-resolution.
///
/// Built by intersecting the locales the app actually bundles with the
/// `enabledLanguages` allowlist from the app config. When the allowlist is empty
/// (or would filter everything out) the full bundled set is kept, so builds that
/// do not configure a restriction behave exactly as before.
class LocalizationConfig extends Equatable {
  const LocalizationConfig({required this.supportedLocales});

  final List<Locale> supportedLocales;

  /// Filters [all] by [enabledLanguages] (matched on `languageCode`), preserving
  /// the order of [all]. An empty [enabledLanguages] - or a filter that removes
  /// every locale - falls back to the full [all] list to avoid an app with no
  /// selectable language.
  static List<Locale> resolve(List<Locale> all, List<String> enabledLanguages) {
    if (enabledLanguages.isEmpty) return all;
    final wanted = enabledLanguages
        .map((code) => code.trim().toLowerCase())
        .where((code) => code.isNotEmpty)
        .toSet();
    if (wanted.isEmpty) return all;
    final filtered = all
        .where((locale) => wanted.contains(locale.languageCode.toLowerCase()))
        .toList(growable: false);
    return filtered.isEmpty ? all : filtered;
  }

  @override
  List<Object?> get props => [supportedLocales];
}
