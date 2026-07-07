import 'package:equatable/equatable.dart';

/// Configuration of the QR-code sign-in tab.
///
/// The scanned code carries plain credentials in a provisioning payload;
/// signing in goes through the regular password login, so the tab is offered
/// only when the backend supports password sign-in.
class QrSigninConfig extends Equatable {
  QrSigninConfig({
    this.enabled = false,
    List<QrSigninFormatConfig> formats = const [
      QrSigninFormatConfig(type: 'uri', schemes: ['csc']),
      QrSigninFormatConfig(type: 'json'),
    ],
    this.expectedHost,
  }) : formats = List.unmodifiable(formats);

  /// Whether the QR-code sign-in tab is available at all.
  final bool enabled;

  /// Accepted payload formats with their per-format options, probed in this
  /// order.
  final List<QrSigninFormatConfig> formats;

  /// Expected host (cloud id) of the code, shared by all formats; null
  /// accepts any host.
  final String? expectedHost;

  static final disabled = QrSigninConfig();

  @override
  List<Object?> get props => [enabled, formats, expectedHost];
}

/// One accepted QR payload format and its format-specific options.
class QrSigninFormatConfig extends Equatable {
  const QrSigninFormatConfig({required this.type, this.schemes});

  /// Decoder name (`uri`, `json`).
  final String type;

  /// `uri` only: accepted scheme names, matched case-insensitively.
  final List<String>? schemes;

  @override
  List<Object?> get props => [type, schemes];
}
