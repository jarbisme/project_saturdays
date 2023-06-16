import 'package:equatable/equatable.dart';

enum NotificationTime { m15, m30, m60, m90m }

class NotificationModel {
  int id;
  bool isChecked;
  int minutes;

  NotificationModel({required this.id, required this.minutes, required this.isChecked});

  NotificationModel copyWith({int? id, bool? isChecked, int? minutes}) {
    return NotificationModel(
      id: id ?? this.id,
      isChecked: isChecked ?? this.isChecked,
      minutes: minutes ?? this.minutes,
    );
  }

  toJSONEncodable() {
    Map<String, dynamic> n = Map();

    n['id'] = id;
    n['isChecked'] = isChecked;
    n['minutes'] = minutes;

    return n;
  }
}

class NotificationList {
  final List<NotificationModel> notifications;

  NotificationList({required this.notifications});

  toJSONEncodable() {
    return notifications.map((n) {
      return n.toJSONEncodable();
    }).toList();
  }
}
