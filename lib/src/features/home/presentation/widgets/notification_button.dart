import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:project_saturdays/src/features/core/services/notification_service.dart';
import 'package:project_saturdays/src/features/notifications/presentation/notifications_screen.dart';

// import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationButton extends StatelessWidget {
  final bool isSaturday;

  NotificationButton({Key? key, required this.isSaturday}) : super(key: key);

  final _notificationService = NotificationService();

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {
          // BlocProvider.of<HomeBloc>(context, listen: false).add(InitializeHome());
          // BlocProvider.of<HomeBloc>(context).add(SabbathStarted());

          // if (isSaturday) {
          //   BlocProvider.of<HomeBloc>(context).add(SabbathEnded());
          // } else {
          //   BlocProvider.of<HomeBloc>(context).add(SabbathStarted());
          // }

          // _notificationService.scheduleNotifications(1, tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)));
          // _notificationService.scheduleNotifications(2, tz.TZDateTime.now(tz.local).add(const Duration(seconds: 15)));
          // _notificationService.scheduleNotifications(3, tz.TZDateTime.now(tz.local).add(const Duration(seconds: 60)));

          // print(_notificationService.getPendingNotificationRequests());
          // print(_notificationService.getActiveNotifications());

          // _notificationService.cancelAllNotifications();

          showCupertinoModalBottomSheet(
            context: context,
            duration: const Duration(milliseconds: 200),
            topRadius: const Radius.circular(34),
            barrierColor: Colors.black38,
            builder: (context) => const NotificationsPage(),
          );
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: isSaturday ? const Color(0xFF8D2A00).withOpacity(0.4) : Colors.blueGrey[100],
            // elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            )),
        child: const Icon(
          Icons.notifications_outlined,
          color: Colors.black,
          size: 28,
        ));
  }
}
