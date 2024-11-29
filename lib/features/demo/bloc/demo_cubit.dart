import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'demo_cubit_state.dart';

part 'demo_cubit.freezed.dart';

final _logger = Logger('DemoCubit');

class DemoCubit extends Cubit<DemoCubitState> {
  DemoCubit({
    required CallToActionsRepository callToActionsRepository,
    required Locale locale,
  })  : _callToActionsRepository = callToActionsRepository,
        super(DemoCubitState(locale: locale));

  final CallToActionsRepository _callToActionsRepository;

  void changeVisibility(bool visible) {
    emit(state.copyWith(visible: visible));
  }

  void changeLocale(Locale locale) {
    final flavor = state.flavor;

    // Emit the updated state with the new locale, resetting flavor and actions
    emit(state.copyWith(
      locale: locale,
      flavor: null,
      actions: {},
    ));

    // Re-fetch actions if a flavor was previously set
    if (flavor != null) getActions(state.flavor!);
  }

  Future<void> getActions(MainFlavor flavor) async {
    if (state.flavor == flavor) {
      _logger.fine('Flavor $flavor is already set.');
      return;
    }

    emit(state.copyWith(flavor: flavor));

    // Load actions only if not already available
    if (state.actions[flavor] == null) {
      await _loadFlavorActions(flavor, state.locale);
    } else {
      _logger.fine('Actions for flavor $flavor already loaded.');
    }
  }

  // Loads and updates state with actions for the specified flavor and locale
  Future<void> _loadFlavorActions(MainFlavor flavor, Locale locale) async {
    try {
      final flavorCallToActions = await _callToActionsRepository.getActions(flavor, locale);
      final updatedFlavorCallToActions = {...state.actions, flavor: flavorCallToActions};

      emit(state.copyWith(actions: updatedFlavorCallToActions));
    } catch (e, stackTrace) {
      _logger.severe('Failed to fetch actions for flavor $flavor: $e', e, stackTrace);
    }
  }
}
