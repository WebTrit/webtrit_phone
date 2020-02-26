import 'package:flutter/material.dart';

class KeypadPage extends StatelessWidget {
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
