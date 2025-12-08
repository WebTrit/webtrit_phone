import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Element;
import 'package:html/dom.dart' show Document, Element;
import 'package:html/parser.dart' as parser show parse;
import 'package:http/http.dart' as http show get;
import 'package:logging/logging.dart';

final _logger = Logger('get_og_preview');

/// Represents an Open Graph like preview data for a given url
/// can be used to display social media link previews or regular web image previews
class OgPreview with EquatableMixin {
  const OgPreview._({this.title, this.description, this.imageUrl});

  final String? title;
  final String? description;
  final String? imageUrl;

  @override
  List<Object?> get props => [description, imageUrl, title];

  @override
  bool get stringify => true;

  static Future<OgPreview?> get(String url, {bool useIsolate = true}) {
    if (useIsolate) {
      return compute(_getOgPreview, url);
    } else {
      return _getOgPreview(url);
    }
  }
}

Future<OgPreview?> _getOgPreview(String url) async {
  String? title;
  String? description;
  String? imageUrl;

  try {
    // Add https if not present
    if (!url.startsWith('http')) url = 'https://$url';

    // Check if the url is an image file
    if (RegExp(r'\.(png|jpe?g|gif|svg|webp)').hasMatch(url)) {
      return OgPreview._(imageUrl: url);
    }

    // Get the website content
    final resp = await http.get(Uri.parse(url), headers: {'User-Agent': 'WhatsApp/2'});
    final doc = parser.parse(utf8.decode(resp.bodyBytes));

    // Check if the content is an image and return the image url
    if (RegExp(r'image\/*').hasMatch(resp.headers['content-type'] ?? '')) {
      return OgPreview._(imageUrl: url);
    }

    // Parse the documents contect
    title = _getTitle(doc)?.trim();
    description = _getDescription(doc)?.trim();
    final imageUrls = _getImageUrls(doc, url);
    if (imageUrls.isNotEmpty) imageUrl = await _selectBiggestImage(imageUrls);
  } catch (e) {
    _logger.info('Failed to get Open grapg preview for $url', e);
  }

  final hasTitle = title?.isNotEmpty ?? false;
  final hasDescription = description?.isNotEmpty ?? false;
  final hasImageUrl = imageUrl?.isNotEmpty ?? false;

  if (hasTitle || hasDescription || hasImageUrl) {
    return OgPreview._(title: title, description: description, imageUrl: imageUrl);
  }

  return null;
}

String? _getMetaData(Document document, String propertyValue) {
  final meta = document.getElementsByTagName('meta');
  final element = meta.firstWhere(
    (e) => e.attributes['property'] == propertyValue,
    orElse: () => meta.firstWhere((e) => e.attributes['name'] == propertyValue, orElse: () => Element.tag(null)),
  );

  return element.attributes['content']?.trim();
}

String? _getTitle(Document document) {
  return document.getElementsByTagName('title').firstOrNull?.text ??
      _getMetaData(document, 'og:title') ??
      _getMetaData(document, 'twitter:title') ??
      _getMetaData(document, 'og:site_name');
}

String? _getDescription(Document document) {
  return _getMetaData(document, 'og:description') ??
      _getMetaData(document, 'description') ??
      _getMetaData(document, 'twitter:description');
}

List<String> _getImageUrls(Document document, String baseUrl) {
  final meta = document.getElementsByTagName('meta');
  var attribute = 'content';

  var elements = meta.where((e) {
    var prop = e.attributes['property'];
    return prop == 'og:image' || prop == 'twitter:image';
  });

  if (elements.isEmpty) {
    elements = document.getElementsByTagName('img');
    attribute = 'src';
  }

  return elements.fold<List<String>>([], (previousValue, element) {
    final actualImageUrl = _tryGetImageUrl(baseUrl, element.attributes[attribute]?.trim());
    return actualImageUrl != null ? [...previousValue, actualImageUrl] : previousValue;
  });
}

String? _tryGetImageUrl(String baseUrl, String? imageUrl) {
  if (imageUrl == null || imageUrl.isEmpty || imageUrl.startsWith('data')) return null;

  if (imageUrl.contains('.svg') || imageUrl.contains('.gif')) return null;

  if (imageUrl.startsWith('//')) imageUrl = 'https:$imageUrl';

  if (!imageUrl.startsWith('http')) {
    if (baseUrl.endsWith('/') && imageUrl.startsWith('/')) {
      imageUrl = '${baseUrl.substring(0, baseUrl.length - 1)}$imageUrl';
    } else if (!baseUrl.endsWith('/') && !imageUrl.startsWith('/')) {
      imageUrl = '$baseUrl/$imageUrl';
    } else {
      imageUrl = '$baseUrl$imageUrl';
    }
  }

  return imageUrl;
}

Future<Size> _getImageSize(String url) {
  final completer = Completer<Size>();
  final stream = Image.network(url).image.resolve(ImageConfiguration.empty);
  late ImageStreamListener streamListener;

  void onError(Object error, StackTrace? stackTrace) {
    completer.completeError(error, stackTrace);
  }

  void listener(ImageInfo info, bool _) {
    if (!completer.isCompleted) {
      completer.complete(Size(info.image.height.toDouble(), info.image.width.toDouble()));
    }
    stream.removeListener(streamListener);
  }

  streamListener = ImageStreamListener(listener, onError: onError);

  stream.addListener(streamListener);
  return completer.future;
}

Future<String> _selectBiggestImage(List<String> imageUrls) async {
  if (imageUrls.length == 1) return imageUrls[0];

  var lastUrl = imageUrls[0];
  var lastSize = 0.0;

  for (var url in imageUrls) {
    final size = await _getImageSize(url);
    if (size.width * size.height > lastSize) {
      lastSize = size.width * size.height;
      lastUrl = url;
    }
  }

  return lastUrl;
}
