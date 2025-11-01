import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFields extends StatelessWidget {
  final Key? keyValue;
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
      key: keyValue,
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
