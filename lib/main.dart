import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/db/app_database.dart';
import 'package:restaurant_app/pages/detail_restaurant_page.dart';
import 'package:restaurant_app/pages/detail_review_page.dart';
import 'package:restaurant_app/pages/home_page.dart';
import 'package:restaurant_app/pages/search_page.dart';
import 'package:restaurant_app/pages/settings_page.dart';
import 'package:restaurant_app/provider/add_restaurant_favorite_provider.dart';
import 'package:restaurant_app/provider/detail_restaurant_favorite_provider.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/provider/remove_restaurant_favorite_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:restaurant_app/utils/scheduling_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/navigation.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appDatabase = InitDatabase.database;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchProvider(apiService: ApiService())),
        ChangeNotifierProvider(create: (_) => DetailRestaurantProvider(apiService: ApiService())),
        ChangeNotifierProvider(create: (_) => RestaurantProvider(apiService: ApiService())),
        ChangeNotifierProvider(create: (_) => AddRestaurantFavoriteProvider(appDatabase: appDatabase!)),
        ChangeNotifierProvider(create: (_) => RemoveRestaurantFavoriteProvider(appDatabase: appDatabase!)),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: const Color.fromRGBO(255, 203, 133, 1.0),
            progressIndicatorTheme:
                const ProgressIndicatorThemeData(color: Colors.black54)),
        routes: {
          SearchPage.routeName: (context) =>
              const SearchPage(),
          DetailRestaurantPage.routeName: (context) =>
              ChangeNotifierProvider(
                create: (_) => DetailRestaurantFavoriteProvider(appDatabase: appDatabase!),
                  child: DetailRestaurantPage(id: ModalRoute.of(context)?.settings.arguments as String,)),
          DetailReviewPage.routeName: (context) =>
              DetailReviewPage(reviews: ModalRoute.of(context)?.settings.arguments as dynamic,),
          SettingsPage.routeName: (context) =>
              const SettingsPage(),
        },
      ),
    );
  }
}
