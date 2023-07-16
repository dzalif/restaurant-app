import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/pages/home_page.dart';
import 'package:restaurant_app/pages/search_page.dart';
import 'package:restaurant_app/provider/search_provider.dart';

import 'common/navigation.dart';

void main() {
  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            ChangeNotifierProvider<SearchProvider>(
                create: (context) => SearchProvider(apiService: ApiService()),
                child: const SearchPage()),
      },
    );
  }
}
