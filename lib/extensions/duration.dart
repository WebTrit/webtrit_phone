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
}
