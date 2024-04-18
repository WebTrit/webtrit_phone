part of 'autoprovision_cubit.dart';

/// Base class for the states of the autoprovision cubit.
abstract base class AutoprovisionState {
  const AutoprovisionState();

  factory AutoprovisionState.initial() => const Initial._();
  factory AutoprovisionState.error(Object error) => Error._(error);
  factory AutoprovisionState.processing() => const ProcessingToken._();
  factory AutoprovisionState.replaceConfirmationNeeded() => const ReplaceConfirmationNeeded._();

  factory AutoprovisionState.sessionCreated(String token, String coreUrl, String tenantId) {
    return SessionCreated._(token, coreUrl, tenantId);
  }
}

/// Represents the initial state of the autoprovision cubit.
final class Initial extends AutoprovisionState with EquatableMixin {
  const Initial._();

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

/// Represents the state of the autoprovision cubit when an error occurred.
final class Error extends AutoprovisionState with EquatableMixin {
  const Error._(this.error);

  final Object error;

  @override
  List<Object?> get props => [error];

  @override
  bool? get stringify => true;
}

/// Represents the state of the autoprovision cubit when processing a token.
final class ProcessingToken extends AutoprovisionState with EquatableMixin {
  const ProcessingToken._();

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

/// Represents the state of the autoprovision cubit when needed confirmation for replace the current user session.
final class ReplaceConfirmationNeeded extends AutoprovisionState with EquatableMixin {
  const ReplaceConfirmationNeeded._();

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

/// Represents the state of the autoprovision cubit when the session is created.
final class SessionCreated extends AutoprovisionState with EquatableMixin {
  const SessionCreated._(this.token, this.coreUrl, this.tenantId);

  final String token;
  final String coreUrl;
  final String tenantId;

  @override
  List<Object?> get props => [token, coreUrl, tenantId];

  @override
  bool? get stringify => true;
}
