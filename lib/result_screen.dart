import 'package:flutter/material.dart';

// bmiResult
class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
