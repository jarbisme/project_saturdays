import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_saturdays/src/features/notifications/data/repositories/notifications_repository.dart';
import 'package:project_saturdays/src/features/notifications/domain/notification.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final _notificationsRepository = NotificationsRepository();

  NotificationsBloc() : super(NotificationsInitial()) {
    on<InitializeNotifications>((event, emit) async {
      var notifications = await _notificationsRepository.getNotifications();

      if (notifications != null) {
        emit(SetNotifications(notifications));
      }
    });
    on<SetNotification>((event, emit) async {
      // * get notification object from state
      // var notification = state.notifications.firstWhere((element) => element.id == event.notification.id);
      // * get index of the notification
      // var index = state.notifications.indexOf(notification);

      // var notifications = [...state.notifications];
      // notifications[index] = event.notification;
      var newNotifications = [...state.notifications];
      newNotifications[event.notification.id - 1] = event.notification;

      var result = await _notificationsRepository.saveNotifications(newNotifications);
      if (result) {
        emit(SetNotifications(newNotifications));
      }

      print('Set Notification');
    });
  }
}
