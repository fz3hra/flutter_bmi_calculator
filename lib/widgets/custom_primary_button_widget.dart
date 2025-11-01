import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPrimaryButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonName;
  final Key? keyValue;

  const CustomPrimaryButton({
    super.key,
    required this.onTap,
    required this.buttonName,
    this.keyValue,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      key: keyValue,
      color: Colors.transparent,
      clipBehavior: Clip.none,
      child: InkWell(
        onTap: onTap,
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
                  buttonName,
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
