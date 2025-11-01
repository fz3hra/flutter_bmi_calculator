import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GreetingsWidget extends StatelessWidget {
  const GreetingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}
