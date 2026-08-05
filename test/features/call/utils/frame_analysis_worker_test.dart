import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

import 'package:webtrit_phone/features/call/utils/frame_analysis_worker.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/// Creates a solid-colour RGBA PNG of the given dimensions.
Uint8List _solidPng(int width, int height, {required int r, required int g, required int b, int a = 255}) {
  final image = img.Image(width: width, height: height, numChannels: 4);
  img.fill(image, color: img.ColorRgba8(r, g, b, a));
  return img.encodePng(image);
}

/// Returns the expected luma for a uniform r/g/b value (same formula as the
/// production code) so tests stay in sync with the threshold constant.
int _luma(int r, int g, int b) => (r * 299 + g * 587 + b * 114) ~/ 1000;

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('analyzeFrameInIsolate', () {
    // --- empty / invalid input -----------------------------------------------

    test('returns true for empty bytes', () {
      expect(analyzeFrameInIsolate(Uint8List(0)), isTrue);
    });

    test('returns true for bytes that are not a valid image', () {
      expect(analyzeFrameInIsolate(Uint8List.fromList([0x00, 0x01, 0x02, 0x03])), isTrue);
    });

    // --- solid colour frames -------------------------------------------------

    test('returns true for a solid black frame', () {
      expect(_luma(0, 0, 0), lessThanOrEqualTo(16)); // sanity-check the threshold
      final png = _solidPng(64, 64, r: 0, g: 0, b: 0);
      expect(analyzeFrameInIsolate(png), isTrue);
    });

    test('returns true for a near-black frame whose luma equals the threshold', () {
      // r=g=b=16 → luma = (16*299 + 16*587 + 16*114) / 1000 = 16 ≤ 16
      expect(_luma(16, 16, 16), equals(16));
      final png = _solidPng(64, 64, r: 16, g: 16, b: 16);
      expect(analyzeFrameInIsolate(png), isTrue);
    });

    test('returns false for a frame whose luma is just above the threshold', () {
      // r=g=b=17 → luma = 17 > 16
      expect(_luma(17, 17, 17), equals(17));
      final png = _solidPng(64, 64, r: 17, g: 17, b: 17);
      expect(analyzeFrameInIsolate(png), isFalse);
    });

    test('returns false for a solid white frame', () {
      final png = _solidPng(64, 64, r: 255, g: 255, b: 255);
      expect(analyzeFrameInIsolate(png), isFalse);
    });

    test('returns false for a solid red frame', () {
      final png = _solidPng(64, 64, r: 255, g: 0, b: 0);
      expect(analyzeFrameInIsolate(png), isFalse);
    });

    test('returns false for a solid green frame', () {
      final png = _solidPng(64, 64, r: 0, g: 255, b: 0);
      expect(analyzeFrameInIsolate(png), isFalse);
    });

    // --- alpha ---------------------------------------------------------------

    test('returns true for a fully transparent frame (no opaque pixels)', () {
      final png = _solidPng(64, 64, r: 255, g: 255, b: 255, a: 0);
      expect(analyzeFrameInIsolate(png), isTrue);
    });

    // --- black-pixel ratio boundary ------------------------------------------
    //
    // Use a 100×1 image so step = max(1, 100÷1200) = 1 and every pixel is
    // sampled, giving exact control over the ratio.

    test('returns true when exactly 98% of opaque pixels are black (at threshold)', () {
      final image = img.Image(width: 100, height: 1, numChannels: 4);
      for (var x = 0; x < 98; x++) {
        image.setPixel(x, 0, img.ColorRgba8(0, 0, 0, 255)); // black
      }
      for (var x = 98; x < 100; x++) {
        image.setPixel(x, 0, img.ColorRgba8(255, 255, 255, 255)); // white
      }
      expect(analyzeFrameInIsolate(img.encodePng(image)), isTrue);
    });

    test('returns false when 97% of opaque pixels are black (below threshold)', () {
      final image = img.Image(width: 100, height: 1, numChannels: 4);
      for (var x = 0; x < 97; x++) {
        image.setPixel(x, 0, img.ColorRgba8(0, 0, 0, 255)); // black
      }
      for (var x = 97; x < 100; x++) {
        image.setPixel(x, 0, img.ColorRgba8(255, 255, 255, 255)); // white
      }
      expect(analyzeFrameInIsolate(img.encodePng(image)), isFalse);
    });

    // --- degenerate geometry -------------------------------------------------

    test('returns true for a 0×0 image (no pixels)', () {
      // img.Image(0,0) encodes to a valid PNG with empty pixel data.
      final png = img.encodePng(img.Image(width: 0, height: 0));
      expect(analyzeFrameInIsolate(png), isTrue);
    });

    test('returns true for a 1×1 black pixel', () {
      final png = _solidPng(1, 1, r: 0, g: 0, b: 0);
      expect(analyzeFrameInIsolate(png), isTrue);
    });

    test('returns false for a 1×1 white pixel', () {
      final png = _solidPng(1, 1, r: 255, g: 255, b: 255);
      expect(analyzeFrameInIsolate(png), isFalse);
    });
  });
}
