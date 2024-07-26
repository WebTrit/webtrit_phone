import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/collection.dart';
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
  final Widget Function(BuildContext, Contact?) builder;

  @override
  State<ContactInfoBuilder> createState() => _ContactInfoBuilderState();
}

class _ContactInfoBuilderState extends State<ContactInfoBuilder> {
  late final contactsRepo = context.read<ContactsRepository>();
  static final cache = LruMap<String, Contact>(maximumSize: 100);
  Contact? contact;

  @override
  void initState() {
    super.initState();
    contact = cache[widget.sourceId];
    if (contact == null) {
      contactsRepo.getContactBySource(widget.sourceType, widget.sourceId).then((contact) {
        if (contact == null) return;
        cache.putIfAbsent(widget.sourceId, () => contact);
        if (mounted) setState(() => this.contact = contact);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, contact);
  }
}
