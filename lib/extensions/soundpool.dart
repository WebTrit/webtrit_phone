import 'package:flutter/services.dart';

import 'package:soundpool/soundpool.dart';

extension SoundpoolExtension on Soundpool {
  Future<int> loadAsset(String path) async {
    final byteData = await rootBundle.load(path);
    final soundId = await load(byteData);
    return soundId;
  }
}
