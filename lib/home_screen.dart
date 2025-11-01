import 'package:flutter/material.dart';
import 'package:flutter_bmi_calculator/calculator_screen.dart';
import 'package:flutter_bmi_calculator/extensions.dart';
import 'package:flutter_bmi_calculator/widgets/custom_primary_button_widget.dart';
import 'package:flutter_bmi_calculator/widgets/custom_textfields_widget.dart';
import 'package:flutter_bmi_calculator/widgets/logo_widget.dart';
import 'package:gap/gap.dart';

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
    void onAnyFieldChanged(String _) => setState(() {});

    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: DecoratedBox(
          decoration: context.backgroundGradient,
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
              hintText: 'Dob',
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
