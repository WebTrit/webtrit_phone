part of 'qr_signin_cubit.dart';

enum QrSigninStatus {
  /// The camera permission is being determined; nothing is shown yet.
  checkingPermission,

  /// The camera is available and the scanner is (or may be) running.
  scanning,

  /// The camera permission is missing; the user has to grant it to proceed.
  permissionRequired,
}

class QrSigninState extends Equatable {
  const QrSigninState({
    this.status = QrSigninStatus.checkingPermission,
    this.cameraPermanentlyDenied = false,
    this.parseError,
    this.detection,
  });

  final QrSigninStatus status;

  /// Whether asking again is pointless (the OS will not show the dialog);
  /// the user has to enable the permission on the settings screen instead.
  final bool cameraPermanentlyDenied;

  /// Why the last scanned code was rejected; cleared automatically after
  /// [QrSigninCubit.errorDisplayDuration].
  final QrSigninParseError? parseError;

  /// A successfully parsed code waiting to be handed over to the login flow.
  final QrSigninParseResult? detection;

  QrSigninState copyWith({
    QrSigninStatus? status,
    bool? cameraPermanentlyDenied,
    QrSigninParseError? Function()? parseError,
    QrSigninParseResult? Function()? detection,
  }) {
    return QrSigninState(
      status: status ?? this.status,
      cameraPermanentlyDenied: cameraPermanentlyDenied ?? this.cameraPermanentlyDenied,
      parseError: parseError != null ? parseError() : this.parseError,
      detection: detection != null ? detection() : this.detection,
    );
  }

  @override
  List<Object?> get props => [status, cameraPermanentlyDenied, parseError, detection];
}
