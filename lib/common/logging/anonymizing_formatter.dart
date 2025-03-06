import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

enum AnonymizationType {
  email,
  ipAddress,
  port,
  phoneNumber,
  token,
  personalInfo,
  identifier,
  userId,
  tenantId,
  balance,
  bundleId,
  configToken,
  login,
  password,
  otpId,
  code,
  userRef;

  static const List<AnonymizationType> none = [];

  static const List<AnonymizationType> full = AnonymizationType.values;
}

class AnonymizingFormatter extends ColorFormatter {
  final List<AnonymizationType> anonymizationTypes;

  AnonymizingFormatter({
    LogRecordFormatter wrappedFormatter = const DefaultLogRecordFormatter(),
    this.anonymizationTypes = AnonymizationType.none,
  }) : super(wrappedFormatter);

  @override
  StringBuffer formatToStringBuffer(LogRecord rec, StringBuffer sb) {
    final sanitizedMessage = _sanitize(rec.message);

    final sanitizedRecord = LogRecord(
      rec.level,
      sanitizedMessage,
      rec.loggerName,
      rec.error,
      rec.stackTrace,
      rec.zone,
    );

    return super.formatToStringBuffer(sanitizedRecord, sb);
  }

  String _sanitize(String input) {
    final patterns = <AnonymizationType, RegExp>{
      AnonymizationType.email: RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b'),
      AnonymizationType.ipAddress: RegExp(r'\b(?:\d{1,3}\.){3}\d{1,3}\b'),
      AnonymizationType.port: RegExp(r'\bport\s*=\s*\d+\b'),
      AnonymizationType.phoneNumber: RegExp(r'\b\d{10,15}\b'),
      AnonymizationType.token: RegExp(r'eyJ[a-zA-Z0-9._-]+'),
      AnonymizationType.personalInfo: RegExp(r'"(first_name|last_name|alias_name|company_name)":"[^"]+"'),
      AnonymizationType.identifier: RegExp(r'"identifier":"[^"]+"'),
      AnonymizationType.userId: RegExp(r'"user_id":"[^"]+"'),
      AnonymizationType.tenantId: RegExp(r'"tenant_id":"[^"]+"'),
      AnonymizationType.balance: RegExp(r'"balance":\{[^}]+\}'),
      AnonymizationType.bundleId: RegExp(r'"bundle_id":"[^"]+"'),
      AnonymizationType.configToken: RegExp(r'"config_token":"[^"]+"'),
      AnonymizationType.login: RegExp(r'"login":"[^"]+"'),
      AnonymizationType.password: RegExp(r'"password":"[^"]+"'),
      AnonymizationType.otpId: RegExp(r'"otp_id":"[^"]+"'),
      AnonymizationType.userRef: RegExp(r'"user_ref":"[^"]+"'),
      AnonymizationType.code: RegExp(r'"code":"[^"]+"'),
    };

    var sanitized = input;
    for (final type in anonymizationTypes) {
      if (patterns.containsKey(type)) {
        sanitized = sanitized.replaceAll(patterns[type]!, '[REDACTED_${type.name.toUpperCase()}]');
      }
    }
    return sanitized;
  }
}
