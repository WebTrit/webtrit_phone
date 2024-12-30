import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/custom_page.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('CustomPagesCubit');

/// A simple cubit that prefetches custom pages and store data during the user's session.
class CustomPagesCubit extends Cubit<CustomPagesState> {
  CustomPagesCubit(
    this._customPagesRepository,
    this._locale,
    this._localeChanges,
  ) : super(CustomPagesState()) {
    fetchPages();

    _connectivitySub = Connectivity().onConnectivityChanged.listen(_onConnectivityChanged);
    _localeSub = _localeChanges.listen(_onLocaleChanged);
  }

  final CustomPagesRepository _customPagesRepository;
  String _locale;
  final Stream<String> _localeChanges;

  StreamSubscription? _localeSub;
  StreamSubscription? _connectivitySub;

  void _onLocaleChanged(String locale) {
    _locale = locale;
    fetchPages();
  }

  void _onConnectivityChanged(List<ConnectivityResult> cr) {
    if (cr.any((c) => c != ConnectivityResult.none)) fetchPages();
  }

  Future<void> fetchPages() async {
    try {
      final pages = await _customPagesRepository.getCustomPages(_locale);
      emit(CustomPagesState(pages: pages));
    } catch (e, s) {
      _logger.warning('Failed to get custom pages', e, s);
    }
  }

  @override
  Future<void> close() {
    _localeSub?.cancel();
    _connectivitySub?.cancel();
    return super.close();
  }
}

class CustomPagesState with EquatableMixin {
  CustomPagesState({
    this.pages = const [],
  });

  final List<CustomPage> pages;

  @override
  List<Object?> get props => [pages];

  @override
  bool get stringify => true;
}
