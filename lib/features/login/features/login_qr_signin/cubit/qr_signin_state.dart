part of 'qr_signin_cubit.dart';

enum QrSigninStatus {
  /// The camera permission is being determined; nothing is shown yet.
  checkingPermission,

  /// The camera is available and the scanner is (or may be) running.
  scanning,

  /// The camera permission is missing; the user has to grant it to proceed.
  permissionRequired,
}

@freezed
class QrSigninState with _$QrSigninState {
  const QrSigninState({
    this.status = QrSigninStatus.checkingPermission,
    this.cameraPermanentlyDenied = false,
    this.parseError,
    this.detection,
  });

  @override
  final QrSigninStatus status;

  /// Whether asking again is pointless (the OS will not show the dialog);
  /// the user has to enable the permission on the settings screen instead.
  @override
  final bool cameraPermanentlyDenied;

  /// Why the last scanned code was rejected; cleared automatically after
  /// [QrSigninCubit.errorDisplayDuration].
  @override
  final QrSigninParseError? parseError;

  /// A successfully parsed code waiting to be handed over to the login flow.
  @override
  final QrSigninParseResult? detection;
}
