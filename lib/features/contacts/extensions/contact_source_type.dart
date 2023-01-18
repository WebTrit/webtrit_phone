import 'package:flutter/material.dart';

import 'package:webtrit_phone/models/models.dart';

import '../features/contacts_local_tab/contacts_local_tab.dart';
import '../features/contacts_external_tab/contacts_external_tab.dart';

extension ContactSourceTypeBuilder on ContactSourceType {
  Widget builder(BuildContext context) {
    switch (this) {
      case ContactSourceType.local:
        return const ContactsLocalTab();
      case ContactSourceType.external:
        return const ContactsExternalTab();
    }
  }
}
