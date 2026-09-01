import 'package:gravatar_utils/gravatar_utils.dart';

Uri? gravatarThumbnailUrl(String? email, {DefaultImage defaultImage = DefaultImage.fileNotFound}) {
  return email != null ? Gravatar(email).image(scheme: 'https', defaultImage: defaultImage) : null;
}

/// Re-requests a Gravatar URL at [sizePx] pixels.
///
/// Gravatar serves 80x80 by default, which is enough for a list row but visibly soft on
/// a large avatar, so consumers that render big ask for the size they actually need.
/// Non-Gravatar URLs are returned unchanged.
Uri? gravatarUrlWithSize(Uri? url, int sizePx) {
  if (url == null || !url.host.endsWith('gravatar.com')) return url;

  final size = sizePx.clamp(1, 2048);
  return url.replace(queryParameters: {...url.queryParameters, 's': '$size'});
}

/// The sizes a Gravatar is actually asked for.
///
/// A url is an image cache key, so asking for the exact pixel count of every avatar on
/// screen would give the same face a separate download and a separate cache entry in
/// each place it appears. Rounding up to one of a few sizes lets those places share one.
const List<int> _gravatarRequestSizes = [128, 256, 512, 1024, 2048];

/// The size to ask Gravatar for when [devicePixels] will be painted: the smallest of
/// [_gravatarRequestSizes] that is not smaller than what is painted.
int gravatarRequestSize(double devicePixels) {
  return _gravatarRequestSizes.firstWhere((size) => size >= devicePixels, orElse: () => _gravatarRequestSizes.last);
}
