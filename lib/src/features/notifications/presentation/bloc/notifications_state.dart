part of 'notifications_bloc.dart';

abstract class NotificationsState extends Equatable {
  final List<NotificationModel> notifications;

  const NotificationsState({required this.notifications});

  @override
  List<Object> get props => [notifications];
}

class NotificationsInitial extends NotificationsState {
  NotificationsInitial()
      : super(notifications: [
          NotificationModel(id: 1, minutes: 15, isChecked: false),
          NotificationModel(id: 2, minutes: 30, isChecked: false),
          NotificationModel(id: 3, minutes: 60, isChecked: false),
          NotificationModel(id: 4, minutes: 90, isChecked: false),
        ]);
}

class SetNotifications extends NotificationsState {
  const SetNotifications(List<NotificationModel> newNotifications) : super(notifications: newNotifications);
}
