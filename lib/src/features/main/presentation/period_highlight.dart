import 'package:flutter/material.dart';
import 'package:project_saturdays/src/constants/colors.dart';
import 'dart:math' as math;

class PeriodHighlight extends StatelessWidget {
  const PeriodHighlight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return CustomPaint(
              size: Size(constraints.maxWidth, constraints.maxWidth),
              painter: HighlightPainter(),
            );
          },
        ),
      ),
    );
  }
}

class HighlightPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // * Line
    final paint1 = Paint()
      ..color = kPrimaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final p1 = Offset(size.width / 2, 4);
    final p2 = Offset(size.width / 2, 37);
    canvas.drawLine(p1, p2, paint1);

    // * Arch
    final diameter = size.height - 60;
    const startAngle = -math.pi / 2;
    const sweepAngle = math.pi / 3.5;
    const useCenter = false;
    final paint = Paint()
      ..color = kPrimaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
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
