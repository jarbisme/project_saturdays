import 'package:project_saturdays/src/features/notifications/utils/notifications_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/notification.dart';

class NotificationsSharedPreferencesDataSource {
  Future<List<NotificationModel>?> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();

    List<NotificationModel> notifications;
    notifications = NotificationsBuilder.buildNoficiations();
    return notifications.map((element) {
      var isChecked = prefs.getBool(element.id.toString()) ?? false;
      element.isChecked = isChecked;
      return element;
    }).toList();
  }

  Future<void> saveNotifications(NotificationList notifications) async {
    final prefs = await SharedPreferences.getInstance();

    notifications.notifications.forEach((element) {
      prefs.setBool(element.id.toString(), element.isChecked);
    });
  }
}
