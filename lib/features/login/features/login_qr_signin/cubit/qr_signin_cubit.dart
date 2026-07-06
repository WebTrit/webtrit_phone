import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:webtrit_phone/data/data.dart';

import '../models/qr_signin_uri_parser.dart';

part 'qr_signin_state.dart';

final _logger = Logger('QrSigninCubit');

/// Drives the QR sign-in tab: camera permission and interpretation of the
/// scanned payloads.
///
/// The cubit deliberately does not create the session itself - a successfully
/// parsed code is exposed as [QrSigninState.detection] for the view to hand
/// over to the login flow, which keeps a single owner of the sign-in pipeline.
class QrSigninCubit extends Cubit<QrSigninState> {
  QrSigninCubit({required this.appPermissions, required this.parser}) : super(const QrSigninState()) {
    _checkPermission();
  }

  final AppPermissions appPermissions;
  final QrSigninUriParser parser;

  /// How long an unrecognized code stays reported before scanning resumes,
  /// and repeated detections of the same payload are ignored.
  static const errorDisplayDuration = Duration(seconds: 3);

  Timer? _errorResetTimer;
  Timer? _retryCooldownTimer;
  String? _lastRaw;

  Future<void> _checkPermission() async {
    final granted = await appPermissions.isPermissionGranted(Permission.camera);
    if (isClosed) return;
    emit(state.copyWith(status: granted ? QrSigninStatus.scanning : QrSigninStatus.permissionRequired));
  }

  /// Re-runs the permission check, e.g. when the app returns from the
  /// settings screen.
  Future<void> recheckPermission() async {
    if (state.status != QrSigninStatus.permissionRequired) return;
    await _checkPermission();
  }

  Future<void> requestPermission() async {
    final status = await Permission.camera.request();
    _logger.info('Camera permission request result: $status');
    if (isClosed) return;
    emit(state.copyWith(status: status.isGranted ? QrSigninStatus.scanning : QrSigninStatus.permissionRequired));
  }

  Future<void> openAppSettings() => appPermissions.toAppSettings();

  /// Handles a payload detected by the scanner.
  void barcodeDetected(String? rawValue) {
    if (rawValue == null || rawValue.isEmpty) return;
    if (state.status != QrSigninStatus.scanning || state.detection != null) return;
    // The scanner keeps re-detecting the code while it stays in the viewfinder.
    if (rawValue == _lastRaw) return;
    _lastRaw = rawValue;

    // The raw payload is never logged: it may carry plain credentials.
    switch (parser.parse(rawValue)) {
      case QrSigninParseFailure(:final error):
        _logger.info('Scanned code rejected: ${error.name}');
        emit(state.copyWith(parseError: () => error));
        _errorResetTimer?.cancel();
        _errorResetTimer = Timer(errorDisplayDuration, () {
          if (isClosed) return;
          _lastRaw = null;
          emit(state.copyWith(parseError: () => null));
        });
      case final QrSigninCredentials credentials:
        _errorResetTimer?.cancel();
        emit(state.copyWith(parseError: () => null, detection: () => credentials));
      case final QrSigninUserRefOnly userRefOnly:
        _errorResetTimer?.cancel();
        emit(state.copyWith(parseError: () => null, detection: () => userRefOnly));
    }
  }

  /// Clears the reported detection so scanning can continue, e.g. after a
  /// failed sign-in attempt.
  ///
  /// The last payload stays ignored for a short cooldown: a rejected code is
  /// usually still in the viewfinder, and clearing it right away would retry
  /// the same failing sign-in in a tight loop.
  void detectionHandled() {
    _retryCooldownTimer?.cancel();
    _retryCooldownTimer = Timer(errorDisplayDuration, () => _lastRaw = null);
    emit(state.copyWith(detection: () => null));
  }

  @override
  Future<void> close() {
    _errorResetTimer?.cancel();
    _retryCooldownTimer?.cancel();
    return super.close();
  }
}
