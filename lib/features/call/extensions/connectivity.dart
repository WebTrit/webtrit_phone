import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:webtrit_phone/models/models.dart';

extension ConnectivityResultX on ConnectivityResult {
  NetworkStatus toNetworkStatus() {
    switch (this) {
      case ConnectivityResult.wifi:
        return NetworkStatus.available;
      case ConnectivityResult.mobile:
        return NetworkStatus.available;
      case ConnectivityResult.ethernet:
        return NetworkStatus.available;
      case ConnectivityResult.none:
        return NetworkStatus.none;
      default:
        return NetworkStatus.none;
    }
  }
}
