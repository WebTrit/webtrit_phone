import 'package:freezed_annotation/freezed_annotation.dart';

part 'transfer.freezed.dart';

@freezed
class Transfer with _$Transfer {
  /// Represents virtual state of transfering
  /// It is used to show the preparing UI for future transfering
  /// such as picking the contact or entering the number
  const factory Transfer.blindTransferInitiated() = BlindTransferInitiated;

  /// Represents state after the user has successfully submitted
  /// blind transfer and before the transfer picked up for
  /// processing by the server
  const factory Transfer.blindTransferTransferSubmitted({
    required String toNumber,
  }) = BlindTransferTransferSubmitted;

  /// Represents state after the user has successfully submitted
  /// attended transfer and before the transfer picked up for
  /// processing by the server
  const factory Transfer.attendedTransferTransferSubmitted({
    required String replaceCallId,
  }) = AttendedTransferTransferSubmitted;

  /// Represents state when server has started to process the transfer
  const factory Transfer.transfering({
    required bool fromAttendedTransfer,
    required bool fromBlindTransfer,
  }) = Transfering;

  /// Represents state when server has successfully processed
  /// attended transfer with full flow e.g `refer` or accept request
  /// that means calle should choose to accept or reject the invite to continue
  const factory Transfer.attendedTransferConfirmationRequested({
    required String referId,
    required String referTo,
    required String referredBy,
  }) = AttendedTransferConfirmationRequested;

  /// Represents state with incoming attended transfer invitation
  /// When user should choose to accept or reject the invite
  /// to continue the attended transfer initiated by another user
  const factory Transfer.inviteToAttendedTransfer({
    required String replaceCallId,
    required String referredBy,
  }) = InviteToAttendedTransfer;

  const Transfer._();
}
