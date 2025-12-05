import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/app/session/session.dart';

final _logger = Logger('ExternalContactsRepository');

class ExternalContactsRepository with ExternalContactApiMapper implements Refreshable {
  ExternalContactsRepository({
    required WebtritApiClient webtritApiClient,
    required String token,
    SessionGuard? sessionGuard,
  }) : _sessionGuard = sessionGuard ?? const EmptySessionGuard(),
       _webtritApiClient = webtritApiClient,
       _token = token {
    _controller = StreamController<List<ExternalContact>>.broadcast();
  }

  final WebtritApiClient _webtritApiClient;
  final String _token;
  final SessionGuard _sessionGuard;

  late StreamController<List<ExternalContact>> _controller;

  List<ExternalContact>? _cacheContacts;

  Stream<List<ExternalContact>> contacts() {
    return _controller.stream;
  }

  Future<void> load() async {
    final contacts = await _listContacts();
    _cacheContacts = contacts;
    _controller.add(contacts);
  }

  Future<void> _gatherListContacts() async {
    try {
      final contacts = await _listContacts();
      if (!listEquals(contacts, _cacheContacts)) {
        _cacheContacts = contacts;
        _controller.add(contacts);
      }
    } on UnauthorizedException catch (e) {
      _sessionGuard.onUnauthorized(e);
      rethrow;
    } catch (e, stackTrace) {
      _logger.warning('_gatherListContacts', e, stackTrace);
      _controller.addError(e, stackTrace);
    }
  }

  Future<List<ExternalContact>> _listContacts() async {
    final contacts = await _webtritApiClient.getUserContactList(_token);
    return contacts.map(externalContactFromApi).toList();
  }

  @override
  Future<void> refresh() async {
    return _gatherListContacts();
  }
}
