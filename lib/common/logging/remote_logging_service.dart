import 'package:logging/logging.dart';

abstract class RemoteLoggingService {
  Level get minLevel;

  void initialize(Map<String, String> labels);

  void setAnonymizationEnabled(bool enabled);

  void dispose();
}
