import 'dart:convert';
import 'package:equatable/equatable.dart';

class MediaFileMetadata extends Equatable {
  const MediaFileMetadata(
      {required this.fileName, required this.extension, required this.size, this.blurHash, this.duration});
  final String fileName;
  final String extension;
  final int size;
  final String? blurHash;
  final Duration? duration;

  MediaFileMetadata copyWith({
    String? fileName,
    String? extension,
    int? size,
    String? blurHash,
    Duration? duration,
  }) {
    return MediaFileMetadata(
      fileName: fileName ?? this.fileName,
      extension: extension ?? this.extension,
      size: size ?? this.size,
      blurHash: blurHash ?? this.blurHash,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fileName': fileName,
      'extension': extension,
      'size': size.toString(),
      'blurHash': blurHash,
      'duration': duration?.inMilliseconds.toString(),
    };
  }

  factory MediaFileMetadata.fromMap(Map<String, dynamic> map) {
    return MediaFileMetadata(
      fileName: map['fileName'] as String,
      extension: map['extension'] as String,
      size: int.parse(map['size']),
      blurHash: map['blurHash'] != null ? map['blurHash'] as String : null,
      duration: map['duration'] != null ? Duration(milliseconds: int.parse(map['duration'])) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MediaFileMetadata.fromJson(String source) =>
      MediaFileMetadata.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MediaFileMetadata(fileName: $fileName, extension: $extension, size: ${size / 1024} KB, blurHash: $blurHash, duration: $duration)';
  }

  @override
  List<Object> get props {
    return [fileName, extension, size, blurHash ?? '', duration ?? Duration.zero];
  }
}
