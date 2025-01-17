import 'package:flutter/material.dart';

class AgreementCheckbox extends StatelessWidget {
  const AgreementCheckbox({
    super.key,
    required this.text,
    required this.agreementAccepted,
    required this.onChanged,
  });

  final String text;
  final bool agreementAccepted;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.translate(
          offset: const Offset(-8, 0),
          child: Checkbox(
            value: agreementAccepted,
            onChanged: (value) => onChanged(value ?? false),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        Expanded(
          child: Text(text),
        ),
      ],
    );
  }
}
