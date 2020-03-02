import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: Center(
        child: Icon(
          Icons.mail,
          size: 120,
        ),
      ),
    );
  }
}
