import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class Indicator extends StatefulWidget {
  const Indicator({Key? key}) : super(key: key);

  @override
  State<Indicator> createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> {
  late Timer _timer;
  late DateTime time;

  @override
  void initState() {
    super.initState();
    time = DateTime.now();
    // time = DateTime.now().add(Duration(days: 5, hours: 6));
    // time = DateTime(2023, 2, 17, 18, 36).add(Duration(hours: 24));
    _timer = Timer.periodic(const Duration(seconds: 1), setTime);
    print(time.toString());
  }

  void setTime(Timer timer) {
    setState(() {
      // time += 0.01;
      time = DateTime.now();
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
      // angle: 2 * math.pi * time / (60 * 60),
      // angle: 2 * math.pi * ((7 / 7) + (12 / 168) + (30 / 10080) + (45 / 604800)),
      angle: 2 * math.pi * ((time.weekday / 7) + ((time.hour) / 168) + (time.minute / 10080) + (time.second / 604800)),
      child: Center(
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
    canvas.drawArc(Offset((size.width - diameter) / 2, (size.height - diameter) / 2) & Size(diameter, diameter),
        startAngle, sweepAngle, useCenter, paint);
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
