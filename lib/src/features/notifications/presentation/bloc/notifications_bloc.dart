import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_saturdays/src/features/core/services/notification_service.dart';
import 'package:project_saturdays/src/features/home/domain/sabbath.dart';
import 'package:project_saturdays/src/features/home/presentation/bloc/bloc/home_bloc.dart';
import 'package:project_saturdays/src/features/notifications/data/repositories/notifications_repository.dart';
import 'package:project_saturdays/src/features/notifications/domain/notification.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final HomeBloc _homeBloc;
  final _notificationsRepository = NotificationsRepository();
  final _notificationService = NotificationService();

  NotificationsBloc(this._homeBloc) : super(NotificationsInitial()) {
    print('Initializing Notifications Module');

    on<InitializeNotifications>((event, emit) async {
      var notifications = await _notificationsRepository.getNotifications();

      if (notifications != null) {
        initializeNotifications(notifications, _homeBloc.state.sabbath!);
        emit(SetNotifications(notifications));
      }
    });
    on<SetNotification>((event, emit) async {
      // * get notification object from state
      // var notification = state.notifications.firstWhere((element) => element.id == event.notification.id);
      // * get index of the notification
      // var index = state.notifications.indexOf(notification);

      // var notifications = [...state.notifications];
      // notifications[index] = event.notification;
      var newNotifications = [...state.notifications];
      newNotifications[event.notification.id - 1] = event.notification;

      var result = await _notificationsRepository.saveNotifications(newNotifications);
      if (result) {
        initializeNotifications(newNotifications, _homeBloc.state.sabbath!);
        emit(SetNotifications(newNotifications));
      }

      print('Set Notification');
    });
  }

  initializeNotifications(List<NotificationModel> notifications, Sabbath sabbath) async {
    // calculate notifications datetime ======================
    List<NotificationDetail> notificationDetails = [];

    final startDate = tz.TZDateTime.from(sabbath.startDateTime, tz.local);
    final endDate = tz.TZDateTime.from(sabbath.endDateTime, tz.local);

    for (var element in notifications) {
      if (element.isChecked) {
        // startDate notifications
        notificationDetails.add(
          NotificationDetail(
            element.id,
            startDate.subtract(Duration(minutes: element.minutes)),
            'Sabbath begins in ${element.minutes} minutes',
            'The sabbath starts at ${sabbath.startDateTime.toLocal().toString()}',
          ),
        );
        // endDate notifications
        notificationDetails.add(
          NotificationDetail(
            element.id * 24,
            endDate.subtract(Duration(minutes: element.minutes)),
            'Sabbath ends in ${element.minutes} minutes',
            'The sabbath ends at ${sabbath.endDateTime.toLocal().toString()}',
          ),
        );
      }
    }

    // check notifications queue =============================
    var pendingNotifications = await _notificationService.getPendingNotificationRequests();

    // notifications to add
    List<NotificationDetail> addNotifications = [];
    for (var noti in notificationDetails) {
      var result = pendingNotifications.indexWhere((element) => element.id == noti.id);
      if (result == -1) {
        addNotifications.add(noti);
      }
    }

    // notifications to remove
    List<int> removeNotificationIds = [];
    for (var noti in pendingNotifications) {
      var result = notificationDetails.indexWhere((element) => element.id == noti.id);
      if (result == -1) {
        removeNotificationIds.add(noti.id);
      }
    }

    // add/remove notifications ==============================
    for (var noti in addNotifications) {
      _notificationService.scheduleNotifications(noti.id, noti.dateTime, noti.title, noti.body);
    }

    for (var id in removeNotificationIds) {
      _notificationService.cancelNotifications(id);
    }

    // [DEBUG] print notifications
    print('Notifications========================');
    for (var noti in await _notificationService.getPendingNotificationRequests()) {
      print('notification => ' + noti.body!);
    }
  }
}

class NotificationDetail {
  int id;
  tz.TZDateTime dateTime;
  String title;
  String body;

  NotificationDetail(this.id, this.dateTime, this.title, this.body);
}
