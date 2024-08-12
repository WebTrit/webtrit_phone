import 'package:freezed_annotation/freezed_annotation.dart';

part 'transfer.freezed.dart';

@freezed
class Transfer with _$Transfer {
  const factory Transfer.blindTransferInitiated() = BlindTransferInitiated;

  const factory Transfer.blindTransferTransferSubmitted({
    required String toNumber,
  }) = BlindTransferTransferSubmitted;

  const factory Transfer.attendedTransferTransferSubmitted({
    required String replaceCallId,
  }) = AttendedTransferTransferSubmitted;

  const factory Transfer.attendedTransferConfirmationRequested({
    required String referId,
    required String referTo,
    required String referredBy,
  }) = AttendedTransferConfirmationRequested;

  const factory Transfer.inviteToAttendedTransfer({
    required String replaceCallId,
    required String referredBy,
  }) = InviteToAttendedTransfer;

  const Transfer._();

  // Returns true if the transfer is submitted and now processing by the server.
  bool get processing => this is BlindTransferTransferSubmitted || this is AttendedTransferTransferSubmitted;

  // Returns true if the transfer is an attempted attended transfer.
  bool get inviteToAttendedTransfer => this is InviteToAttendedTransfer;
}
