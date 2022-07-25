import 'package:flutter/material.dart';
import 'package:project_saturdays/src/constants/colors.dart';

class DayTitle extends StatelessWidget {
  const DayTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.ideographic,
            children: const [
              Opacity(
                opacity: 0,
                child: Text('may',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Text('17',
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
              Text('may',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor)),
            ],
          ),
          const Text('Saturday',
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, height: 1)),
        ],
      ),
    );
  }
}
