import 'dart:io';

import 'package:logging/logging.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/models/ice_settings.dart';

final _logger = Logger('IceFilter');

/// Filters ICE candidates before sending them to the server.
abstract class IceFilter {
  /// Filters the given ICE candidate.
  /// Returns true if the candidate should'nt be sent to the server, false otherwise.
  bool filter(RTCIceCandidate candidate);
}

/// A class that filters ICE candidates based on encoding settings.
///
/// This class implements the [IceFilter] interface and provides functionality
/// to filter ICE candidates based on [IceSettings] stored in [AppPreferences].
///
/// can be used to filter ICE candidates based on transport and network type.
class FilterWithAppSettings implements IceFilter {
  FilterWithAppSettings(this._prefs);

  final AppPreferences _prefs;

  @override
  bool filter(RTCIceCandidate candidate) {
    final settings = _prefs.getIceSettings();
    final candidateString = candidate.candidate;

    final transportFilter = settings.iceTransportFilter;

    if (transportFilter != null && candidateString != null) {
      switch (transportFilter) {
        case IceTransportFilter.udp:
          if (candidateString.contains('udp')) {
            _logger.info('Filtered ICE candidate with transport type: upd');
            return true;
          }
          break;

        case IceTransportFilter.tcp:
          if (candidateString.contains('tcp')) {
            _logger.info('Filtered ICE candidate with transport type: tcp');
            return true;
          }
          break;
      }
    }

    final networkFilter = settings.iceNetworkFilter;

    if (networkFilter != null && candidateString != null) {
      final addressString = candidateString.split(' ')[4];
      final adress = InternetAddress(addressString);

      switch (networkFilter) {
        case IceNetworkFilter.ipv4:
          if (adress.type == InternetAddressType.IPv4) {
            _logger.info('Filtered ICE candidate with network type: ipv4');
            return true;
          }
          break;

        case IceNetworkFilter.ipv6:
          if (adress.type == InternetAddressType.IPv6) {
            _logger.info('Filtered ICE candidate with network type: ipv6');
            return true;
          }
          break;
      }
    }

    return false;
  }
}
