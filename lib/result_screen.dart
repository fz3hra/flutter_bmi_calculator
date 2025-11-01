import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bmi_calculator/calculator_screen.dart';
import 'package:flutter_bmi_calculator/extensions.dart';
import 'package:google_fonts/google_fonts.dart';

// bmiResult
class ResultScreen extends StatelessWidget {
  final double? bmiResult;
  const ResultScreen({super.key, required this.bmiResult});

  String bmiCategory(double? bmi) {
    if (bmi!.isNaN || !bmi.isFinite) return 'Invalid';
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25.0) return 'Normal BMI';
    if (bmi < 30.0) return 'Overweight';
    if (bmi < 35.0) return 'Obese (Class I)';
    if (bmi < 40.0) return 'Obese (Class II)';
    return 'Obese (Class III)';
  }

  Color bmiColor(double bmi) {
    if (bmi < 18.5) return const Color(0xFF64B5F6);
    if (bmi < 25.0) return const Color(0xFF24A056);
    if (bmi < 30.0) return const Color(0xFFFCE700);
    return const Color(0xFFFC1300);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final topInset = MediaQuery.paddingOf(context).top;
    double arcWidth = 270;

    final label = bmiCategory(bmiResult);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          DecoratedBox(
            decoration: context.backgroundGradient,
          ),

          Positioned.fill(
            child: CustomPaint(
              painter: WavePainter(),
            ),
          ),

          Positioned(
            top: topInset,
            left: (size.width - arcWidth) / 2,
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 23),
              duration: Duration(milliseconds: 900),
              curve: Curves.easeOutCubic,
              builder: (context, animatedBmi, _) {
                return CustomPaint(
                  size: Size(arcWidth, 200),
                  painter: ArcsPainter(
                    bmi: bmiResult,
                    minBmi: 10,
                    maxBmi: 40,
                  ),
                );
              },
            ),
          ),

          Positioned(
            top: topInset + 154,
            left: 0,
            right: 0,
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 23.4),
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOutCubic,
              builder: (context, animatedBmi, _) {
                return Text(
                  key: Key("bmiResult"),
                  bmiResult!.toStringAsFixed(1),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 52,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.5,
                    shadows: [
                      Shadow(
                        blurRadius: 6,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          Positioned(
            top: topInset + 226,
            left: 0,
            right: 0,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                shadows: [
                  Shadow(blurRadius: 4, color: Colors.black26),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: size.height * 0.44,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'You\'re on track!\nKeep moving and eat well\neveryday.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: Color(0xFF161B26),
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  height: 1.5,
                  letterSpacing: 2.0,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 3,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 80,
            left: 40,
            right: 40,
            child: Material(
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
                    border: Border.all(
                      color: Colors.white.withOpacity(0.25),
                      width: 1,
                    ),
                    color: const Color(0xFFFFFFFF).withOpacity(0.40),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Color(
                          0xFF247BA0,
                        ).withOpacity(0.20),
                        offset: Offset(0, 5),
                        blurRadius: 14,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Center(
                      child: Text(
                        'Redo',
                        style: GoogleFonts.inter(
                          color: Color(0xFF161B26),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
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
    );
  }
}

class ArcsPainter extends CustomPainter {
  final double? bmi;
  final double minBmi, maxBmi;
  ArcsPainter({
    required this.bmi,
    required this.minBmi,
    required this.maxBmi,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final startAngle = math.pi;
    final sweepAngle = math.pi;
    final strokeWidth = 22.0;
    final center = Offset(size.width / 2, size.height);
    final radius = size.width * 0.55;

    final rect = Rect.fromCircle(center: center, radius: radius);

    // 1) BACKGROUND TRACK (behind the arc)
    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth + 4
      ..color = const Color(0xFF0B2534).withOpacity(0.35)
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        2.0,
      );

    canvas.drawArc(rect, startAngle, sweepAngle, false, trackPaint);

    final gradient = SweepGradient(
      stops: [0.0, 0.5, 1.0],
      startAngle: startAngle,
      endAngle: startAngle + sweepAngle,
      colors: [
        Color(0xFF24A056),
        Color(0xFFFCE700),
        Color(0xFFFC1300),
      ],
    ).createShader(rect);

    final arcPaint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt
      ..shader = gradient;

    canvas.drawArc(rect, startAngle, sweepAngle, false, arcPaint);

    final capR = strokeWidth / 2;

    // ---- compute arc endpoints ----
    final startPt = Offset(
      center.dx + radius * math.cos(startAngle),
      center.dy + radius * math.sin(startAngle),
    );

    final endPt = Offset(
      center.dx + radius * math.cos(startAngle + sweepAngle),
      center.dy + radius * math.sin(startAngle + sweepAngle),
    );

    canvas.drawCircle(
      startPt,
      capR,
      Paint()..color = const Color(0xFF24A056),
    );
    canvas.drawCircle(
      endPt,
      capR,
      Paint()..color = const Color(0xFFFC1300),
    );

    // ---- animated indicator (white knob) ----
    final t = ((bmi! - minBmi) / (maxBmi - minBmi)).clamp(0.0, 1.0);
    final angle = startAngle + sweepAngle * t;

    final knob = Offset(
      center.dx + radius * math.cos(angle),
      center.dy + radius * math.sin(angle),
    );

    // ---- white knob ----
    canvas.drawCircle(knob, capR * 1.4, Paint()..color = Colors.white);
    canvas.drawCircle(
      knob,
      capR * 1.4,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = Colors.white.withOpacity(0.25),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final path = Path()
      ..moveTo(0, h * 0.28)
      ..cubicTo(
        w * 0.18,
        h * 0.22,
        w * 0.58,
        h * 0.60,
        w * 0.82,
        h * 0.40,
      )
      ..cubicTo(
        w * 1.18,
        h * 0.10,
        w * 1.02,
        h * 0.38,
        w * 1.08,
        h * 0.52,
      )
      ..lineTo(w * 1.08, h)
      ..lineTo(0, h)
      ..close();

    final fillShader = const LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        Color(0xFF64B8FF),
        Color(0xFFD9ECFF),
      ],
      stops: [0.0, 1.0],
    ).createShader(Rect.fromLTWH(0, 0, w, h));

    final fill = Paint()
      ..shader = fillShader
      ..style = PaintingStyle.fill;

    canvas.drawShadow(path, Colors.black.withOpacity(0.45), 22, false);

    canvas.drawPath(path, fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
