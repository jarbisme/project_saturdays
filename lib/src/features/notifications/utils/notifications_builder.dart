import 'package:project_saturdays/src/features/notifications/domain/notification.dart';

class NotificationsBuilder {
  static List<NotificationModel> buildNoficiations() {
    return [
      NotificationModel(id: 1, minutes: 15, isChecked: false),
      NotificationModel(id: 2, minutes: 30, isChecked: false),
      NotificationModel(id: 3, minutes: 60, isChecked: false),
      NotificationModel(id: 4, minutes: 90, isChecked: false),
    ];
  }
}
