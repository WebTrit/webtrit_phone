import 'dart:ui';

import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';

import 'db/db.dart';
import 'disposable.dart';

/// The database server this process runs: the isolate that owns the single
/// database connection, plus the name-server mapping every other isolate finds
/// it through.
///
/// Process-long by nature - the background isolates depend on that mapping - so
/// it belongs to the composition root and is released with it. Widgets take a
/// client connection from [connect] and close only that.
///
/// Native only: there is no server on the web, where the database is opened
/// directly, so nothing constructs this there. Constructing it on the web would
/// compile but fail on release, because the web name server throws.
class DatabaseServer implements Disposable {
  DatabaseServer(this._isolate);

  final DriftIsolate _isolate;

  /// Opens a client connection to the server. The handshake starts as soon as
  /// the returned connection is created.
  DatabaseConnection connect() => DatabaseConnection.delayed(_isolate.connect());

  @override
  Future<void> dispose() async {
    IsolateNameServer.removePortNameMapping(IsolateDatabase.kDbPortName);
    await _isolate.shutdownAll();
  }
}
