import 'dart:convert';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:rxdart/subjects.dart';

final selectNotificationSubject = BehaviorSubject<String>();

int randomId = Random().nextInt(20);

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper.internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper.internal();

  Future<void> initNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingAndroid = AndroidInitializationSettings('logo');

    var initializationSettings =
        InitializationSettings(android: initializationSettingAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantList restaurantList) async {
    var _channelId = '1';
    var _channelName = 'channel_01';
    var _channelDescription = 'restaurant new_channel';

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    int randomId = Random().nextInt(restaurantList.restaurants.length);
    var titleNotification = restaurantList.restaurants[randomId].name;
    var titleNews = "Recomended restaurant for you";

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleNews, platformChannelSpecifics,
        payload: json.encode(restaurantList.toJson()));
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = RestaurantList.fromJson(json.decode(payload));
        var article = data.restaurants[0];
        Navigation.intentWithData(route, article);
      },
    );
  }
}
