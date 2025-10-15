import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/collection.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

sealed class ContactBuilderSource {}

final class ContactSourcePhone extends ContactBuilderSource {
  ContactSourcePhone(this.phoneNumber);

  final String phoneNumber;
}

final class ContactSourceId extends ContactBuilderSource {
  ContactSourceId(this.sourceType, this.sourceId);

  final ContactSourceType sourceType;
  final String sourceId;
}

class ContactInfoBuilder extends StatefulWidget {
  const ContactInfoBuilder({
    required this.source,
    required this.builder,
    super.key,
  });

  final ContactBuilderSource source;
  final Widget Function(BuildContext, Contact?) builder;

  @override
  State<ContactInfoBuilder> createState() => _ContactInfoBuilderState();
}

class _ContactInfoBuilderState extends State<ContactInfoBuilder> {
  late final contactsRepo = context.read<ContactsRepository>();
  static final valuesPool = LruMap<String, Contact>(maximumSize: 100);
  StreamSubscription? contactSub;

  Contact? contact;

  @override
  void initState() {
    super.initState();
    // Try to get value from pool first and use it sinchronously before the stream emits the value.
    // then subscribe to updates and update info only when it changes.
    // this helps to avoid flickering and reduces rebuilds when the same contact is used in multiple places on one screen.
    //
    // Note: This approach not uses broadcast streams pool as it was before 1.8.0
    // because drift does the same optimization for watch query internally

    final key = switch (widget.source) {
      ContactSourcePhone(phoneNumber: var number) => 'phone:$number',
      ContactSourceId(sourceType: var type, sourceId: var id) => 'id:${type.name}:$id',
    };
    contact = valuesPool[key];
    final stream = switch (widget.source) {
      ContactSourcePhone(phoneNumber: var number) => contactsRepo.watchContactByPhoneNumber(number),
      ContactSourceId(sourceType: var type, sourceId: var id) =>
        contactsRepo.watchContactBySourceWithPhonesAndEmails(type, id),
    };
    contactSub = stream.listen(
      (contact) {
        if (contact != null && contact != this.contact) {
          this.contact = contact;
          if (mounted) setState(() {});
        }
        if (contact != null && contact != valuesPool[key]) {
          valuesPool[key] = contact;
        }
      },
    );
  }

  @override
  void dispose() {
    contactSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, contact);
  }
}
