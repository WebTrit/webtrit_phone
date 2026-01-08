import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone_number/webtrit_phone_number.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

void main() {
  Widget wrapWithMaterial(Widget child) {
    return MaterialApp(
      home: Scaffold(body: Center(child: child)),
    );
  }

  testWidgets('displays initialValue as-is when includePrefixInData is false', (tester) async {
    const prefix = '+380 ';
    const initial = '${prefix}991112233';

    await tester.pumpWidget(
      wrapWithMaterial(
        const ExtendedTextFormField(
          initialValue: initial,
          decoration: InputDecoration(prefixText: prefix),
          includePrefixInData: false,
        ),
      ),
    );

    await tester.pumpAndSettle();

    final editable = tester.widget<EditableText>(find.byType(EditableText));
    expect(editable.controller.text, initial);
  });

  testWidgets('strips prefix from initialValue when includePrefixInData is true', (tester) async {
    const prefix = '+380 ';
    const initial = '${prefix}991112233';

    await tester.pumpWidget(
      wrapWithMaterial(
        const ExtendedTextFormField(
          initialValue: initial,
          decoration: InputDecoration(prefixText: prefix),
          includePrefixInData: true,
        ),
      ),
    );

    await tester.pumpAndSettle();

    final editable = tester.widget<EditableText>(find.byType(EditableText));
    expect(editable.controller.text, '991112233');
  });

  testWidgets('emits raw value without prefix when includePrefixInData is false (non-phone)', (tester) async {
    const prefix = '+380 ';
    String? emitted;

    await tester.pumpWidget(
      wrapWithMaterial(
        ExtendedTextFormField(
          decoration: const InputDecoration(prefixText: prefix),
          includePrefixInData: false,
          keyboardType: TextInputType.text,
          onChanged: (value) => emitted = value,
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField), 'hello');
    await tester.pump();

    expect(emitted, 'hello');
  });

  testWidgets('emits value with prefix when includePrefixInData is true (non-phone)', (tester) async {
    const prefix = '+380 ';
    String? emitted;

    await tester.pumpWidget(
      wrapWithMaterial(
        ExtendedTextFormField(
          decoration: const InputDecoration(prefixText: prefix),
          includePrefixInData: true,
          keyboardType: TextInputType.text,
          onChanged: (value) => emitted = value,
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField), '12345');
    await tester.pump();

    expect(emitted, '${prefix}12345');
  });

  testWidgets('normalizes phone value and includes prefix when includePrefixInData is true', (tester) async {
    const prefix = '+380 ';
    String? emitted;

    await tester.pumpWidget(
      wrapWithMaterial(
        ExtendedTextFormField(
          decoration: const InputDecoration(prefixText: prefix),
          includePrefixInData: true,
          keyboardType: TextInputType.phone,
          onChanged: (value) => emitted = value,
        ),
      ),
    );

    const rawUserInput = '0𝟗9 111 22 33';

    await tester.enterText(find.byType(TextFormField), rawUserInput);
    await tester.pump();

    final normalized = PhoneParser.normalize(rawUserInput);

    expect(emitted, '$prefix$normalized');
  });

  testWidgets('normalizes phone value without prefix when includePrefixInData is false', (tester) async {
    const prefix = '+380 ';
    String? emitted;

    await tester.pumpWidget(
      wrapWithMaterial(
        ExtendedTextFormField(
          decoration: const InputDecoration(prefixText: prefix),
          includePrefixInData: false,
          keyboardType: TextInputType.phone,
          onChanged: (value) => emitted = value,
        ),
      ),
    );

    const rawUserInput = '0𝟗𝟗 111 22 33';

    await tester.enterText(find.byType(TextFormField), rawUserInput);
    await tester.pump();

    final normalized = PhoneParser.normalize(rawUserInput);
    expect(emitted, normalized);
  });
}
