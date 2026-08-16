import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/call_routing/call_routing.dart';
import 'package:webtrit_phone/features/keypad/keypad.dart';
import 'package:webtrit_phone/features/keypad/view/keypad_view.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';

class _MockContactResolver extends Mock implements ContactResolver {}

class _MockCallController extends Mock implements CallController {}

class _MockCallBloc extends MockBloc<CallEvent, CallState> implements CallBloc {}

class _MockCallRoutingCubit extends MockCubit<CallRoutingState?> implements CallRoutingCubit {}

void main() {
  late KeypadCubit keypadCubit;
  late _MockCallBloc callBloc;
  late _MockCallRoutingCubit routingCubit;
  late List<MethodCall> platformCalls;

  setUp(() {
    final contactResolver = _MockContactResolver();
    when(() => contactResolver.resolve(any())).thenAnswer((_) async => null);
    keypadCubit = KeypadCubit(contactResolver);
    callBloc = _MockCallBloc();
    when(() => callBloc.state).thenReturn(const CallState());
    routingCubit = _MockCallRoutingCubit();
    when(() => routingCubit.state).thenReturn(null);
    platformCalls = [];
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      null,
    );
  });

  /// Answers the clipboard the way the platform would, with [text] on it.
  void withClipboard(String? text) {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        platformCalls.add(call);
        if (call.method == 'Clipboard.getData') return text == null ? null : <String, dynamic>{'text': text};
        return null;
      },
    );
  }

  Widget buildSubject() {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: CallControllerScope(
          controller: _MockCallController(),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<KeypadCubit>.value(value: keypadCubit),
              BlocProvider<CallBloc>.value(value: callBloc),
              BlocProvider<CallRoutingCubit>.value(value: routingCubit),
            ],
            child: const KeypadView(videoEnabled: true, transferEnabled: false, style: null),
          ),
        ),
      ),
    );
  }

  /// Lets the debounce behind the field settle so the test ends with no timers
  /// still running.
  Future<void> teardown(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(milliseconds: 500));
  }

  /// The number field as assistive technology sees it: one node carrying the
  /// text field itself and the actions offered on it.
  SemanticsNode numberField(WidgetTester tester) => tester.getSemantics(find.byType(TextField));

  group('KeypadView - putting a number in without a long press', () {
    testWidgets('the field offers a named action that pastes the clipboard', (tester) async {
      final semantics = tester.ensureSemantics();
      withClipboard('+380 (99) 123-45-67');
      await tester.pumpWidget(buildSubject());

      final paste = CustomSemanticsAction.getIdentifier(const CustomSemanticsAction(label: 'Paste a number'));
      final data = numberField(tester).getSemanticsData();
      expect(data.customSemanticsActionIds, contains(paste));

      numberField(tester).owner!.performAction(numberField(tester).id, SemanticsAction.customAction, paste);
      await tester.pumpAndSettle();

      // What lands in the field is a number, not the punctuation around it.
      expect(find.text('+380991234567'), findsOneWidget);
      await teardown(tester);
      semantics.dispose();
    });

    testWidgets('with nothing on the clipboard it leaves the field alone', (tester) async {
      final semantics = tester.ensureSemantics();
      withClipboard(null);
      // Start from a number already dialled: an empty field would look the same
      // whether the action did nothing or wiped it.
      await keypadCubit.setValue('1001');
      await tester.pumpWidget(buildSubject());

      final paste = CustomSemanticsAction.getIdentifier(const CustomSemanticsAction(label: 'Paste a number'));
      final field = numberField(tester);
      field.owner!.performAction(field.id, SemanticsAction.customAction, paste);
      await tester.pumpAndSettle();

      expect(find.text('1001'), findsOneWidget);
      await teardown(tester);
      semantics.dispose();
    });

    testWidgets('the invisible area behind the field says nothing of its own', (tester) async {
      final semantics = tester.ensureSemantics();
      withClipboard('1001');
      await tester.pumpWidget(buildSubject());

      // The long press stays for a finger, but it is not a stop of its own on
      // the way through the screen, and it no longer stretches the field over
      // the whole upper half.
      final field = numberField(tester);
      expect(field.rect.height, lessThan(tester.getSize(find.byType(KeypadView)).height / 2));
      await teardown(tester);
      semantics.dispose();
    });
  });
}
