import 'package:equatable/equatable.dart';

enum NotificationTime { m15, m30, m60, m90m }

class NotificationModel {
  int id;
  bool isChecked;
  int minutes;

  NotificationModel({required this.id, required this.minutes, required this.isChecked});

  @override
  List<Object?> get props => [];

  NotificationModel copyWith({int? id, bool? isChecked, int? minutes}) {
    return NotificationModel(
      id: id ?? this.id,
      isChecked: isChecked ?? this.isChecked,
      minutes: minutes ?? this.minutes,
    );
  }
}
