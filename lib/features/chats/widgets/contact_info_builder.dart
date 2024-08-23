import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class ContactInfoBuilder extends StatefulWidget {
  const ContactInfoBuilder({
    required this.sourceType,
    required this.sourceId,
    required this.builder,
    super.key,
  });

  final ContactSourceType sourceType;
  final String sourceId;
  final Widget Function(BuildContext, Contact?, {required bool loading}) builder;

  @override
  State<ContactInfoBuilder> createState() => _ContactInfoBuilderState();
}

class _ContactInfoBuilderState extends State<ContactInfoBuilder> {
  late final contactsRepo = context.read<ContactsRepository>();
  late final StreamSubscription contactSub;

  Contact? contact;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    contactSub = contactsRepo.watchContactBySource(widget.sourceType, widget.sourceId).listen((ct) {
      loading = false;
      if (mounted) setState(() => contact = ct);
    });
  }

  @override
  void dispose() {
    contactSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, contact, loading: loading);
  }
}
