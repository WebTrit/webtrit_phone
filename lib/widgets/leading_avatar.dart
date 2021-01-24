import 'package:flutter/material.dart';

class LeadingAvatar extends StatelessWidget {
  LeadingAvatar({
    Key key,
    this.username,
  }) : super(key: key);

  final String username;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.blue.shade100,
      child: Text(username.trim().split(' ').map((v) => v[0]).join()),
    );
  }
}
