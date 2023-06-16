import 'package:project_saturdays/src/features/notifications/data/data_sources/notifications_local_data_source.dart';
import 'package:project_saturdays/src/features/notifications/data/data_sources/notifications_sharedPreferences_data_source.dart';
import 'package:project_saturdays/src/features/notifications/domain/notification.dart';

class NotificationsRepository {
  final notificationsLocalDataSource = NotificationsSharedPreferencesDataSource();

  Future<List<NotificationModel>?> getNotifications() async {
    try {
      var notifications = await notificationsLocalDataSource.getNotifications();

      return notifications;
    } catch (e) {
      throw Exception('An error ocurred: $e');
    }
  }

  Future<bool> saveNotifications(List<NotificationModel> notifications) async {
    try {
      await notificationsLocalDataSource.saveNotifications(NotificationList(notifications: notifications));
      return true;
    } catch (e) {
      throw Exception('An error ocurred: $e');
    }
  }
}
