import 'dart:convert';

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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'minutes': minutes,
      'isChecked': isChecked,
    };
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      isChecked: json['isChecked'],
      minutes: json['minutes'],
    );
  }
}

class NotificationList {
  final List<NotificationModel> notifications;

  NotificationList({required this.notifications});

  String toJsonString() {
    final List<Map<String, dynamic>> jsonList = notifications.map((n) => n.toJson()).toList();
    return jsonEncode(jsonList);
  }

  factory NotificationList.fromJsonString(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    final List<NotificationModel> notifications = jsonList.map((json) => NotificationModel.fromJson(json)).toList();
    return NotificationList(notifications: notifications);
  }
}
