import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/pages/search_page.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

import '../common/navigation.dart';
import 'card_restaurant.dart';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _searchBar(),
            const SizedBox(height: 16),
            _buildList()
          ],
        ),
      ),
    );
  }

  _buildList() {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Expanded(
            child: Center(
                child: CircularProgressIndicator()),
          );
        } else if (state.state == ResultState.hasData) {
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.result.restaurants.length,
              itemBuilder: (context, index) {
                var data = state.result.restaurants[index];
                return CardRestaurant(data: data);
              },
            ),
          );
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text(''),
            ),
          );
        }
      },
    );
  }

  _searchBar() {
    return GestureDetector(
      onTap: () {
        Navigation.intent(SearchPage.routeName);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(color: Colors.grey[200], border: Border.all(color: Colors.black54), borderRadius: BorderRadius.circular(12)),
        child: Row(children: [
          Container(child: const Icon(Icons.search), padding: const EdgeInsets.symmetric(horizontal: 12.0)),
          const Expanded(child: TextField(enabled: false, decoration: InputDecoration(hintText: 'Search restaurant..', border: InputBorder.none),),)
        ],),
      ),
    );
  }
}
