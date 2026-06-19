import 'package:test/test.dart';

Never unexpectedFavorites(bool a, bool b, String c, String d) => throw TestFailure('Unexpected favorites variant hit');

Never unexpectedKeypad(bool a, bool b, String c, String d) => throw TestFailure('Unexpected keypad variant hit');

Never unexpectedMessaging(bool a, bool b, String c, String d) => throw TestFailure('Unexpected messaging variant hit');

Never unexpectedRecents(bool a, bool b, String c, String d, bool e) =>
    throw TestFailure('Unexpected recents variant hit');

Never unexpectedContacts(bool a, bool b, String c, String d, List<String> e) =>
    throw TestFailure('Unexpected contacts variant hit');

Never unexpectedEmbedded(bool a, bool b, String c, String d, String e) =>
    throw TestFailure('Unexpected embedded variant hit');
