import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:webtrit_phone/extensions/extensions.dart';

abstract class ResourceLoader {
  final Uri resourceUri;

  ResourceLoader(this.resourceUri);

  /// Factory method to create a specific [ResourceLoader] based on the resource URI scheme.
  factory ResourceLoader.fromUri(String value) {
    final uri = Uri.parse(value);

    if (NetworkResourceLoader.supportedSchemes.contains(uri.scheme)) {
      return NetworkResourceLoader(uri);
    } else if (AssetResourceLoader.supportedSchemes.contains(uri.scheme)) {
      return AssetResourceLoader(uri);
    } else if (MemoryResourceLoader.supportedSchemes.contains(uri.scheme)) {
      return MemoryResourceLoader(uri);
    }

    throw ArgumentError('Unsupported resource scheme: ${uri.scheme}');
  }

  /// Whether [ResourceLoader.fromUri] can build a loader for [uri].
  ///
  /// [ResourceLoader.fromUri] throws on an unknown scheme, and callers that
  /// resolve a resource while building a widget cannot catch that. Ask this
  /// first to decide whether the resource is openable at all.
  static bool supportsUri(Uri uri) =>
      NetworkResourceLoader.supportedSchemes.contains(uri.scheme) ||
      AssetResourceLoader.supportedSchemes.contains(uri.scheme) ||
      MemoryResourceLoader.supportedSchemes.contains(uri.scheme);

  /// Loads the content of the resource (network, asset, or memory).
  Future<String> loadContent();
}

class NetworkResourceLoader extends ResourceLoader {
  static const supportedSchemes = ['https', 'http'];

  NetworkResourceLoader(super.resourceUri);

  @override
  Future<String> loadContent() async {
    // Simply returning the resource URI as a string for network resources.
    return resourceUri.toString();
  }
}

class AssetResourceLoader extends ResourceLoader {
  static const supportedSchemes = ['asset'];

  AssetResourceLoader(Uri resourceUri) : super(resourceUri.removeScheme());

  @override
  Future<String> loadContent() async {
    try {
      return await rootBundle.loadString(resourceUri.toString());
    } catch (e) {
      throw Exception('Error loading asset at ${resourceUri.path}: $e');
    }
  }
}

class MemoryResourceLoader extends ResourceLoader {
  static const supportedSchemes = ['memory'];

  final Uint8List bytes;

  MemoryResourceLoader(super.resourceUri) : bytes = base64Decode(resourceUri.removeScheme().toString());

  @override
  Future<String> loadContent() async {
    // Returning the base64-encoded content as a string.
    return base64Encode(bytes);
  }
}
