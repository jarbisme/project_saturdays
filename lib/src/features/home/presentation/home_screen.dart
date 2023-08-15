import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:project_saturdays/src/features/home/presentation/bloc/bloc/home_bloc.dart';
import 'package:project_saturdays/src/features/notifications/presentation/bloc/notifications_bloc.dart';
import 'package:project_saturdays/src/features/notifications/presentation/notifications_screen.dart';
import 'package:project_saturdays/src/styles/colors.dart';
import 'package:project_saturdays/src/features/home/presentation/widgets/globe.dart';
import 'package:project_saturdays/src/features/home/presentation/widgets/saturday_details.dart';
import 'package:project_saturdays/src/features/home/presentation/widgets/title_widget.dart';

import 'widgets/notification_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeBloc>(context).add(InitializeHome());
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.sabbath != null) {
          BlocProvider.of<NotificationsBloc>(context).add(InitializeNotifications());
        }
        return Scaffold(
          backgroundColor: state.isSaturday ? kPrimaryColor : kBackgroundColor,
          body: state.sabbath != null
              ? Stack(
                  children: [
                    Positioned(
                      right: 30,
                      bottom: 30,
                      child: NotificationButton(
                        isSaturday: state.isSaturday,
                      ),
                    ),
                    SafeArea(
                      bottom: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DayTitle(),
                                Globe(),
                              ],
                            ),
                          ),
                          SaturdayDetails(
                            sabbath: state.sabbath!,
                            isSaturday: state.isSaturday,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
