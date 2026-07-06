import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/session_status/bloc/session_status_cubit.dart';
import 'package:webtrit_phone/models/models.dart';

void main() {
  group('SessionStatusState issue aggregation', () {
    const warning = SessionIssue(id: SessionIssueId.limitedStandaloneCallMode, severity: SessionIssueSeverity.warning);
    const critical = SessionIssue(
      id: SessionIssueId.limitedStandaloneCallMode,
      severity: SessionIssueSeverity.critical,
    );
    const info = SessionIssue(id: SessionIssueId.limitedStandaloneCallMode, severity: SessionIssueSeverity.info);

    test('empty issues -> no issues, null topIssue', () {
      const state = SessionStatusState();
      expect(state.hasIssues, isFalse);
      expect(state.topIssue, isNull);
    });

    test('single issue -> hasIssues, topIssue is it', () {
      const state = SessionStatusState(issues: [warning]);
      expect(state.hasIssues, isTrue);
      expect(state.topIssue, warning);
    });

    test('topIssue picks the most severe', () {
      const state = SessionStatusState(issues: [info, warning, critical]);
      expect(state.topIssue, critical);
    });

    test('topIssue prefers warning over info', () {
      const state = SessionStatusState(issues: [info, warning]);
      expect(state.topIssue, warning);
    });
  });
}
