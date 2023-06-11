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
          NotificationModel(minutes: 15, isChecked: false),
          NotificationModel(minutes: 30, isChecked: false),
          NotificationModel(minutes: 60, isChecked: false),
          NotificationModel(minutes: 90, isChecked: false),
        ]);
}
