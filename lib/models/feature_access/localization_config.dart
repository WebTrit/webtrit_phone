import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

/// The locales the app offers.
///
/// It used to resolve them: the app bundled every language it had ever had, and
/// this intersected that with an allowlist from the brand's configuration. The
/// build settles it now - the tool that assembles a brand writes only the
/// languages its theme enables and removes the rest before the localizations
/// are generated - so what the app carries IS the answer, and a second opinion
/// here could only disagree with the files on disk.
class LocalizationConfig extends Equatable {
  const LocalizationConfig({required this.supportedLocales});

  final List<Locale> supportedLocales;

  @override
  List<Object?> get props => [supportedLocales];
}
