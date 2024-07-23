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

  const factory Transfer.attemptInviteTransfer({
    required String replaceCallId,
    required String referredBy,
  }) = AttemptInviteTransfer;

  const Transfer._();

  // Returns true if the transfer is submitted and now processing by the server.
  bool get processing => this is BlindTransferTransferSubmitted || this is AttendedTransferTransferSubmitted;

  // Returns true if the transfer is an attempted attended transfer.
  bool get attemptInviteTransfer => this is AttemptInviteTransfer;

  // Attempts to create an invite attempt transfer if both referredBy and replaceCallId are not null.
  static Transfer? tryCreateAttemptInviteTransfer(String? referredBy, String? replaceCallId) {
    if (referredBy != null && replaceCallId != null) {
      return Transfer.attemptInviteTransfer(replaceCallId: replaceCallId, referredBy: referredBy);
    }
    return null;
  }
}
