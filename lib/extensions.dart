import 'package:flutter/material.dart';

extension BackgroundGradient on BuildContext {
  BoxDecoration get backgroundGradient => BoxDecoration(
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
  );
}
