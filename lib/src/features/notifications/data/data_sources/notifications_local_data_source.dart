import 'package:localstorage/localstorage.dart';
import 'package:project_saturdays/src/features/notifications/domain/notification.dart';
import 'package:project_saturdays/src/features/notifications/utils/notifications_builder.dart';

class NotificationsLocalDataSource {
  // final LocalStorage storage = LocalStorage('notifications');

  NotificationsLocalDataSource() {}

  Future<List<NotificationModel>?> getNotifications() async {
    var notificationsData = localStorage.getItem('notifications');

    // check is there are notificiations saved
    if (notificationsData != null) {
      return List<NotificationModel>.from(
        (notificationsData as List).map(
          (n) => NotificationModel(
            id: n['id'],
            minutes: n['minutes'],
            isChecked: n['isChecked'],
          ),
        ),
      );
    } else {
      // if there are not notifications yet, insert them
      final defaultNotifications = NotificationsBuilder.buildNoficiations();

      saveNotifications(NotificationList(notifications: defaultNotifications));
      return defaultNotifications;
    }
  }

  Future<void> saveNotifications(NotificationList notifications) async {
    localStorage.setItem('notifications', notifications.toJsonString());
  }
}
