import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_saturdays/src/features/home/presentation/bloc/bloc/home_bloc.dart';
import 'package:project_saturdays/src/styles/colors.dart';
import 'dart:math' as math;

class PeriodsTicks extends StatelessWidget {
  const PeriodsTicks({Key? key}) : super(key: key);

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
    var tickMarkLength = 25;
    final paint1 = Paint()
      ..color = isSaturday ? Colors.white.withOpacity(0.3) : Colors.black.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    const angle = 2 * math.pi / 7;
    final radius = size.width / 2;
    canvas.save();

    // drawing
    canvas.translate(radius, radius);
    for (var i = 0; i < 5; i++) {
      canvas.rotate(angle);

      canvas.drawLine(
        Offset(0.0, -radius + 27),
        Offset(0.0, -radius + 27 + tickMarkLength),
        paint1,
      );
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
