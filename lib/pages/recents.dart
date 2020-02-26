import 'package:flutter/material.dart';

class RecentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recents'),
      ),
      body: Center(
        child: Icon(
          Icons.history,
          size: 120,
        ),
      ),
    );
  }
}
