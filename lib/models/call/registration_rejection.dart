/// Why the phone system refused to register the account.
///
/// A refusal arrives as a numeric status plus a free-text phrase written by
/// the registrar on the operator's side, so this vocabulary is ours rather
/// than theirs: a value exists only where the refusal changes what is worth
/// telling the user. Everything else stays [unspecified] and keeps the generic
/// connection wording, which is the honest answer when we cannot do better.
enum RegistrationRejection {
  /// The registrar answered, and answered that it cannot serve the account
  /// right now. Nothing is wrong with the device, its network, or the account.
  platformUnavailable,

  /// No refusal, or one we have nothing specific to say about.
  unspecified;

  /// Classifies the answer that came back with a failed registration.
  ///
  /// Both halves have to match. The status alone means little - 503 also
  /// carries a busy line on an outgoing call - and the phrase is free text
  /// from a third party rather than a contract, so it is compared in lower
  /// case and by containment.
  static RegistrationRejection of(int? code, String? reason) {
    if (code == null || reason == null) return unspecified;

    final phrase = reason.toLowerCase();
    for (final known in _knownRefusals) {
      if (known.code == code && phrase.contains(known.phrase)) return known.rejection;
    }
    return unspecified;
  }
}

/// One refusal the app recognises.
class _KnownRefusal {
  const _KnownRefusal({required this.code, required this.phrase, required this.rejection});

  final int code;
  final String phrase;
  final RegistrationRejection rejection;
}

/// Teaching the app a new refusal is a row here. A new value in
/// [RegistrationRejection] is only needed when the advice to the user differs
/// from every value already listed.
const _knownRefusals = <_KnownRefusal>[
  _KnownRefusal(code: 503, phrase: 'no target nodes', rejection: RegistrationRejection.platformUnavailable),
];
