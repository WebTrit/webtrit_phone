import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

void main() {
  patrolTest('Should compile and run successfully', ($) async {
    await $.pumpWidgetAndSettle(const SizedBox.shrink());
    expect($(SizedBox), findsOneWidget);
  });
}
