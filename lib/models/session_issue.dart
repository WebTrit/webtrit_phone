/// Severity of a [SessionIssue]. Drives the indicator color and ordering
/// (higher index = more severe).
enum SessionIssueSeverity { info, warning, critical }

/// Identifies a side issue surfaced in the session-status indicator.
///
/// This is the generic registry of "things worth warning the user about" that
/// are independent of the primary signaling/connection status. To surface a new
/// kind of issue: add a value here, produce it from a source in
/// `SessionStatusCubit`, and add its strings to `SessionIssueL10n`. The UI
/// (avatar badge, account summary, diagnostic details) stays generic.
enum SessionIssueId { limitedStandaloneCallMode }

/// A single side issue with its severity. The id resolves to user-facing
/// strings via the `SessionIssueL10n` extension.
class SessionIssue {
  const SessionIssue({required this.id, required this.severity});

  final SessionIssueId id;
  final SessionIssueSeverity severity;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SessionIssue && id == other.id && severity == other.severity;

  @override
  int get hashCode => Object.hash(id, severity);

  @override
  String toString() => 'SessionIssue(id: $id, severity: $severity)';
}
