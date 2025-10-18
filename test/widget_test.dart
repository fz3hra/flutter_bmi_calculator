// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_bmi_calculator/home_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_bmi_calculator/main.dart';

void main() {
  Widget _app() => const MaterialApp(home: HomeScreen());

  group('BMI 1st test ', () {
    testWidgets('- if weight is empty; BMI is empty', (tester) async {
      await tester.pumpWidget(_app());

      await tester.enterText(find.byKey(const Key('height')), '1.70');
      await tester.enterText(find.byKey(const Key('weight')), '');
      await tester.pump();

      final resultText = tester.widget<Text>(
        find.byKey(const Key('bmiResult')),
      );
      expect(resultText.data, isEmpty);
    });

    testWidgets('BMI 2nd test - if height is empty; BMI is empty', (
      tester,
    ) async {
      await tester.pumpWidget(_app());

      await tester.enterText(find.byKey(const Key('height')), '1.70');
      await tester.enterText(find.byKey(const Key('weight')), '');
      await tester.pump();
      final resultText = tester.widget<Text>(
        find.byKey(const Key('bmiResult')),
      );
      expect(resultText.data, isEmpty);
    });

    testWidgets(
      'BMI 3rd test - if height and weight not empty, BMI shows correct value',
      (tester) async {
        await tester.pumpWidget(_app());

        await tester.enterText(find.byKey(const Key('height')), '1.70');
        await tester.enterText(
          find.byKey(const Key('weight')),
          '',
        );
        await tester.pump();

        final resultText = tester.widget<Text>(
          find.byKey(const Key('bmiResult')),
        );
        expect(resultText.data, isEmpty);
      },
    );
  });
}
