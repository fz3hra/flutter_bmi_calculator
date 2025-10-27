import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bmi_calculator/app_agent.dart';
import 'package:flutter_bmi_calculator/app_state.dart';
import 'package:flutter_bmi_calculator/calculator.dart';
import 'package:flutter_bmi_calculator/calculator_screen.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppAgent appAgent = AppAgent();

  late TextEditingController nameController;
  late TextEditingController genderController;
  late TextEditingController dobController;

  String bmi = "";

  @override
  void initState() {
    super.initState();
    // appAgent.initialize();

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

  void submitFeedback() {
    BetterFeedback.of(context).show((UserFeedback feedback) {
      //   appAgent.submitFeedback(context, feedback.screenshot, feedback.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    // var bmiResult = displayBMI();
    final calc = const Calculator();
    final bmiResult = calc.displayBMI(
      nameController.text,
      genderController.text,
    );

    final scheme = Theme.of(context).colorScheme;
    final manager = context.watch<AppState>();

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
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 72.0,
              horizontal: 32,
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: submitFeedback,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.bug_report,
                        color: Colors.white,
                        size: 18,
                      ),
                      Gap(8),
                      Text(
                        "File Changes",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  "assets/logo.png",
                ),
                Gap(46),
                TextField(
                  key: Key("name"),
                  controller: nameController,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: "Name",
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
                ),
                Gap(24),
                TextField(
                  key: Key("gender"),
                  controller: genderController,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: "Gender",
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
                ),
                Gap(24),
                Expanded(
                  child: TextField(
                    key: Key("dob"),
                    controller: dobController,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: "Gender",
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
                  ),
                ),
                Material(
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
                        // color: manager.primaryButtonColor,
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
