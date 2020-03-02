import 'package:flutter/material.dart';

class RecentsPage extends StatelessWidget {
  const RecentsPage({ Key key }) : super(key: key);

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
