import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

import 'package:store_info_extractor/src/store_clients/google_play_store_client.dart';
import 'package:store_info_extractor/store_info_extractor.dart';

void main() {
  test('getSoreInfo', () async {
    Future<Response> handler(Request request) async {
      expect(request.method, equalsIgnoringCase('get'));
      expect(request.url.toString(), equals('https://play.google.com/store/apps/details?id=app.package.name'));
      expect(request.headers['authorization'], isNull);
      return Response(
        '''
        <!doctype html>
        <html lang="en" dir="ltr">
        <head>
            <base href="https://play.google.com/">
        <!-- cut for shortness -->
        </head>
        <body>
        <!-- cut for shortness -->
            <script nonce="CO4IzgVFrtQMSc9oaKlczQ">
            AF_initDataCallback({
                key: 'ds:6',
                hash: '11',
                data: [..., null, [[["1.0.0"]], ... , []],
                sideChannel: {}
            });
            </script>
        <!-- cut for shortness -->
        </body>
        </html>
        ''',
        200,
        request: request,
      );
    }

    final httpClient = MockClient(expectAsync1(handler));
    final storeClient = GooglePlayStoreClient(httpClient: httpClient);
    final storeInfo = await storeClient.getStoreInfo('app.package.name');

    expect(
      storeInfo,
      equals(
        StoreInfo(
          version: Version(1, 0, 0),
          viewUrl: Uri.parse('https://play.google.com/store/apps/details?id=app.package.name'),
        ),
      ),
    );
  });
}
