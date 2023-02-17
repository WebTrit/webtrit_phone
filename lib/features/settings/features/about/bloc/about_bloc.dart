import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:pub_semver/pub_semver.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'about_bloc.freezed.dart';

part 'about_event.dart';

part 'about_state.dart';

final _logger = Logger('$AboutBloc');

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  AboutBloc({
    required PackageInfo packageInfo,
    required this.infoRepository,
  }) : super(AboutState(
          appName: packageInfo.appName,
          packageName: packageInfo.packageName,
          version: packageInfo.version,
          buildNumber: packageInfo.buildNumber,
          coreUrl: infoRepository.coreUrl,
        )) {
    on<AboutStarted>(_onStarted, transformer: restartable());
    on<AboutErrorDismissed>(_onErrorDismissed, transformer: droppable());
  }

  final InfoRepository infoRepository;

  void _onStarted(AboutStarted event, Emitter<AboutState> emit) async {
    emit(state.copyWith(progress: true));
    try {
      final coreVersion = await infoRepository.getCoreVersion();

      if (emit.isDone) return;

      emit(state.copyWith(
        progress: false,
        coreVersion: coreVersion,
      ));
    } on Exception catch (e, stackTrace) {
      if (emit.isDone) return;

      emit(state.copyWith(
        progress: false,
        error: e,
      ));
      _logger.warning('_onStarted', e, stackTrace);
    }
  }

  void _onErrorDismissed(AboutErrorDismissed event, Emitter<AboutState> emit) async {
    emit(state.copyWith(error: null));
  }
}
