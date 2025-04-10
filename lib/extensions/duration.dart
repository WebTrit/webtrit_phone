extension DurationFormatting on Duration {
  String format() {
    return [
      if (inHours > 0) inHours,
      ...[
        inMinutes,
        inSeconds,
      ].map((v) => v.remainder(60))
    ].map((seg) => seg.toString().padLeft(2, '0')).join(':');
  }

  String toHMSMs() {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);
    final milliseconds = inMilliseconds.remainder(1000);

    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}:${milliseconds.toString().padLeft(3, '0')}';
    }
  }
}
