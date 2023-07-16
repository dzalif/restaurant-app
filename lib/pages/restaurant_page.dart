import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

import 'card_restaurant.dart';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildList(),
    );
  }

  _buildList() {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator(color: Colors.white,));
        } else if (state.state == ResultState.hasData) {
          return Container(
            padding: const EdgeInsets.all(16),
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
}

