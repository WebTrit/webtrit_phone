class RequestOptions {
  final int retries;
  final Duration retryDelay;

  const RequestOptions({
    this.retries = 0,
    this.retryDelay = const Duration(seconds: 1),
  });
}
