import 'package:bloc/bloc.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class ContactPresenceCubit extends Cubit<PresenceSettings> {
  ContactPresenceCubit(
    this._repository,
  ) : super(_repository.presenceSettings);

  final PresenceInfoRepository _repository;

  void setPresenceSettings(PresenceSettings settings) {
    emit(settings);
    _repository.updatePresenceSettings(settings);
  }
}
