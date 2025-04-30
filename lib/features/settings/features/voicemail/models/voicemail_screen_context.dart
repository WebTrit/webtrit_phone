import 'package:intl/intl.dart';

class VoicemailScreenContext {
  VoicemailScreenContext({
    required this.mediaCacheBasePath,
    required this.dateFormat,
  });

  final String mediaCacheBasePath;
  final DateFormat dateFormat;
}
