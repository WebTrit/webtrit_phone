import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/utils/regexes.dart';

class ClearedTextField extends StatefulWidget {
  const ClearedTextField({
    super.key,
    this.initialValue,
    this.onChanged,
    this.onSubmitted,
    this.iconConstraints,
  });

  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final BoxConstraints? iconConstraints;

  @override
  ClearedTextFieldState createState() => ClearedTextFieldState();
}

class ClearedTextFieldState extends State<ClearedTextField> {
  final _controller = TextEditingController();
  late bool _isEmpty;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue ?? '';
    _isEmpty = widget.initialValue?.isEmpty ?? true;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final InputDecorations? inputDecorations = themeData.extension<InputDecorations>();
    final iconConstraints = widget.iconConstraints;
    return Ink(
      decoration: BoxDecoration(
        color: themeData.colorScheme.surfaceBright,
        borderRadius: iconConstraints == null ? null : BorderRadius.circular(iconConstraints.minHeight / 2),
      ),
      child: TextField(
        controller: _controller,
        textAlignVertical: TextAlignVertical.center,
        decoration: inputDecorations?.search?.copyWith(
          prefixIcon: const Icon(Icons.search),
          prefixIconConstraints: iconConstraints,
          suffixIcon: _isEmpty
              ? null
              : IconButton(
                  key: contactsSerchInputClearKey,
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      _isEmpty = true;
                    });
                    _controller.clear();
                    widget.onChanged?.call('');
                  },
                  constraints: iconConstraints,
                ),
          suffixIconConstraints: iconConstraints,
        ),
        textInputAction: TextInputAction.search,
        onChanged: (value) {
          setState(() {
            _isEmpty = value.isEmpty;
          });
          widget.onChanged?.call(value);
        },
        onSubmitted: (value) => widget.onSubmitted,
        inputFormatters: [FilteringTextInputFormatter.deny(RegExp(symbolsRegex))],
      ),
    );
  }
}
