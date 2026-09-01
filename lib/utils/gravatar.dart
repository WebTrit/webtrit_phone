import 'package:gravatar_utils/gravatar_utils.dart';

/// The Gravatar urls the app asks for.
///
/// Gravatar serves 80x80 unless a size is asked for, which is enough for a list row and
/// visibly soft anywhere bigger, so every consumer states the size it paints.
class GravatarUrl {
  const GravatarUrl._();

  /// The sizes actually asked for.
  ///
  /// A url is an image cache key, so asking for the exact pixel count of every avatar on
  /// screen would give the same face a separate download and a separate cache entry in
  /// each place it appears. Rounding up to one of a few sizes lets those places share one.
  static const List<int> _requestSizes = [128, 256, 512, 1024, 2048];

  /// The url of [email]'s Gravatar, or null when there is no address to derive it from.
  static Uri? forEmail(String? email, {DefaultImage defaultImage = DefaultImage.fileNotFound}) {
    return email != null ? Gravatar(email).image(scheme: 'https', defaultImage: defaultImage) : null;
  }

  /// [url] re-requested at [sizePx] pixels. A url that is not a Gravatar is returned unchanged.
  static Uri? withSize(Uri? url, int sizePx) {
    if (url == null || !url.host.endsWith('gravatar.com')) return url;

    final size = sizePx.clamp(1, _requestSizes.last);
    return url.replace(queryParameters: {...url.queryParameters, 's': '$size'});
  }

  /// The size to ask for when [devicePixels] will be painted: the smallest of
  /// [_requestSizes] that is not smaller than what is painted.
  static int requestSize(double devicePixels) {
    return _requestSizes.firstWhere((size) => size >= devicePixels, orElse: () => _requestSizes.last);
  }
}
