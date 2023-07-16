import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/pages/detail_restaurant_page.dart';
import 'package:restaurant_app/pages/detail_review_page.dart';
import 'package:restaurant_app/pages/home_page.dart';
import 'package:restaurant_app/pages/search_page.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/provider/search_provider.dart';

import 'common/navigation.dart';

void main() {
  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchProvider(apiService: ApiService())),
        ChangeNotifierProvider(create: (_) => DetailRestaurantProvider(apiService: ApiService())),
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
              DetailRestaurantPage(id: ModalRoute.of(context)?.settings.arguments as String,),
          DetailReviewPage.routeName: (context) =>
              DetailReviewPage(reviews: ModalRoute.of(context)?.settings.arguments as dynamic,),
        },
      ),
    );
  }
}
