import 'package:localstorage/localstorage.dart';
import 'package:project_saturdays/src/features/notifications/domain/notification.dart';
import 'package:project_saturdays/src/features/notifications/utils/notifications_builder.dart';

class NotificationsLocalDataSource {
  final LocalStorage storage = LocalStorage('notifications');

  NotificationsLocalDataSource() {}

  Future<List<NotificationModel>?> getNotifications() async {
    var notifications = storage.getItem('notifications');

    // check is there are notificiations saved
    if (notifications != null) {
      return List<NotificationModel>.from(
        (notifications as List).map(
          (n) => NotificationModel(
            id: n['id'],
            minutes: n['minutes'],
            isChecked: n['isChecked'],
          ),
        ),
      );
    } else {
      // if there are not notifications yet, insert them
      notifications = NotificationsBuilder.buildNoficiations();

      saveNotifications(NotificationList(notifications: notifications));
      return notifications;
    }
  }

  Future<void> saveNotifications(NotificationList notifications) async {
    await storage.setItem('notifications', notifications.toJSONEncodable());
  }
}
