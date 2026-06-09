import 'package:drift/drift.dart';

import 'package:app_database/src/app_database.dart';

/// Which contact source should win when a single phone number is shared by both
/// a local (device phonebook) contact and an external (PBX) contact.
///
/// The default everywhere is [externalFirst]: the PBX entry wins. Pass
/// [localFirst] only where local priority is an explicit, intentional decision.
enum ContactSourcePreference { externalFirst, localFirst }

extension ContactSourcePriorityOrdering on $ContactsTableTable {
  /// Ordering terms that place the preferred contact source first.
  ///
  /// This is the single definition of the collision tie-break. Apply it to any
  /// query that may return both a local and an external contact for the same
  /// number so the winner is deterministic instead of left to SQLite's
  /// unspecified row order.
  ///
  /// It uses an explicit CASE rather than ordering on [sourceType] directly, so
  /// the behaviour does NOT depend on the integer encoding of
  /// [ContactSourceTypeEnum] (a future enum value or reorder cannot silently
  /// flip the policy).
  List<OrderingTerm> sourcePriorityOrder([ContactSourcePreference preference = ContactSourcePreference.externalFirst]) {
    final preferred = preference == ContactSourcePreference.externalFirst
        ? ContactSourceTypeEnum.external
        : ContactSourceTypeEnum.local;

    return [
      OrderingTerm.asc(
        CaseWhenExpression<int>(
          cases: [CaseWhen(sourceType.equalsValue(preferred), then: const Constant(0))],
          orElse: const Constant(1),
        ),
      ),
    ];
  }
}
