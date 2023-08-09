import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/svg.dart';

import 'package:webtrit_phone/app/assets.gen.dart';

class SvgNotifier extends ChangeNotifier {
  SvgNotifier({
    String? url,
    Uint8List? bytes,
    SvgGenImage? asset,
    SvgGenImage svgGenImage = Assets.logo,
  }) {
    notify(url: url, bytes: bytes, asset: asset, svgGenImage: svgGenImage);
  }

  BytesLoader? _bytesLoader;

  BytesLoader? get svg => _bytesLoader;

  void notify({
    String? url,
    Uint8List? bytes,
    SvgGenImage? asset,
    SvgGenImage svgGenImage = Assets.logo,
  }) async {
    if (url != null) {
      _bytesLoader = SvgNetworkLoader(url);
    } else if (bytes != null) {
      _bytesLoader = SvgBytesLoader(bytes);
    } else if (asset != null) {
      _bytesLoader = SvgAssetLoader(asset.path);
    } else {
      _bytesLoader = SvgAssetLoader(svgGenImage.path);
    }
    notifyListeners();
  }

  void clean() {
    _bytesLoader = null;
    notifyListeners();
  }
}
