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
  /// [ResourceLoader.fromUri] throws, and callers that resolve a resource while
  /// building a widget cannot catch that. Ask this first to decide whether the
  /// resource can be opened at all.
  ///
  /// Answered by building the loader rather than by listing the schemes again:
  /// a claimed scheme is not enough on its own, since a loader may also reject
  /// the rest of the URI - [MemoryResourceLoader] decodes its payload eagerly.
  /// Deriving the answer this way also keeps it true for a loader added later.
  static bool supportsUri(Uri uri) {
    try {
      ResourceLoader.fromUri(uri.toString());
      return true;
    } catch (_) {
      return false;
    }
  }

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

  /// Carries its content inline, so it must be written as `memory:<base64>`.
  ///
  /// The `memory://<base64>` spelling cannot work and is rejected rather than
  /// decoded: everything after `//` is the authority, which is case-folded when
  /// the URI is parsed, so the payload arrives here already ruined. Refusing it
  /// keeps the damage visible instead of decoding it into silent nonsense.
  MemoryResourceLoader(super.resourceUri) : bytes = base64Decode(_payloadOf(resourceUri));

  static String _payloadOf(Uri resourceUri) {
    if (resourceUri.hasAuthority) {
      throw ArgumentError.value(
        resourceUri.toString(),
        'resourceUri',
        'inline content must follow a single colon, as its capitals are lost after "//"',
      );
    }
    return resourceUri.removeScheme().toString();
  }

  @override
  Future<String> loadContent() async {
    // Returning the base64-encoded content as a string.
    return base64Encode(bytes);
  }
}
