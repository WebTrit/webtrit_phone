import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:provider/provider.dart';

import 'package:webtrit_phone/app/app_dependencies.dart';
import 'package:webtrit_phone/main.dart';

/// Counts how many times it was built from scratch, so a test can tell a
/// rebuild (state kept) from a remount (state lost).
class _Mounts extends StatefulWidget {
  const _Mounts(this.mounts);

  final List<int> mounts;

  @override
  State<_Mounts> createState() => _MountsState();
}

class _MountsState extends State<_Mounts> {
  @override
  void initState() {
    super.initState();
    widget.mounts.add(1);
  }

  @override
  Widget build(BuildContext context) => Text('${context.watch<ThemeMode?>()}', textDirection: TextDirection.ltr);
}

Widget _tree(ConfigSource<ThemeMode>? source, List<int> mounts) {
  return MultiProvider(providers: [hostThemeModeProvider(source)], child: _Mounts(mounts));
}

void main() {
  group('hostThemeModeProvider', () {
    testWidgets('provides null when no host supplies a mode', (tester) async {
      await tester.pumpWidget(_tree(null, []));

      expect(find.text('null'), findsOneWidget);
    });

    testWidgets('provides the host mode and follows its updates', (tester) async {
      final controller = StreamController<ThemeMode>.broadcast();
      addTearDown(controller.close);

      await tester.pumpWidget(_tree((initial: ThemeMode.light, updates: () => controller.stream), []));
      expect(find.text('ThemeMode.light'), findsOneWidget);

      controller.add(ThemeMode.dark);
      await tester.pump(Duration.zero);

      expect(find.text('ThemeMode.dark'), findsOneWidget);
    });

    testWidgets('keeps one shape, so gaining a host mode does not remount what is below', (tester) async {
      final mounts = <int>[];
      final controller = StreamController<ThemeMode>.broadcast();
      addTearDown(controller.close);

      await tester.pumpWidget(_tree(null, mounts));
      await tester.pumpWidget(_tree((initial: ThemeMode.dark, updates: () => controller.stream), mounts));
      await tester.pump(Duration.zero);

      expect(mounts, hasLength(1));
    });

    testWidgets('keeps one shape, so losing a host mode does not remount what is below', (tester) async {
      final mounts = <int>[];
      final controller = StreamController<ThemeMode>.broadcast();
      addTearDown(controller.close);

      await tester.pumpWidget(_tree((initial: ThemeMode.dark, updates: () => controller.stream), mounts));
      await tester.pumpWidget(_tree(null, mounts));
      await tester.pump(Duration.zero);

      expect(mounts, hasLength(1));
    });
  });
}
