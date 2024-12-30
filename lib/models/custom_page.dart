import 'package:equatable/equatable.dart';

class CustomPage with EquatableMixin {
  final String title;
  final Uri url;
  final Map<String, dynamic> extraData;
  final String? description;
  final DateTime? expiresAt;

  CustomPage({
    required this.title,
    required this.url,
    required this.extraData,
    this.description,
    this.expiresAt,
  });

  @override
  List<Object?> get props {
    return [title, url, extraData, description, expiresAt];
  }

  @override
  bool get stringify => true;
}
