import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:drift/native.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/main.dart';

Future<bool> _isUsable(AppDatabase db) async {
  try {
    await db.customSelect('SELECT 1').get();
    return true;
  } catch (_) {
    return false;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('closes the connection it owns when released', () async {
    final db = AppDatabase(NativeDatabase.memory());
    final holder = AppDatabaseLifecycleHolder(db)..attach();

    expect(await _isUsable(db), isTrue);

    await holder.dispose();

    expect(await _isUsable(db), isFalse);
  });

  test('closes the connection when the app is detached', () async {
    final db = AppDatabase(NativeDatabase.memory());
    final holder = AppDatabaseLifecycleHolder(db)..attach();
    addTearDown(holder.dispose);

    // drift opens lazily, so the connection has to be in use before closing it
    // means anything.
    expect(await _isUsable(db), isTrue);

    // The binding only forwards a valid transition, so the app has to walk the
    // states down to detached rather than jump straight to it.
    for (final state in [
      AppLifecycleState.inactive,
      AppLifecycleState.hidden,
      AppLifecycleState.paused,
      AppLifecycleState.detached,
    ]) {
      WidgetsBinding.instance.handleAppLifecycleStateChanged(state);
    }
    await pumpEventQueue();

    expect(await _isUsable(db), isFalse);
  });

  test('a detached holder stops reacting and leaves its connection alone', () async {
    final db = AppDatabase(NativeDatabase.memory());
    final holder = AppDatabaseLifecycleHolder(db)..attach();
    addTearDown(holder.dispose);
    expect(await _isUsable(db), isTrue);

    holder.detach();
    for (final state in [
      AppLifecycleState.resumed,
      AppLifecycleState.inactive,
      AppLifecycleState.hidden,
      AppLifecycleState.paused,
      AppLifecycleState.detached,
    ]) {
      WidgetsBinding.instance.handleAppLifecycleStateChanged(state);
    }
    await pumpEventQueue();

    expect(await _isUsable(db), isTrue);
  });
}
