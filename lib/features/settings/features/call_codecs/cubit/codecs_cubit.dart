import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/models/models.dart';

part 'codecs_state.dart';

class CallCodecsCubit extends Cubit<CallCodecsState> {
  CallCodecsCubit(this._appPreferences)
      : super(
          CallCodecsState(
            audioCodec: _appPreferences.getPreferedAudioCodec(),
            videoCodec: _appPreferences.getPreferedVideoCodec(),
          ),
        );

  final AppPreferences _appPreferences;

  void setAudioCodec(AudioCodec? audioCodec) {
    _appPreferences.setPreferedAudioCodec(audioCodec);
    emit(state.copyWithAudioCodec(audioCodec));
  }

  void setVideoCodec(VideoCodec? videoCodec) {
    _appPreferences.setPreferedVideoCodec(videoCodec);
    emit(state.copyWithVideoCodec(videoCodec));
  }
}
