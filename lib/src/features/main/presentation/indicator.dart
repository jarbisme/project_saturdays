import 'package:flutter/material.dart';
import 'dart:math' as math;

class Indicator extends StatelessWidget {
  const Indicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return CustomPaint(
              size: Size(constraints.maxWidth, constraints.maxWidth),
              painter: IndicatorPainter(),
            );
          },
        ),
      ),
    );
  }
}

class IndicatorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // * Arch
    final diameter = size.height - 96;
    const startAngle = -math.pi / 2;
    const sweepAngle = 0.2;
    const useCenter = false;
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 50;
    canvas.drawArc(
        Offset((size.width - diameter) / 2, (size.height - diameter) / 2) &
            Size(diameter, diameter),
        startAngle,
        sweepAngle,
        useCenter,
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
