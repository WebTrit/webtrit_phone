import 'dart:async';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class PresenceInfoBuilder extends StatefulWidget {
  const PresenceInfoBuilder({required this.contact, super.key, required this.builder});

  final Contact? contact;
  final Widget Function(BuildContext context, List<PresenceInfo>? presenceInfo) builder;

  @override
  State<PresenceInfoBuilder> createState() => _PresenceInfoBuilderState();
}

class _PresenceInfoBuilderState extends State<PresenceInfoBuilder> {
  late final repository = context.read<PresenceRepository>();
  StreamSubscription<List<PresenceInfo>>? _subscription;
  List<PresenceInfo>? presenceInfo;

  @override
  initState() {
    super.initState();
    if (widget.contact != null &&
        widget.contact!.sourceType == ContactSourceType.external &&
        widget.contact!.mobileNumber != null) {
      _subscription = repository.watchNumberPresence(widget.contact!.mobileNumber!).listen((v) {
        if (mounted) setState(() => presenceInfo = v);
      });
    }
  }

  @override
  void dispose() {
    _subscription?.cancel().ignore();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, presenceInfo);
  }
}
