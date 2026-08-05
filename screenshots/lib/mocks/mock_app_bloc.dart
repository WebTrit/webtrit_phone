import 'package:flutter/material.dart';

import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/models/agreement_status.dart';

class MockAppBloc extends MockBloc<AppEvent, AppState> implements AppBloc {
  MockAppBloc();

  factory MockAppBloc.allScreen({required ThemeMode themeMode, required Locale locale}) {
    final mock = MockAppBloc();
    whenListen(
      mock,
      const Stream<AppState>.empty(),
      initialState: AppState(
        themeMode: themeMode,
        locale: locale,
        userAgreementStatus: AgreementStatus.pending,
        contactsAgreementStatus: AgreementStatus.pending,
      ),
    );
    return mock;
  }
}
