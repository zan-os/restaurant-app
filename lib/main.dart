import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/screens/detail_page.dart';
import 'package:restaurant_app/screens/home_page.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await _notificationHelper.initNotification(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
          primaryColor: CupertinoColors.activeBlue,
          scaffoldBackgroundColor: greyBackground),
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/logo.png'),
        nextScreen: HomePage(),
        splashTransition: SplashTransition.rotationTransition,
      ),
      routes: {
        '/home_page': (context) => HomePage(),
        '/detail_page': (context) => RestaurantDetailPage(
              id: ModalRoute.of(context)?.settings.arguments as String,
            )
      },
    );
  }
}
