import 'package:flutter/services.dart';

import 'package:logging/logging.dart';
import 'package:url_launcher/url_launcher.dart';

final _logger = Logger('launchMailTo');

/// Opens the mail app on [address], if the device has one.
///
/// Shared so the two places that offer to write to a contact - the contact card
/// and the chat info screen - take the same route and behave the same when no
/// mail app is installed: nothing happens, rather than an error the user cannot
/// act on.
Future<bool> launchMailTo(String address) async {
  final mailto = Uri(scheme: 'mailto', path: address);
  try {
    if (!await canLaunchUrl(mailto)) return false;

    return await launchUrl(mailto);
  } on PlatformException catch (error, stackTrace) {
    // Resolving a handler and actually starting it are two different things:
    // the second can still fail, and this is called straight from a button, so
    // an uncaught failure would be recorded as a crash over a tap that simply
    // did not open anything.
    _logger.warning('Could not open the mail app', error, stackTrace);
    return false;
  }
}
