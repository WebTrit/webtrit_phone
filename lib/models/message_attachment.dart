import 'dart:convert';

import 'package:equatable/equatable.dart';

class MessageAttachment extends Equatable {
  const MessageAttachment({
    required this.id,
    required this.fileName,
    required this.filePath,
  });

  final int id;
  final String fileName;
  final String filePath;

  @override
  List<Object?> get props => [
        id,
        fileName,
        filePath,
      ];
  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fileName': fileName,
      'filePath': filePath,
    };
  }

  factory MessageAttachment.fromMap(Map<String, dynamic> map) {
    return MessageAttachment(
      id: map['id'] as int,
      fileName: map['fileName'] as String,
      filePath: map['filePath'] as String,
    );
  }

  String toJson() => json.encode(toMap());
  factory MessageAttachment.fromJson(String source) =>
      MessageAttachment.fromMap(json.decode(source) as Map<String, dynamic>);
}
