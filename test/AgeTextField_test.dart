import 'package:bench/routes/MainScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget createWidgetForTesting({Widget? child}) {
  return MaterialApp(
    home: child,
  );
}

void main() {
  testWidgets('Age text field test', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: MainScreen()));
    var textField = find.byKey(const Key('ageTextField'));
    expect(textField, findsOneWidget);
    await tester.enterText(textField, '10');
    expect(find.text('10'), findsOneWidget);
    expect(MainScreen().getAgeValidated(), true);
    await tester.enterText(textField, '102');
    expect(find.text('102'), findsOneWidget);
    expect(MainScreen().getAgeValidated(), false);
  });
}