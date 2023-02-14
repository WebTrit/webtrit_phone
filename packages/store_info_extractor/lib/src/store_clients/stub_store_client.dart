import '../models/models.dart';
import 'store_client.dart';

class StubStoreClient extends StoreClient {
  StubStoreClient();

  @override
  Future<StoreInfo?> getStoreInfo(String appPackageName) async {
    return null;
  }
}
