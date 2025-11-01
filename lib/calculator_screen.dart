import 'package:flutter/material.dart';
import 'package:flutter_bmi_calculator/calculator.dart';
import 'package:flutter_bmi_calculator/extensions.dart';
import 'package:flutter_bmi_calculator/home_screen.dart';
import 'package:flutter_bmi_calculator/result_screen.dart';
import 'package:flutter_bmi_calculator/widgets/custom_primary_button_widget.dart';
import 'package:flutter_bmi_calculator/widgets/custom_textfields_widget.dart';
import 'package:flutter_bmi_calculator/widgets/edit_profile_widge.dart';
import 'package:flutter_bmi_calculator/widgets/gettings_widget.dart';
import 'package:flutter_bmi_calculator/widgets/pointer_widget.dart';
import 'package:gap/gap.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: DecoratedBox(
              decoration: context.backgroundGradient,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 72.0,
                  horizontal: 32,
                ),
                child: Column(
                  children: [
                    GreetingsWidget(),
                    Gap(24),
                    CustomTextFields(
                      keyValue: Key('weight'),
                      controller: weightController,
                      onChanged: (String value) => setState(() {}),
                      hintText: 'Weight (kg)',
                    ),
                    Gap(24),
                    CustomTextFields(
                      keyValue: Key('height'),
                      controller: heightController,
                      onChanged: (String value) => setState(() {}),
                      hintText: 'Height (m/cm)',
                    ),
                    Gap(32),
                    CustomPrimaryButton(
                      onTap: () {
                        // calculate the BMI then push to result screen.
                        final calc = const Calculator();
                        final bmiResult = calc.displayBMI(
                          weightController.text,
                          heightController.text,
                        );

                        if (bmiResult == -1) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please enter a valid weight and height.',
                              ),
                            ),
                          );
                          return;
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultScreen(
                              bmiResult: bmiResult,
                            ),
                          ),
                        );
                      },
                      buttonName: 'Calculate BMI',
                    ),
                    Gap(52),
                    EditProfileWidget(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      ),
                      buttonName: 'Edit Profile',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: PointerWidget(),
          ),
        ],
      ),
    );
  }
}
