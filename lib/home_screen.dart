import 'package:flutter/material.dart';
import 'package:flutter_bmi_calculator/calculator.dart';
import 'package:flutter_bmi_calculator/calculator_screen.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController nameController;
  late TextEditingController genderController;
  late TextEditingController dobController;

  String bmi = "";

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    genderController = TextEditingController();
    dobController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    genderController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var bmiResult = displayBMI();
    final calc = const Calculator();
    final bmiResult = calc.displayBMI(
      nameController.text,
      genderController.text,
    );

    void onAnyFieldChanged(String _) => setState(() {});

    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: <Color>[
                Color(0xFF0F2333),
                Color(0xFF247BA0),
                Color(0xFF189AE5),
              ],
              stops: [0.50, 0.90, 1.00],
            ),
          ),
          child: HomeContent(
            nameController: nameController,
            genderController: genderController,
            dobController: dobController,
            onChanged: onAnyFieldChanged,
          ),
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController genderController;
  final TextEditingController dobController;
  final ValueChanged<String> onChanged;

  const HomeContent({
    super.key,
    required this.nameController,
    required this.genderController,
    required this.dobController,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 72.0,
        horizontal: 32,
      ),
      child: Column(
        children: [
          LogoWidget(),
          Gap(46),
          CustomTextFields(
            keyValue: Key('name'),
            controller: nameController,
            onChanged: onChanged,
            hintText: 'Name',
          ),
          Gap(24),
          CustomTextFields(
            keyValue: Key('gender'),
            controller: genderController,
            onChanged: onChanged,
            hintText: 'Gender',
          ),
          Gap(24),
          Expanded(
            child: CustomTextFields(
              keyValue: Key('dob'),
              controller: dobController,
              onChanged: onChanged,
              hintText: 'Gender',
            ),
          ),
          CustomPrimaryButton(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CalculatorScreen(),
              ),
            ),
            buttonName: 'Continue',
          ),
        ],
      ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/logo.png",
    );
  }
}

class CustomTextFields extends StatelessWidget {
  final Key keyValue;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;
  const CustomTextFields({
    super.key,
    required this.keyValue,
    required this.controller,
    required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: Key(keyValue.toString()),
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.inter(
          textStyle: TextStyle(
            color: Color(0xFF546A7B),
            fontSize: 14,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Color(0xFFE8F1F2),
      ),
    );
  }
}

class CustomPrimaryButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonName;

  const CustomPrimaryButton({
    super.key,
    required this.onTap,
    required this.buttonName,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.none,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CalculatorScreen(),
          ),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFF1B98E1),
            boxShadow: const [
              BoxShadow(
                color: Color(
                  0x33247BA0,
                ),
                offset: Offset(0, 5),
                blurRadius: 14,
                spreadRadius: 0,
              ),
            ],
          ),
          child: SizedBox(
            width: double.infinity,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "Continue",
                  style: GoogleFonts.inter(
                    color: Colors.white, // make text solid white
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
