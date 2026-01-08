import 'package:webtrit_api/webtrit_api.dart';

abstract class ContactsRemoteDataSource {
  Future<List<UserContact>> getContacts();

  Future<UserContact> getContact(String userId);
}

class ContactsRemoteDataSourceImpl implements ContactsRemoteDataSource {
  ContactsRemoteDataSourceImpl(this._webtritApiClient, this._token);

  final WebtritApiClient _webtritApiClient;
  final String _token;

  @override
  Future<List<UserContact>> getContacts() {
    return _webtritApiClient.getUserContactList(_token);
  }

  @override
  Future<UserContact> getContact(String userId) {
    return _webtritApiClient.getUserContact(userId, _token);
  }
}
