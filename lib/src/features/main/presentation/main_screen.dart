import 'package:flutter/material.dart';
import 'package:project_saturdays/src/constants/colors.dart';
import 'package:project_saturdays/src/features/main/presentation/globe.dart';
import 'package:project_saturdays/src/features/main/presentation/saturday_details.dart';
import 'package:project_saturdays/src/features/main/presentation/title_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        bottom: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  DayTitle(),
                  Globe(),
                ],
              ),
            ),
            const SaturdayDetails(),
          ],
        ),
      ),
    );
  }
}
