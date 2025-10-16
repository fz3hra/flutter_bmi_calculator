import 'dart:math';

class Calculator {
  const Calculator();

  double? parse(String text) {
    if (text.trim().isEmpty) return null;
    return double.tryParse(text.replaceAll(',', '.'));
  }

  double? bmiCalc(double? weight, double? height) {
    if (weight == null || height == null || height <= 0) return null;
    return weight / pow(height, 2);
  }

  String displayBMI(String weightText, String heightText) {
    final weight = parse(weightText);
    final height = parse(heightText);

    if (weight != null && height != null) {
      var result = bmiCalc(weight, height);
      return result.toString();
    }
    return "";
  }
}
