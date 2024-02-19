import 'package:equatable/equatable.dart';

enum TransferType {
  blind,
  consultative,
  attended,
}

extension TransferTypeX on TransferType {
  bool get isBlind => this == TransferType.blind;

  bool get isConsultative => this == TransferType.consultative;

  bool get isAttended => this == TransferType.attended;
}

enum TransferState {
  initiated,
  processing,
}

extension TransferStateX on TransferState {
  bool get isInitiated => this == TransferState.initiated;

  bool get isProcessing => this == TransferState.processing;
}

class Transfer extends Equatable {
  const Transfer({
    required this.type,
    required this.state,
  });

  final TransferType type;
  final TransferState state;

  bool get isBlind => type.isBlind;

  bool get isConsultative => type.isConsultative;

  bool get isAttended => type.isAttended;

  bool get isInitiated => state.isInitiated;

  bool get isProcessing => state.isProcessing;

  @override
  List<Object?> get props => [
        type,
        state,
      ];

  Transfer copyWith({
    TransferType? type,
    TransferState? state,
  }) {
    return Transfer(
      type: type ?? this.type,
      state: state ?? this.state,
    );
  }
}
