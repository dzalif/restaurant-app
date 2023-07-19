import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/bottom_nav_bar.dart';
import 'package:restaurant_app/db/app_database.dart';
import 'package:restaurant_app/pages/restaurant_page.dart';
import 'package:restaurant_app/provider/restaurant_favorite_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

import '../data/api/api_service.dart';
import 'favorite_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  //pages to display
  final List<Widget> _pages = [
    ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(apiService: ApiService()),
      child: const RestaurantPage(),
    ),
    ChangeNotifierProvider<RestaurantFavoriteProvider>(
      create: (_) => RestaurantFavoriteProvider(appDatabase: AppDatabase()),
        child: const FavoritePage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[50], elevation: 0, actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Row(
              children: [
                Icon(Icons.settings, color: Colors.black54,),
                SizedBox(width: 4,),
                Text('Settings', style: TextStyle(color: Colors.black54),)
              ],
            ),
          )
      ],),
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      body: _pages[_selectedIndex],
    );
  }

  navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
