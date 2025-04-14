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
}
