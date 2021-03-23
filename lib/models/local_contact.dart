import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
class LocalContact extends Equatable {
  LocalContact({
    this.displayName,
    this.thumbnail,
  });

  final String displayName;
  final Uint8List thumbnail;

  @override
  List<Object> get props => [
        displayName,
        thumbnail,
      ];
}
