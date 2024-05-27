import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

final Logger _logger = Logger('AppTime');

class AppTime {
  static late final AppTime _instance;

  static Future<void> init() async {
    final is24HourFormat = await _determine24HourFormat();

    final shortDateFormat = is24HourFormat ? DateFormat.Hm() : DateFormat.jms();
    final detailDateFormat = is24HourFormat ? DateFormat.yMMMd().add_Hm() : DateFormat.yMMMd().add_jms();

    _logger.info('Initialized with format: $is24HourFormat');

    _instance = AppTime._(is24HourFormat, shortDateFormat, detailDateFormat);
  }

  static Future<bool> _determine24HourFormat() async {
    final dispatcher = WidgetsBinding.instance.platformDispatcher;
    try {
      final firstView = dispatcher.views.first;
      return MediaQueryData.fromView(firstView).alwaysUse24HourFormat;
    } catch (e, stackTrace) {
      _logger.info('Error checking 24-hour format: $e', e, stackTrace);
      return true;
    }
  }

  factory AppTime() => _instance;

  AppTime._(this._is24HourFormat, this.shortDateFormat, this.fullDateFormat);

  final bool _is24HourFormat;

  final DateFormat shortDateFormat;
  final DateFormat fullDateFormat;

  bool get is24HourFormat => _is24HourFormat;

  DateFormat formatDateTime([bool full = false]) {
    return full ? fullDateFormat : shortDateFormat;
  }
}
