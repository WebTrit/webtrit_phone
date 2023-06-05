import 'package:flutter/material.dart';

class KeypadOverlayDialog extends StatelessWidget {
  const KeypadOverlayDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              children: List.generate(9, (index) {
                int number = index + 1;
                return TextButton(
                  onPressed: () {
                    handleButtonPress(number);
                  },
                  child: Text(
                    '$number',
                    style: const TextStyle(fontSize: 20),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void handleButtonPress(dynamic value) {}
}
