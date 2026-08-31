import 'package:test/test.dart';

import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

// The trailing parameter of each is the union's discriminator, which every
// variant declares so that the generated JSON schema can state its value. It
// is never read here for the reason it is never read anywhere: inside a branch
// the value is the branch.

Never unexpectedFavorites(bool a, bool b, String c, String d, String type) =>
    throw TestFailure('Unexpected favorites variant hit');

Never unexpectedKeypad(bool a, bool b, String c, String d, String type) =>
    throw TestFailure('Unexpected keypad variant hit');

Never unexpectedMessaging(bool a, bool b, String c, String d, String type) =>
    throw TestFailure('Unexpected messaging variant hit');

Never unexpectedVoicemail(bool a, bool b, String c, String d, String type) =>
    throw TestFailure('Unexpected voicemail variant hit');

Never unexpectedRecents(bool a, bool b, String c, String d, bool e, String type) =>
    throw TestFailure('Unexpected recents variant hit');

Never unexpectedContacts(
  bool a,
  bool b,
  String c,
  String d,
  List<String> e,
  ContactsLayoutScheme f,
  bool g,
  String type,
) => throw TestFailure('Unexpected contacts variant hit');

Never unexpectedEmbedded(bool a, bool b, String c, String d, String e, String type) =>
    throw TestFailure('Unexpected embedded variant hit');
