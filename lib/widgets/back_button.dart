import 'package:flutter/material.dart';

class ExtBackButton extends StatelessWidget {
  const ExtBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
      ),
      onPressed: () {
        Navigator.maybePop(context);
      },
    );
  }
}
