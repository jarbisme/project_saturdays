import 'package:flutter/material.dart';
import 'package:project_saturdays/src/constants/colors.dart';

class SaturdayDetails extends StatelessWidget {
  const SaturdayDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(60, 0, 60, 60),
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
                const DetailHourInfo(
                  title: 'Friday sunset',
                  content: '6:35 pm',
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 0, bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Saturday starts in',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '3 d : 17 h : 25 m',
                        style: TextStyle(
                          fontSize: 32,
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const DetailHourInfo(
                  title: 'Saturday sunset',
                  content: '6:37 pm',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DetailHourInfo extends StatelessWidget {
  const DetailHourInfo({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title;
  final String content;

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
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            content,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
