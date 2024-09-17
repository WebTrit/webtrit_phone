import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

class UserSmsNumbersBuilder extends StatefulWidget {
  const UserSmsNumbersBuilder({required this.builder, super.key});

  final Widget Function(BuildContext, List<String>, {required bool loading}) builder;

  @override
  State<UserSmsNumbersBuilder> createState() => _UserSmsNumbersBuilderState();
}

class _UserSmsNumbersBuilderState extends State<UserSmsNumbersBuilder> {
  late final smsRepo = context.read<SmsRepository>();
  late final StreamSubscription numebersSub;

  List<String> numbers = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    final e = NumbersWatchSubject(smsRepo);
    setNumbers(e.value);
    numebersSub = e.stream.listen((c) => setNumbers(c));
  }

  setNumbers(List<String>? numbers) {
    loading = false;
    this.numbers = numbers ?? [];
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    numebersSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, numbers, loading: loading);
  }
}

/// Subject with broadcast auto-closable [stream] of user sms numbers with its last [value]
/// used to avoid invoking multiple streams and futures on same screen
class NumbersWatchSubject {
  NumbersWatchSubject._(this._repository) {
    _controller = StreamController<List<String>>.broadcast(onListen: _onListen, onCancel: _onCancel);
  }

  factory NumbersWatchSubject(SmsRepository repository) {
    return _instance ??= NumbersWatchSubject._(repository);
  }

  static NumbersWatchSubject? _instance;
  final SmsRepository _repository;
  late StreamController<List<String>> _controller;
  StreamSubscription? _sub;
  List<String>? _numbersCache = [];

  /// Updates stream of user sms numbers
  Stream<List<String>> get stream => _controller.stream;

  /// Last cached value of user sms numbers
  List<String>? get value => _numbersCache;

  _onListen() {
    final stream = _repository.watchUserSmsNumbers();
    _sub = stream.listen((contact) => _handleUpdate(contact));
  }

  _handleUpdate(List<String> contact) {
    _controller.add(contact);
    _numbersCache = contact;
  }

  _onCancel() {
    _sub?.cancel();
  }
}
