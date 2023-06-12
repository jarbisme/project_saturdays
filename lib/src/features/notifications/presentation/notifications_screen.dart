import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_saturdays/src/features/notifications/domain/notification.dart';
import 'package:project_saturdays/src/styles/colors.dart';

import 'bloc/notifications_bloc.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var buttons = [
    //   NotificationModel(minutes: 15, isChecked: true),
    //   NotificationModel(minutes: 30, isChecked: false),
    //   NotificationModel(minutes: 45, isChecked: false),
    //   NotificationModel(minutes: 60, isChecked: true),
    //   NotificationModel(minutes: 90, isChecked: false),
    // ];

    return BlocBuilder<NotificationsBloc, NotificationsState>(
      builder: (context, state) {
        return Container(
          height: 280,
          // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
          // color: Colors.red,
          child: Scaffold(
            backgroundColor: kBackgroundColor,
            body: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 5,
                      width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Notifications',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ...state.notifications.map((e) => CircleButton(notification: e)),
                      ],
                    ),
                  ),
                  const Text(
                    'How many minutes before do you want to be notified?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CircleButton extends StatelessWidget {
  final NotificationModel notification;

  const CircleButton({Key? key, required this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(50, 50),
        shape: const CircleBorder(),
        backgroundColor: notification.isChecked ? kPrimaryColor : kGrayColor,
      ),
      onPressed: () {
        // notification.isChecked = !notification.isChecked;

        BlocProvider.of<NotificationsBloc>(context)
            .add(SetNotification(notification.copyWith(isChecked: !notification.isChecked)));
      },
      child: Text(
        notification.minutes.toString(),
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: notification.isChecked ? kBackgroundColor : Colors.black,
        ),
      ),
    );
  }
}
