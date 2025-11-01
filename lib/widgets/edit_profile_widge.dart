import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonName;

  const EditProfileWidget({
    super.key,
    required this.onTap,
    required this.buttonName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            Icons.edit,
            color: Colors.white,
            size: 18,
          ),
          Gap(16),
          Text(
            buttonName,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
