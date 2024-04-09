import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;

http.Client createHttpClient({
  Duration? connectionTimeout,
  List<(List<int> bytes, String? password)> certs = const [],
}) {
  return BrowserClient();
}
