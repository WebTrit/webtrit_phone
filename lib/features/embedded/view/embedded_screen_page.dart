import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class EmbeddedScreenPage extends StatelessWidget {
  const EmbeddedScreenPage({
    @PathParam('id') required this.id,
  });

  final String? id;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('EmbeddedScreenPage: $id'),
    );
  }
}