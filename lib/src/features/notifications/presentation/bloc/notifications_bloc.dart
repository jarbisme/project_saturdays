import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_saturdays/src/features/notifications/domain/notification.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(NotificationsInitial()) {
    on<SetNotification>((event, emit) {
      // //  get notification object from state
      // var notification = state.notifications.firstWhere((element) => element.id == event.notification.id);
      // // get index of the notification
      // var index = state.notifications.indexOf(notification);

      // var notifications = [...state.notifications];
      // notifications[index] = event.notification;
      var newNotifications = [...state.notifications];
      newNotifications[event.notification.id - 1] = event.notification;

      emit(SetNotifications(newNotifications));

      print('Set Notification');
    });
  }
}
