import 'dart:async';

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
    final e = ContactWatchPoolEntry(widget.sourceType, widget.sourceId, contactsRepo);
    setContact(e.value);
    contactSub = e.stream.listen((c) => setContact(c));
  }

  setContact(Contact? contact) {
    loading = false;
    this.contact = contact;
    if (mounted) setState(() {});
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

/// Pool of broadcast auto-closable [stream] for [Contact] with its last [value]
/// used to avoid invoking multiple streams and futures for same contact on same screen
class ContactWatchPoolEntry {
  ContactWatchPoolEntry._(this._sourceType, this._sourceId, this._contactsRepo) {
    _controller = StreamController<Contact?>.broadcast(onListen: _onListen, onCancel: _onCancel);
  }

  factory ContactWatchPoolEntry(ContactSourceType sourceType, String sourceId, ContactsRepository contactsRepo) {
    final key = '$sourceType:$sourceId';
    return _pool.putIfAbsent(key, () => ContactWatchPoolEntry._(sourceType, sourceId, contactsRepo));
  }

  static final _pool = <String, ContactWatchPoolEntry>{};
  static final _valueCache = LruMap<String, Contact>(maximumSize: 100);

  final ContactSourceType _sourceType;
  final String _sourceId;
  final ContactsRepository _contactsRepo;

  late StreamController<Contact?> _controller;
  StreamSubscription? _sub;

  /// Updates stream of contact
  Stream<Contact?> get stream => _controller.stream;

  /// Last cached value of contact
  Contact? get value => _valueCache[_sourceId];

  _onListen() {
    final stream = _contactsRepo.watchContactBySourceWithPhonesAndEmails(_sourceType, _sourceId);
    _sub = stream.listen((contact) => _handleUpdate(contact));
  }

  _handleUpdate(Contact? contact) {
    _controller.add(contact);
    if (contact != null) _valueCache[_sourceId] = contact;
  }

  _onCancel() {
    _sub?.cancel();
    _pool.remove('$_sourceType:$_sourceId');
  }
}
