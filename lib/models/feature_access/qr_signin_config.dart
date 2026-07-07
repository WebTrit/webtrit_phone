import 'package:equatable/equatable.dart';

/// Configuration of the QR-code sign-in tab.
///
/// The scanned code carries plain credentials in a provisioning URI; signing in
/// goes through the regular password login, so the tab is offered only when the
/// backend supports password sign-in.
class QrSigninConfig extends Equatable {
  QrSigninConfig({
    this.enabled = false,
    List<String> formats = const ['uri', 'json'],
    List<String> schemes = const ['csc'],
    this.expectedHost,
  }) : formats = List.unmodifiable(formats),
       schemes = List.unmodifiable(schemes);

  /// Whether the QR-code sign-in tab is available at all.
  final bool enabled;

  /// Accepted payload formats (decoder names), probed in this order.
  final List<String> formats;

  /// Accepted URI scheme names of the `uri` format, matched case-insensitively.
  final List<String> schemes;

  /// Expected host (cloud id) of the code; null accepts any host.
  final String? expectedHost;

  static final disabled = QrSigninConfig();

  @override
  List<Object?> get props => [enabled, formats, schemes, expectedHost];
}
