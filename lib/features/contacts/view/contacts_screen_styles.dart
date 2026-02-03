import 'package:flutter/material.dart';

import 'contacts_screen_style.dart';

class ContactsScreenStyles extends ThemeExtension<ContactsScreenStyles> {
  const ContactsScreenStyles({required this.primary});

  final ContactsScreenStyle? primary;

  @override
  ContactsScreenStyles copyWith({ContactsScreenStyle? primary}) {
    return ContactsScreenStyles(primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<ContactsScreenStyles> lerp(ThemeExtension<ContactsScreenStyles>? other, double t) {
    if (other is! ContactsScreenStyles) return this;
    return ContactsScreenStyles(primary: ContactsScreenStyle.lerp(primary, other.primary, t));
  }
}
