import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_saturdays/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:project_saturdays/src/styles/colors.dart';
import 'dart:math' as math;

class PeriodRing extends StatelessWidget {
  const PeriodRing({Key? key}) : super(key: key);

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
                  painter: RingPainter(state.isSaturday),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class RingPainter extends CustomPainter {
  final isSaturday;

  RingPainter(this.isSaturday);

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.rotate(2 * math.pi);

    // * Line
    // final paint1 = Paint()
    //   ..color = isSaturday ? Colors.white : kPrimaryColor
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 3;

    // final p1 = Offset((size.width / 2) - 1.5, 14);
    // final p2 = Offset((size.width / 2) - 1.5, 47);
    // canvas.drawLine(p1, p2, paint1);

    // * Arch
    final diameter = size.height - 92;
    const startAngle = -math.pi / 2;
    const sweepAngle = -math.pi * 2;
    const useCenter = false;
    final paint = Paint()
      ..color = isSaturday ? Colors.white : kPrimaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    canvas.drawArc(Offset((size.width - diameter) / 2, (size.height - diameter) / 2) & Size(diameter, diameter),
        startAngle, sweepAngle, useCenter, paint);
    // canvas.drawCircle(Offset((diameter / 2), (diameter / 2)), diameter / 2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
