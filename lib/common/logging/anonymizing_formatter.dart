import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

enum AnonymizationType { none, full }

class AnonymizingFormatter extends ColorFormatter {
  AnonymizationType anonymizationType;

  AnonymizingFormatter({
    LogRecordFormatter wrappedFormatter = const DefaultLogRecordFormatter(),
    this.anonymizationType = AnonymizationType.none,
  }) : super(wrappedFormatter);

  @override
  StringBuffer formatToStringBuffer(LogRecord rec, StringBuffer sb) {
    final sanitizedMessage = _sanitize(rec.message);

    final sanitizedRecord = LogRecord(rec.level, sanitizedMessage, rec.loggerName, rec.error, rec.stackTrace, rec.zone);

    return super.formatToStringBuffer(sanitizedRecord, sb);
  }

  String _sanitize(String input) {
    if (anonymizationType == AnonymizationType.none) return input;

    const patterns = <String, String>{
      r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b': '[REDACTED_EMAIL]',
      r'\b(?:\d{1,3}\.){3}\d{1,3}\b': '[REDACTED_IPADDRESS]',
      r'\bport\s*=\s*\d+\b': '[REDACTED_PORT]',
      r'\b\d{10,15}\b': '[REDACTED_PHONENUMBER]',
      r'eyJ[a-zA-Z0-9._-]+': '[REDACTED_TOKEN]',
      r'"(first_name|last_name|alias_name|company_name)":"[^"]+"': '[REDACTED_PERSONALINFO]',
      r'"identifier":"[^"]+"': '[REDACTED_IDENTIFIER]',
      r'"user_id":"[^"]+"': '[REDACTED_USERID]',
      r'"tenant_id":"[^"]+"': '[REDACTED_TENANTID]',
      r'"balance":\{[^}]+\}': '[REDACTED_BALANCE]',
      r'"bundle_id":"[^"]+"': '[REDACTED_BUNDLEID]',
      r'"config_token":"[^"]+"': '[REDACTED_CONFIGTOKEN]',
      r'"login":"[^"]+"': '[REDACTED_LOGIN]',
      r'"password":"[^"]+"': '[REDACTED_PASSWORD]',
      r'"otp_id":"[^"]+"': '[REDACTED_OTPID]',
      r'"user_ref":"[^"]+"': '[REDACTED_USERREF]',
      r'"code":"[^"]+"': '[REDACTED_CODE]',
    };

    var sanitized = input;
    for (final entry in patterns.entries) {
      sanitized = sanitized.replaceAll(RegExp(entry.key), entry.value);
    }
    return sanitized;
  }
}
