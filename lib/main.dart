import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_saturdays/src/features/core/services/notification_service.dart';

import 'package:project_saturdays/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:project_saturdays/src/features/notifications/presentation/bloc/notifications_bloc.dart';
import 'package:project_saturdays/src/styles/colors.dart';
import 'package:project_saturdays/src/features/home/presentation/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().init();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final homeBloc = HomeBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => homeBloc,
        ),
        BlocProvider(
          create: (context) => NotificationsBloc(homeBloc),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Saturdays',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: kPrimaryColor,
            secondary: kPrimaryColor,
            background: kBackgroundColor,
          ),
          fontFamily: 'Inter',
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
