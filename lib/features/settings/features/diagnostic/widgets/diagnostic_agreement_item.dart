import 'package:flutter/material.dart';

import 'package:webtrit_phone/models/models.dart';

import '../extensions/extensions.dart';

class DiagnosticAgreementItem extends StatelessWidget {
  const DiagnosticAgreementItem({
    super.key,
    this.onTap,
    required this.title,
    required this.description,
    required this.status,
  });

  final String title;
  final String description;
  final AgreementStatus status;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(title),
      subtitle: Text(description),
      trailing: Icon(status.icon, color: status.color),
    );
  }
}
