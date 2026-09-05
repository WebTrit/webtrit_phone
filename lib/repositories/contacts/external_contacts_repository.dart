import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/session/session.dart';
import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

final _logger = Logger('ExternalContactsRepository');

/// Remote gateway for the external contact list.
///
/// Deliberately fetch-only: the cadence of these fetches is owned by the
/// sync worker registered with the polling service, so nothing else in the
/// app can start a competing download (see `docs/refresh_ownership.md`).
///
/// An abstract contract on purpose: the backend serves the list through two
/// API generations - the full-list v1 and the paginated v2 - and each is an
/// implementation of this same gateway. Pagination is an implementation
/// detail: a paged implementation walks its pages internally and still
/// returns the complete list, so the worker never learns which generation
/// it talks to.
abstract class ExternalContactsRepository {
  Future<List<ExternalContact>> fetchContacts();
}

/// The full-list v1 implementation (`GET /user/contacts`).
class ExternalContactsRepositoryV1Impl with ExternalContactApiMapper implements ExternalContactsRepository {
  ExternalContactsRepositoryV1Impl({
    required WebtritApiClient webtritApiClient,
    required String token,
    SessionGuard? sessionGuard,
  }) : _sessionGuard = sessionGuard ?? const EmptySessionGuard(),
       _webtritApiClient = webtritApiClient,
       _token = token;

  final WebtritApiClient _webtritApiClient;
  final String _token;
  final SessionGuard _sessionGuard;

  @override
  Future<List<ExternalContact>> fetchContacts() async {
    try {
      final contacts = await _webtritApiClient.getUserContactList(_token);
      return contacts.map(externalContactFromApi).toList();
    } on UnauthorizedException catch (e) {
      _sessionGuard.onUnauthorized(e);
      rethrow;
    } catch (e, stackTrace) {
      _logger.warning('fetchContacts', e, stackTrace);
      rethrow;
    }
  }
}
