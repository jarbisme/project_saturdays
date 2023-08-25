import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:project_saturdays/src/features/home/presentation/bloc/bloc/home_bloc.dart';
import 'package:project_saturdays/src/features/notifications/presentation/bloc/notifications_bloc.dart';
import 'package:project_saturdays/src/styles/colors.dart';
import 'package:project_saturdays/src/features/home/presentation/widgets/globe.dart';
import 'package:project_saturdays/src/features/home/presentation/widgets/saturday_details.dart';
import 'package:project_saturdays/src/features/home/presentation/widgets/title_widget.dart';

import 'widgets/no_connection_banner.dart';
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
          body: LiquidPullToRefresh(
            showChildOpacityTransition: false,
            springAnimationDurationInMilliseconds: 700,
            animSpeedFactor: 4,
            height: 120,
            onRefresh: () async {
              BlocProvider.of<HomeBloc>(context).add(RefreshHome());
            },
            child: ScrollConfiguration(
              behavior: MyBehavior(), // Remove GlowingOverscrollIndicator
              child: SingleChildScrollView(
                physics: state.sabbath != null
                    ? const AlwaysScrollableScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 1,
                  child: state.sabbath != null
                      ? Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomRight,
                              // right: 30,
                              // bottom: 30,
                              child: NotificationButton(
                                isSaturday: state.isSaturday,
                              ),
                            ),
                            SafeArea(
                              bottom: true,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        NoConnectionBanner(),
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
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
