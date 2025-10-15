import 'package:logging/logging.dart';

extension WebViewLoggerExtension on Logger {
  void webViewLog({required String level, required String message}) {
    final prefixed = '[WebtritConsoleLogChannel] $message';

    switch (level.toUpperCase()) {
      case 'ERROR':
        severe(prefixed);
        break;
      case 'WARN':
      case 'WARNING':
        warning(prefixed);
        break;
      case 'INFO':
        info(prefixed);
        break;
      case 'DEBUG':
        fine(prefixed);
        break;
      case 'LOG':
      default:
        fine(prefixed);
        break;
    }
  }
}
