import 'package:bench/main.dart' as app;
import 'package:bench/routes/MainScreen.dart';
import 'package:bench/routes/ResultScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('test1', (WidgetTester tester) async {
    app.main();
    await tester.pumpWidget(MainScreen());
    await tester.pumpAndSettle();
    var ageTextField = find.byKey(const Key('ageTextField'));
    await tester.enterText(ageTextField, '10');
    expect(find.text('10'), findsOneWidget);
    var weightTextField = find.byKey(const Key('weightTextField'));
    await tester.enterText(weightTextField, '40');
    expect(find.text('40'), findsOneWidget);
    await tester.tap(find.text('Oblicz'));
    await tester.pumpAndSettle();
    // var errorText = find.byKey(const Key('errorText'));
    // expect(errorText.hitTestable(), findsOneWidget);
    expect(find.byType(ResultScreen), findsOneWidget);
    expect(find.text('Dawka dla dziecka: 15.00ml'), findsOneWidget);
  });
}