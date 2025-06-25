import 'package:equatable/equatable.dart';

enum CallPullDialogDirection { initiator, recipient }

class CallPullDialog extends Equatable {
  const CallPullDialog({
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
  final String state;
  final String callId;
  final CallPullDialogDirection direction;
  final String localTag;
  final String remoteTag;
  final String remoteNumber;
  final String? remoteDisplayName;

  @override
  List<Object?> get props => [id, state, callId, direction, localTag, remoteTag, remoteNumber, remoteDisplayName];

  @override
  String toString() {
    return 'CallPullDialog{id: $id, state: $state, callId: $callId, direction: $direction, '
        'localTag: $localTag, remoteTag: $remoteTag, remoteNumber: $remoteNumber, remoteDisplayName: $remoteDisplayName}';
  }

  CallPullDialog copyWith({
    String? id,
    String? state,
    String? callId,
    CallPullDialogDirection? direction,
    String? localTag,
    String? remoteTag,
    String? remoteNumber,
    String? remoteDisplayName,
  }) {
    return CallPullDialog(
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
