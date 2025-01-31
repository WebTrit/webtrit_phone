import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/models/encoding_settings.dart';

class EncodingSettingsCubit extends Cubit<EncodingSettings> {
  EncodingSettingsCubit(this._prefs) : super(_prefs.getEncodingSettings());

  final AppPreferences _prefs;

  void setNew(EncodingSettings settings) {
    emit(settings);
    _prefs.setEncodingSettings(settings);
  }
}
