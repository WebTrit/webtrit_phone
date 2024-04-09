import 'package:http/http.dart' as http;

http.Client createHttpClient({
  Duration? connectionTimeout,
  List<(List<int> bytes, String? password)> certs = const [],
}) {
  throw UnsupportedError('No implementation of the api provided');
}
