import 'dart:math';

class Calculator {
  const Calculator();

  double? parse(String text) {
    if (text.trim().isEmpty) return null;
    return double.tryParse(text.replaceAll(',', '.'));
  }

  double? bmiCalc(double? weight, double? height) {
    if (weight == null || height == null || height <= 0) return null;
    //check if height is in m or cm
    final convertedHeight = height > 3 ? height / 100 : height;
    return weight / pow(convertedHeight, 2);
  }

  double? displayBMI(String weightText, String heightText) {
    final weight = parse(weightText);
    final height = parse(heightText);

    if (weight != null && height != null) {
      var result = bmiCalc(weight, height);
      return result;
    }
    return -1;
  }
}
