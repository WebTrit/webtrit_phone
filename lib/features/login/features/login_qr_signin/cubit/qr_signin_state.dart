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
  const QrSigninState({this.status = QrSigninStatus.checkingPermission, this.parseError, this.detection});

  final QrSigninStatus status;

  /// Why the last scanned code was rejected; cleared automatically after
  /// [QrSigninCubit.errorDisplayDuration].
  final QrSigninParseError? parseError;

  /// A successfully parsed code waiting to be handed over to the login flow.
  final QrSigninParseResult? detection;

  QrSigninState copyWith({
    QrSigninStatus? status,
    QrSigninParseError? Function()? parseError,
    QrSigninParseResult? Function()? detection,
  }) {
    return QrSigninState(
      status: status ?? this.status,
      parseError: parseError != null ? parseError() : this.parseError,
      detection: detection != null ? detection() : this.detection,
    );
  }

  @override
  List<Object?> get props => [status, parseError, detection];
}
