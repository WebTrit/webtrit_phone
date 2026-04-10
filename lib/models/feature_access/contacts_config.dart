import 'package:equatable/equatable.dart';

import 'contact_details_config.dart';

/// Configuration for contact-related features, such as actions available on the contact details screen.
class ContactsConfig extends Equatable {
  const ContactsConfig({required this.detailsConfig});

  /// The configuration for the contact details screen.
  final ContactDetailsConfig detailsConfig;

  @override
  List<Object?> get props => [detailsConfig];
}
