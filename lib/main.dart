import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_bmi_calculator/calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
    );
  }
}

// TODO: BMI calculation
//BMI = weight (kg) / height² (m²)

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController weightController;
  late TextEditingController heightController;
  String bmi = "";

  @override
  void initState() {
    super.initState();
    weightController = TextEditingController();
    heightController = TextEditingController();
  }

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  //   double? _parse(String text) {
  //     if (text.trim().isEmpty) return null;
  //     return double.tryParse(text.replaceAll(',', '.'));
  //   }

  //   double? _bmiCalc(double? weight, double? height) {
  //     if (weight == null || height == null || height <= 0) return null;
  //     return weight / pow(height, 2);
  //   }

  //   String displayBMI() {
  //     final weight = _parse(weightController.text);
  //     final height = _parse(heightController.text);

  //     if (weight != null && height != null) {
  //       var result = _bmiCalc(weight, height);
  //       return result.toString();
  //     }
  //     return "";
  //   }

  @override
  Widget build(BuildContext context) {
    // var bmiResult = displayBMI();
    final calc = const Calculator();
    final bmiResult = calc.displayBMI(
      weightController.text,
      heightController.text,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calcualator'),
      ),
      body: Column(
        children: [
          Text("Weight (kg)"),
          TextField(
            key: Key("weight"),
            controller: weightController,
            onChanged: (_) => setState(() {}),
          ),
          Text("Height (m)"),
          TextField(
            key: Key("height"),
            controller: heightController,
            onChanged: (_) => setState(() {}),
          ),
          SizedBox(
            height: 20,
          ),
          Text("BMI (kg/m^2)"),
          Text(
            key: Key("bmiResult"),
            bmiResult,
          ),
        ],
      ),
    );
  }
}
