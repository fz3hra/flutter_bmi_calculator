import 'package:flutter/material.dart';
import 'package:flutter_bmi_calculator/home_screen.dart';
import 'package:flutter_bmi_calculator/result_screen.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

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
                    Text(
                      "Hi, Zaahra!",
                      style: GoogleFonts.caveat(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.40,
                      ),
                    ),
                    Text(
                      "Let's Calculate Your \nBMI",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.40,
                      ),
                    ),
                    Gap(24),
                    TextField(
                      key: Key("weight"),
                      controller: weightController,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: "Weight",
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
                      key: Key("height"),
                      controller: weightController,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: "Height",
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
                    Gap(32),
                    Material(
                      color: Colors.transparent,
                      clipBehavior: Clip.none,
                      child: InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultScreen(),
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
                                  "Calculate BMI",
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
                    Gap(52),
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 18,
                          ),
                          Gap(8),
                          Text(
                            "Edit Profile",
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: IgnorePointer(
              child: Image.asset(
                'assets/finger.png',
                width: 240,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
