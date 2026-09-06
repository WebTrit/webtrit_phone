import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:patrol/patrol.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/extensions/main_flavor.dart';
import 'package:webtrit_phone/features/cdrs/cdrs.dart';
import 'package:webtrit_phone/features/login/view/login_mode_select_screen.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import 'components/api_request_log.dart';
import 'components/integration_test_environment_config.dart';
import 'components/render_overflow_tolerance.dart';
import 'subsequences/login_by_method.dart';
import 'subsequences/logout.dart';
import 'subsequences/pump_root_and_wait_until_visible.dart';
import 'subsequences/wait_until.dart';

const _initialRecordCount = 1;
const _incrementalRecordCount = 120;
const _pageSize = 50;
const _historyPath = '/api/v1/user/history';

/// Covers one finite incremental CDR sync against the local Core and SIP
/// adapter. The adapter serves 120 controlled records, forcing the worker to
/// drain three pages (50 + 50 + 20) before the cycle completes.
void main() {
  const userRef = IntegrationTestEnvironmentConfig.PASSWORD_USER_CREDENTIAL;
  const customCoreUrl = IntegrationTestEnvironmentConfig.CUSTOM_CORE_URL;

  patrolTest('incremental CDR sync drains every backend page', ($) async {
    final coreUri = Uri.parse(customCoreUrl);
    expect(
      coreUri.hasScheme && coreUri.host.isNotEmpty && coreUri.port == 4000,
      isTrue,
      reason: 'this test must target the local Core at http://<host>:4000',
    );
    expect(userRef, isNotEmpty, reason: 'PASSWORD_USER_CREDENTIAL must be configured');

    final adapterHistoryUri = coreUri.replace(port: 3000, path: '/debug/history', queryParameters: {'user': userRef});
    await _seedHistory(adapterHistoryUri, _initialRecordCount);
    addTearDown(() => _clearHistory(adapterHistoryUri));

    final dependencies = await bootstrap();
    final apiLog = ApiRequestLog()..start();
    addTearDown(apiLog.stop);

    await pumpRootAndWaitUntilVisible(dependencies, $);
    expect($(LoginModeSelectScreen).visible, isTrue, reason: 'the pagination scenario needs a fresh local database');
    await tolerateSmallRenderOverflows(() => loginByMethod($, IntegrationTestEnvironmentConfig.DEFAULT_LOGIN_METHOD));

    await waitUntil(
      $,
      () => apiLog.requestsFor(_historyPath).isNotEmpty,
      timeout: const Duration(seconds: 30),
      description: 'the initial CDR sync did not reach the local Core',
    );

    final recentsNavKey = MainFlavor.recents.toNavBarKey();
    await $(recentsNavKey).waitUntilVisible();
    final shellContext = $.tester.element(find.byKey(recentsNavKey));
    final scheduledSync = shellContext.read<CdrsSync>();
    final localRepository = shellContext.read<CdrsLocalRepository>();
    final remoteRepository = shellContext.read<CdrsRemoteRepository>();

    await _waitForStoredRecords($, localRepository, _initialRecordCount);

    // Release the app-owned registration after its initial polling cycle. The
    // test below owns exactly one refresh, so no scheduled tick can pollute the
    // request-count oracle.
    await scheduledSync.dispose();

    // Give the incremental cycle an anchor older than every CDR seeded by the
    // stand. This keeps the scenario valid when the adapter starts applying
    // time_from instead of only forwarding it.
    await localRepository.wipeData();
    await localRepository.upsertCdrs([_paginationAnchor]);
    await localRepository.markSyncCompleted(_paginationAnchor.connectTime);

    await _seedHistory(adapterHistoryUri, _incrementalRecordCount);
    final refreshStartedAt = DateTime.now();

    final worker = CdrsSyncWorker(localRepository, remoteRepository, pageSize: _pageSize);
    addTearDown(worker.dispose);
    await worker.refresh();
    await $.pumpAndSettle();

    final pageRequests = apiLog.requestsFor(_historyPath, since: refreshStartedAt);
    expect(pageRequests, hasLength(3), reason: '120 CDRs at page size 50 must require exactly three pages');
    expect(pageRequests.map((request) => request.uri.queryParameters['page']).toList(), ['1', '2', '3']);
    expect(pageRequests.map((request) => request.uri.queryParameters['items_per_page']).toSet(), {'$_pageSize'});

    final timeFromValues = pageRequests.map((request) => request.uri.queryParameters['time_from']).toList();
    expect(timeFromValues, everyElement(isNotNull));
    expect(
      timeFromValues.toSet(),
      hasLength(1),
      reason: 'every page in one cycle must use the same incremental anchor',
    );
    expect(apiLog.retriedFor(_historyPath), isEmpty, reason: 'the local stack should not need transport retries');

    final storedHistory = await localRepository.getHistory(limit: _incrementalRecordCount + 1);
    expect(storedHistory, hasLength(_incrementalRecordCount + 1));
    expect(storedHistory.first.callId, 'seeded-$userRef-0');
    expect(
      storedHistory.map((record) => record.callId),
      contains('seeded-$userRef-${_incrementalRecordCount - 1}'),
      reason: 'the final seeded record comes from page 3 and proves it was persisted',
    );
    expect(
      storedHistory.last.callId,
      _paginationAnchor.callId,
      reason: 'the incremental anchor must remain the oldest local record',
    );

    await $(recentsNavKey).tap();
    await $(RecentCdrsScreen).waitUntilVisible();
    await $(Key('seeded-$userRef-0')).waitUntilVisible();

    await logout($);
  });
}

final _paginationAnchor = CdrRecord(
  callId: 'cdr-pagination-anchor',
  direction: CallDirection.outgoing,
  status: CdrStatus.accepted,
  callee: '555002',
  calleeNumber: '555002',
  caller: '555001',
  callerNumber: '555001',
  connectTime: DateTime.utc(2000),
  disconnectTime: DateTime.utc(2000).add(const Duration(seconds: 1)),
  disconnectReason: 'Normal call clearing',
  duration: const Duration(seconds: 1),
);

Future<void> _waitForStoredRecords(PatrolIntegrationTester $, CdrsLocalRepository repository, int count) async {
  final deadline = DateTime.now().add(const Duration(seconds: 30));
  while ((await repository.getHistory(limit: count)).length < count) {
    if (DateTime.now().isAfter(deadline)) {
      fail('the initial CDR sync did not persist $count record(s)');
    }
    await $.pump(const Duration(milliseconds: 100));
  }
}

Future<void> _seedHistory(Uri uri, int count) async {
  final response = await http.post(uri.replace(queryParameters: {...uri.queryParameters, 'count': '$count'}));
  expect(response.statusCode, 200, reason: 'failed to seed $count CDRs: ${response.body}');
}

Future<void> _clearHistory(Uri uri) async {
  final response = await http.delete(uri);
  expect(response.statusCode, 200, reason: 'failed to clear seeded CDRs: ${response.body}');
}
