class RequestOptions {
  final int retries;
  final Duration retryDelay;

  const RequestOptions({
    this.retries = 3,
    this.retryDelay = const Duration(seconds: 1),
  });

  factory RequestOptions.withNoRetries() {
    return const RequestOptions(retries: 0, retryDelay: Duration(seconds: 1));
  }

  factory RequestOptions.withDefaultRetries() {
    return const RequestOptions(retries: 3, retryDelay: Duration(seconds: 1));
  }

  factory RequestOptions.withExtraRetries() {
    return const RequestOptions(retries: 5, retryDelay: Duration(seconds: 2));
  }
}
