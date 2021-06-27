import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class LocalContact extends Equatable {
  LocalContact({
    required this.displayName,
    this.thumbnail,
  });

  final String displayName;
  final Uint8List? thumbnail;

  @override
  List<Object?> get props => [
        displayName,
        thumbnail,
      ];
}
