import 'package:equatable/equatable.dart';

enum PullableCallDirection { initiator, recipient }

enum PullableCallState { proceeding, early, confirmed, terminated, unknown }

class PullableCall extends Equatable {
  const PullableCall({
    required this.id,
    required this.state,
    required this.callId,
    required this.direction,
    required this.localTag,
    required this.remoteTag,
    required this.remoteNumber,
    this.remoteDisplayName,
  });

  final String id;
  final PullableCallState state;
  final String callId;
  final PullableCallDirection direction;
  final String localTag;
  final String? remoteTag;
  final String remoteNumber;
  final String? remoteDisplayName;

  String get displayName => remoteDisplayName ?? remoteNumber;

  @override
  List<Object?> get props => [id, state, callId, direction, localTag, remoteTag, remoteNumber, remoteDisplayName];

  @override
  String toString() {
    return 'PullableCall{id: $id, state: $state, callId: $callId, direction: $direction, '
        'localTag: $localTag, remoteTag: $remoteTag, remoteNumber: $remoteNumber, remoteDisplayName: $remoteDisplayName}';
  }

  PullableCall copyWith({
    String? id,
    PullableCallState? state,
    String? callId,
    PullableCallDirection? direction,
    String? localTag,
    String? remoteTag,
    String? remoteNumber,
    String? remoteDisplayName,
  }) {
    return PullableCall(
      id: id ?? this.id,
      state: state ?? this.state,
      callId: callId ?? this.callId,
      direction: direction ?? this.direction,
      localTag: localTag ?? this.localTag,
      remoteTag: remoteTag ?? this.remoteTag,
      remoteNumber: remoteNumber ?? this.remoteNumber,
      remoteDisplayName: remoteDisplayName ?? this.remoteDisplayName,
    );
  }
}
