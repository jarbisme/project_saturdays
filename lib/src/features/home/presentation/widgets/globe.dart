import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_saturdays/src/features/home/presentation/bloc/bloc/home_bloc.dart';
import 'package:project_saturdays/src/features/home/presentation/widgets/indicator.dart';
import 'package:project_saturdays/src/features/home/presentation/widgets/periods_ticks.dart';

import 'period_highlight.dart';
import 'dart:math' as math;

class Globe extends StatelessWidget {
  const Globe({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: AspectRatio(
            aspectRatio: 1,
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(75),
                    child: Container(
                      // width: 293,
                      // height: 293,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(20, 20),
                            blurRadius: 54,
                          )
                        ],
                        color: Colors.black,
                        shape: BoxShape.circle,
                        gradient: const RadialGradient(
                          stops: [0, 0.7, 0.85, 1],
                          radius: 0.9,
                          colors: [
                            Color(0xffF3F7F9),
                            Color(0xffCBCBCB),
                            Color(0xffADADAD),
                            Color(0xff9A9A9A),
                          ],
                          center: Alignment(-0.3, -0.3),
                        ),
                      ),
                    ),
                  ),
                ),
                // const Indicator(),
                const PeriodsTicks(),
                const PeriodHighlight(),
                const Indicator(),
              ],
            ),
          ),
        );
      },
    );
  }
}
