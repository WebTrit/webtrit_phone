import 'package:equatable/equatable.dart';

class OutboxAttachment extends Equatable {
  const OutboxAttachment({
    required this.id,
    required this.pickedPath,
    this.encodedPath,
    this.uploadedPath,
  });

  final String id;
  final String pickedPath;
  final String? encodedPath;
  final String? uploadedPath;

  @override
  List<Object?> get props => [id, pickedPath, encodedPath, uploadedPath];

  @override
  String toString() {
    return 'OutgoingAttachment{'
        'id: $id,'
        'pickedPath: $pickedPath,'
        'encodedPath: $encodedPath,'
        'uploadPath: $uploadedPath}';
  }

  OutboxAttachment copyWith({
    String? id,
    String? pickedPath,
    String? encodedPath,
    String? uploadedPath,
  }) {
    return OutboxAttachment(
      id: id ?? this.id,
      pickedPath: pickedPath ?? this.pickedPath,
      encodedPath: encodedPath ?? this.encodedPath,
      uploadedPath: uploadedPath ?? this.uploadedPath,
    );
  }

  double get progress {
    if (uploadedPath != null) return 1;
    if (encodedPath != null) return 0.5;
    return 0.2;
  }
}
