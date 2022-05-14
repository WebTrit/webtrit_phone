extension DurationFormatting on Duration {
  String format() {
    return [inHours, inMinutes, inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }
}
