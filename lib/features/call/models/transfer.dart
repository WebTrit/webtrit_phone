// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

/// Base class for call transfer state.
abstract class Transfer {
  const Transfer();

  factory Transfer.blindTransferInitiated() {
    return const BlindTransferInitiated();
  }

  factory Transfer.blindTransferTransferred({required String toNumber}) {
    return BlindTransferTransferred(toNumber: toNumber);
  }

  factory Transfer.attendedTransferTransferred({required String replaceCallId}) {
    return AttendedTransferTransferred(replaceCallId: replaceCallId);
  }

  factory Transfer.attendedTransferConfirmationRequested(
      {required String referId, required String referTo, required String referredBy}) {
    return AttendedTransferConfirmationRequested(referId: referId, referTo: referTo, referredBy: referredBy);
  }

  bool get isTransferred => this is BlindTransferTransferred || this is AttendedTransferTransferred;
}

/// Represents a blind transfer initiated by the user.
/// The user has to choose the number to transfer the call to.
class BlindTransferInitiated extends Transfer with EquatableMixin {
  const BlindTransferInitiated();

  @override
  List<Object?> get props => [];
}

/// Represents a blind transfer submitted by the user.
/// The user has chosen the number to transfer the call to and wants to proceed.
class BlindTransferTransferred extends Transfer with EquatableMixin {
  const BlindTransferTransferred({required this.toNumber});

  final String toNumber;

  @override
  List<Object> get props => [toNumber];

  @override
  bool get stringify => true;
}

/// Represents a initiated attended transfer by the user.
/// Depends on adapter calle will be transfered to the number immidietly or sended a confirmation (REFER) request before transfer.
class AttendedTransferTransferred extends Transfer with EquatableMixin {
  const AttendedTransferTransferred({required this.replaceCallId});

  final String replaceCallId;

  @override
  List<Object> get props => [replaceCallId];

  @override
  bool get stringify => true;
}

/// Represents a state with incoming attended transfer confirmation request (REFER).
/// The user has to choose to accept or reject the transfer.
class AttendedTransferConfirmationRequested extends Transfer with EquatableMixin {
  const AttendedTransferConfirmationRequested({
    required this.referId,
    required this.referTo,
    required this.referredBy,
  });

  final String referId;
  final String referTo;
  final String referredBy;

  @override
  List<Object> get props => [referId, referTo, referredBy];

  @override
  bool get stringify => true;
}
