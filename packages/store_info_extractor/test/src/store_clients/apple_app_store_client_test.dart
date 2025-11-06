import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

import 'package:store_info_extractor/src/store_clients/apple_app_store_client.dart';
import 'package:store_info_extractor/store_info_extractor.dart';

void main() {
  test('getSoreInfo', () async {
    Future<Response> handler(Request request) async {
      expect(request.method, equalsIgnoringCase('get'));
      expect(request.url.toString(), equals('https://itunes.apple.com/lookup?bundleId=app.package.name'));
      return Response(
        '''
        {
          "resultCount":1,
          "results":[
            {
              "trackViewUrl":"https://apps.apple.com/us/app/name/id1234567890",
              "version":"1.0.0"
            }
          ]
        }
        ''',
        200,
        request: request,
      );
    }

    final httpClient = MockClient(expectAsync1(handler));
    final storeClient = AppleAppStoreClient(httpClient: httpClient);
    final storeInfo = await storeClient.getStoreInfo('app.package.name');

    expect(
      storeInfo,
      equals(
        StoreInfo(version: Version(1, 0, 0), viewUrl: Uri.parse('https://apps.apple.com/us/app/name/id1234567890')),
      ),
    );
  });
}
