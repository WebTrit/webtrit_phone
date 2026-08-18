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
