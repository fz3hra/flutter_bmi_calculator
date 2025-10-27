import 'package:flutter/material.dart';
import 'package:flutter_bmi_calculator/home_screen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const HomeScreen(),
    );
  }
}

// TODO: BMI calculation
//BMI = weight (kg) / height² (m²)
