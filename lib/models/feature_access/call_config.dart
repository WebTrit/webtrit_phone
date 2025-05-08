class CallConfig {
  const CallConfig({
    required this.videoEnable,
    required this.enableBlindTransfer,
    required this.enableAttendedTransfer,
  });

  /// Call
  final bool videoEnable;

  // Transfer
  final bool enableBlindTransfer;
  final bool enableAttendedTransfer;
}
