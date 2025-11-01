import 'package:flutter/material.dart';

class PointerWidget extends StatelessWidget {
  const PointerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Image.asset(
        'assets/finger.png',
        width: 240,
        fit: BoxFit.contain,
      ),
    );
  }
}
