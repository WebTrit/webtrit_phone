class RepositoryOptions {
  const RepositoryOptions({
    this.shouldOperate = true,
    this.polling = true,
    this.pollPeriod = const Duration(minutes: 5),
  });

  final bool shouldOperate;
  final bool polling;
  final Duration pollPeriod;

  factory RepositoryOptions.defaultOptions() => const RepositoryOptions();
}
