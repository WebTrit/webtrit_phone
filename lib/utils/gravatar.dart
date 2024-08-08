import 'package:gravatar_utils/gravatar_utils.dart';

Uri? gravatarThumbnailUrl(
  String? email, {
  DefaultImage defaultImage = DefaultImage.fileNotFound,
}) {
  return email != null ? Gravatar(email).image(scheme: 'https', defaultImage: defaultImage) : null;
}
