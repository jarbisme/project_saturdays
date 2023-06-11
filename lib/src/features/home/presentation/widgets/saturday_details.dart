import 'dart:async';

import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project_saturdays/src/features/home/domain/sabbath.dart';
import 'package:project_saturdays/src/features/home/presentation/bloc/bloc/home_bloc.dart';

import 'package:project_saturdays/src/styles/colors.dart';

class SaturdayDetails extends StatefulWidget {
  Sabbath sabbath;
  bool isSaturday;
  SaturdayDetails({Key? key, required this.sabbath, required this.isSaturday}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SaturdayDetailsState();
}

class _SaturdayDetailsState extends State<SaturdayDetails> {
  late Timer _timer;
  // late bool isSaturday;
  // late DateTime startDate;

  late Duration diferenceDate;

  @override
  void initState() {
    super.initState();
    checkDiference();
    diferenceDate = widget.sabbath.startDateTime.difference(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1), setTime);
  }

  void checkDiference() {
    if (widget.sabbath.startDateTime.difference(DateTime.now()).isNegative) {
      if (widget.isSaturday == false) {
        print('Saturday!');
        // dispatch event SaturdayStarted
        BlocProvider.of<HomeBloc>(context).add(SabbathStarted());
        // isSaturday = true;
      }
    } else {
      if (widget.isSaturday == true) {
        print('Not saturday');
        // dispatch event SaturdayEnded
        BlocProvider.of<HomeBloc>(context).add(SabbathEnded());
        // isSaturday = false;
      }
    }
  }

  void setTime(Timer? timer) {
    checkDiference();
    setState(() {
      if (widget.isSaturday) {
        diferenceDate = widget.sabbath.endDateTime.difference(DateTime.now());
      } else {
        diferenceDate = widget.sabbath.startDateTime.difference(DateTime.now());
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 50, 60),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 3,
              // height: 100,
              color: Colors.black,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DetaillHourInfo(
                  title: 'Friday sunset',
                  content: widget.sabbath.startDateTime,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 0, bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.isSaturday ? 'Saturday ends in' : 'Saturday starts in',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        // '3 d : 18 h : 25 m',
                        printDuration(
                          (aMinute * diferenceDate.inMinutes).inMinutes < 59 &&
                                  (aMinute * diferenceDate.inMinutes).inMinutes >= 0
                              ? aSecond * diferenceDate.inSeconds
                              : aMinute * diferenceDate.inMinutes,
                          abbreviated: true,
                          // spacer: ' : ',
                          delimiter: ' : ',
                        ).replaceAll('min', 'm'),
                        style: TextStyle(
                          fontSize: 32,
                          color: widget.isSaturday ? Colors.white : kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                DetaillHourInfo(
                  title: 'Saturday sunset',
                  content: widget.sabbath.endDateTime,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DetaillHourInfo extends StatelessWidget {
  const DetaillHourInfo({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title;
  final DateTime content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 3,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            DateFormat('dd MMM hh:mm').format(content.toLocal()),
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
