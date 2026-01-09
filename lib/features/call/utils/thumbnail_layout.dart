import 'package:flutter/material.dart';

class ThumbnailLayout {
  ThumbnailLayout._();

  static const double defaultSmallerSide = 90.0;
  static const double aspectRatio = 16.0 / 9.0;

  static Size calcFrameSize({required Orientation orientation, double smallerSide = defaultSmallerSide}) {
    final biggerSide = smallerSide * aspectRatio;

    final frameWidth = orientation == Orientation.portrait ? smallerSide : biggerSide;
    final frameHeight = orientation == Orientation.portrait ? biggerSide : smallerSide;

    return Size(frameWidth, frameHeight);
  }
}
