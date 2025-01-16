enum AgreementStatus {
  accepted,
  declined,
  pending;

  bool get isAccepted => this == AgreementStatus.accepted;

  bool get isDeclined => this == AgreementStatus.declined;

  bool get isPending => this == AgreementStatus.pending;
}
