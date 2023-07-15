import 'package:flutter/material.dart';
import 'package:restaurant_app/components/bottom_nav_bar.dart';
import 'package:restaurant_app/pages/restaurant_page.dart';

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
    const RestaurantPage(),
    const FavoritePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[300],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo[300], elevation: 0, actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: const [
                Icon(Icons.settings),
                SizedBox(width: 4,),
                Text('Settings')
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
