import 'package:flutter/material.dart';

class KeypadPage extends StatelessWidget {
  const KeypadPage({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keypad'),
      ),
      body: Center(
        child: Icon(
          Icons.dialpad,
          size: 120,
        ),
      ),
    );
  }
}
