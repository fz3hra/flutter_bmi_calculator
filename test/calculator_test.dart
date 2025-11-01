import 'package:flutter_bmi_calculator/calculator.dart';
import 'package:test/test.dart';

void main() {
  group('parse', () {
    test("Parsing value returns 4.9 if ',' is used", () {
      final calculator = Calculator();

      final result = calculator.parse("4,9");

      expect(result, 4.9);
    });

    test("Parsing value returns 5.1 if '.' is used", () {
      final calculator = Calculator();

      final result = calculator.parse("5.1");

      expect(result, 5.1);
    });

    test("If height/weight is empty", () {
      final calculator = Calculator();

      final result = calculator.parse("");

      expect(result, isNull);
    });

    test("If height/weight has whitespace", () {
      final calculator = Calculator();

      final result = calculator.parse("   ");

      expect(result, isNull);
    });

    test("If height/weight has non numeric", () {
      final calculator = Calculator();

      final result = calculator.parse("xyz");

      expect(result, isNull);
    });
  });

  group("calculation", () {
    test("BMI Calculation; returns 2", () {
      final calculator = Calculator();

      final result = calculator.bmiCalc(8, 2);

      expect(result, 2);
    });

    test("BMI Calculation; returns 4", () {
      final calculator = Calculator();

      final result = calculator.bmiCalc(16, 2);

      expect(result, 4);
    });

    test("If height is 0", () {
      final calculator = Calculator();

      final result = calculator.bmiCalc(0, 2);

      expect(result, 0.0);
    });

    test("If height is 0", () {
      final calculator = Calculator();

      final result = calculator.bmiCalc(8, 0);

      expect(result, isNull);
    });

    test("If weight/height is 0", () {
      final calculator = Calculator();

      final result1 = calculator.bmiCalc(null, 2);
      expect(result1, isNull);

      final result2 = calculator.bmiCalc(8, null);
      expect(result2, isNull);
    });
  });

  group("Display", () {
    test("Display Correct BMI result; returns 2.0", () {
      final calculator = Calculator();

      final result = calculator.displayBMI("8", "2");

      expect(result, 2.0);
    });

    test("Display Correct BMI result; returns 4.0", () {
      final calculator = Calculator();

      final result = calculator.displayBMI("16", "2");

      expect(result, 4.0);
    });
  });
}
