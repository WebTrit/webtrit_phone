import 'package:bloc/bloc.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class PresenceSettingsCubit extends Cubit<PresenceSettings> {
  PresenceSettingsCubit(this._repository) : super(_repository.presenceSettings);

  final PresenceSettingsRepository _repository;

  void setPresenceSettings(PresenceSettings settings) {
    emit(settings);
    _repository.updatePresenceSettings(settings);
  }
}
