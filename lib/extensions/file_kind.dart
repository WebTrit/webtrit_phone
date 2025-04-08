import 'package:flutter/material.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/file_kind.dart';

extension FileKindExtensionL10n on FileKind {
  String l10n(BuildContext context) {
    switch (this) {
      case FileKind.image:
        return context.l10n.file_kind_image;
      case FileKind.video:
        return context.l10n.file_kind_video;
      case FileKind.audio:
        return context.l10n.file_kind_audio;
      case FileKind.document:
        return context.l10n.file_kind_document;
      case FileKind.other:
        return context.l10n.file_kind_other;
    }
  }
}
