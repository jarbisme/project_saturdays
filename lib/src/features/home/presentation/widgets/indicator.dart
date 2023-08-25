import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';

class Indicator extends StatefulWidget {
  const Indicator({Key? key}) : super(key: key);

  @override
  State<Indicator> createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> {
  late Timer _timer;
  late DateTime time;
  late double angleOffset;

  @override
  void initState() {
    super.initState();
    time = DateTime.now();
    // time = DateTime.now().add(Duration(days: 5, hours: 6));
    // time = DateTime(2023, 8, 18, 19, 9).add(Duration(hours: 0));
    _timer = Timer.periodic(const Duration(seconds: 1), setTime);
    // print(time.toString());
  }

  void setTime(Timer timer) {
    setState(() {
      // time += 0.01;
      time = DateTime.now();
    });
  }

  double calculateOffset(DateTime date) {
    var hourOf = 0.039; // offset of 1 hour
    var minOf = hourOf / 60;

    return (hourOf * (23 - date.hour)) + (minOf * (60 - date.minute));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  var hourOf = 0.04;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Transform.rotate(
          // angle: 2 * math.pi * time / (60 * 60 * 24 * 7),
          // angle: 2 * math.pi * time / (60 * 60),
          // angle: (2 * math.pi * ((6 / 7) + (19 / 168) + (08 / 10080) + (0 / 604800))) +
          //     calculateOffset(DateTime(2023, 8, 18, 19, 08)), // Sunday 12:00 am
          // angle: 2 * math.pi * ((6 / 7) + (19 / 168) + (07 / 10080) + (0 / 604800)) +
          //     calculateOffset(state.sabbath!.startDateTime.toLocal()),
          // angle: -0.75,
          angle: 2 *
                  math.pi *
                  ((time.weekday / 7) + ((time.hour) / 168) + (time.minute / 10080) + (time.second / 604800)) +
              calculateOffset(state.sabbath!.startDateTime.toLocal()),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return CustomPaint(
                    size: Size(constraints.maxWidth, constraints.maxWidth),
                    painter: IndicatorCirclePainter(),
                    // painter: IndicatorPainter(),
                  );
                },
              ),
            ),
          ),
        );
      },
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
      ..strokeWidth = 40;
    canvas.drawArc(Offset((size.width - diameter) / 2 - 3, (size.height - diameter) / 2) & Size(diameter, diameter),
        startAngle, sweepAngle, useCenter, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class IndicatorCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final diameter = size.height - 80;
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    // canvas.drawCircle(Offset((size.width) / 2 + 19, (size.height - diameter) / 2), 1, paint);
    // Offset for Sunday 12:00 am
    canvas.drawCircle(Offset((size.width) / 2 - 9, (size.height - diameter) / 2), 1, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class IndicatorTop extends StatefulWidget {
  const IndicatorTop({super.key});

  @override
  State<IndicatorTop> createState() => _IndicatorTopState();
}

class _IndicatorTopState extends State<IndicatorTop> {
  late Timer _timer;
  double time = 1;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 10), setTime);
  }

  void setTime(Timer timer) {
    setState(() {
      time += 0.01;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      // angle: 2 * math.pi * time / (60 * 60 * 24 * 7),
      angle: 2 * math.pi * time / (60 * 60),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return CustomPaint(
                size: Size(constraints.maxWidth, constraints.maxWidth),
                painter: IndicatorTopPainter(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class IndicatorTopPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // * Arch
    final diameter = size.height - 96 + 35;
    const startAngle = -math.pi / 2;
    const sweepAngle = 0.2;
    const useCenter = false;
    final paint = Paint()
      ..color = Colors.black.withOpacity(1)
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
