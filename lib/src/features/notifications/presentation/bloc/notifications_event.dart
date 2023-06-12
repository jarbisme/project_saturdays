part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class SetNotification extends NotificationsEvent {
  final NotificationModel notification;

  const SetNotification(this.notification);

  @override
  List<Object> get props => [notification];
}
