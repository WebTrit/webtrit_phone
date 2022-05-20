import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

class ClearedTextField extends StatefulWidget {
  const ClearedTextField({
    Key? key,
    this.initialValue,
    this.onChanged,
    this.onSubmitted,
    this.iconConstraints,
  }) : super(key: key);

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
    return TextField(
      controller: _controller,
      textAlignVertical: TextAlignVertical.center,
      decoration: inputDecorations?.search?.copyWith(
        prefixIcon: const Icon(Icons.search),
        prefixIconConstraints: widget.iconConstraints,
        suffixIcon: _isEmpty
            ? null
            : IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _isEmpty = true;
                  });
                  _controller.clear();
                  widget.onChanged?.call('');
                },
                constraints: widget.iconConstraints,
              ),
        suffixIconConstraints: widget.iconConstraints,
      ),
      textInputAction: TextInputAction.search,
      onChanged: (value) {
        setState(() {
          _isEmpty = value.isEmpty;
        });
        widget.onChanged?.call(value);
      },
      onSubmitted: (value) => widget.onSubmitted,
    );
  }
}
