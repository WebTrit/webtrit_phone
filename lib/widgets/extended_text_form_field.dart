import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:webtrit_phone_number/webtrit_phone_number.dart';

class ExtendedTextFormField extends StatelessWidget {
  const ExtendedTextFormField({
    super.key,
    this.initialValue,
    required this.decoration,
    this.includePrefixInData = false,
    this.onChanged,
    this.onFieldSubmitted,
    this.keyboardType,
    this.style,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
    this.enabled = true,
    this.autofillHints,
    this.maxLines = 1,
    this.obscureText = false,
  });

  final String? initialValue;
  final InputDecoration decoration;

  final bool includePrefixInData;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;

  final TextInputType? keyboardType;
  final TextStyle? style;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final Iterable<String>? autofillHints;
  final int? maxLines;
  final bool obscureText;

  bool get _isPhoneField => keyboardType == TextInputType.phone;

  @override
  Widget build(BuildContext context) {
    final prefixText = decoration.prefixText ?? '';

    return TextFormField(
      enabled: enabled,
      initialValue: _stripPrefix(initialValue, prefixText),
      decoration: decoration,
      keyboardType: keyboardType,
      style: style,
      textAlign: textAlign,
      inputFormatters: inputFormatters,
      autofillHints: autofillHints,
      maxLines: maxLines,
      obscureText: obscureText,

      onChanged: onChanged == null ? null : (raw) => onChanged!(_prepareValue(raw, prefixText)),

      onFieldSubmitted: onFieldSubmitted == null ? null : (raw) => onFieldSubmitted!(_prepareValue(raw, prefixText)),
    );
  }

  String _stripPrefix(String? value, String prefixText) {
    if (!includePrefixInData) return value ?? '';
    if (value == null || value.isEmpty) return '';
    if (prefixText.isEmpty) return value;
    if (!value.startsWith(prefixText)) return value;
    return value.substring(prefixText.length);
  }

  String _prepareValue(String raw, String prefixText) {
    String processed = raw;

    if (_isPhoneField) {
      processed = PhoneParser.normalize(processed);
    }

    if (includePrefixInData && prefixText.isNotEmpty) {
      processed = '$prefixText$processed';
    }

    return processed;
  }
}
