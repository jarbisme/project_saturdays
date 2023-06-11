import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_saturdays/src/features/home/presentation/bloc/bloc/home_bloc.dart';
import 'package:project_saturdays/src/styles/colors.dart';
import 'dart:math' as math;

class PeriodHighlight extends StatelessWidget {
  const PeriodHighlight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return CustomPaint(
                  size: Size(constraints.maxWidth, constraints.maxWidth),
                  painter: HighlightPainter(state.isSaturday),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class HighlightPainter extends CustomPainter {
  final isSaturday;

  HighlightPainter(this.isSaturday);

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.rotate(2 * math.pi);

    // * Line
    final paint1 = Paint()
      ..color = isSaturday ? Colors.white : kPrimaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final p1 = Offset((size.width / 2) - 1.5, 4);
    final p2 = Offset((size.width / 2) - 1.5, 37);
    canvas.drawLine(p1, p2, paint1);

    // * Arch
    final diameter = size.height - 60;
    const startAngle = -math.pi / 2;
    const sweepAngle = -math.pi / 3.5;
    const useCenter = false;
    final paint = Paint()
      ..color = isSaturday ? Colors.white : kPrimaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    canvas.drawArc(Offset((size.width - diameter) / 2, (size.height - diameter) / 2) & Size(diameter, diameter),
        startAngle, sweepAngle, useCenter, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
