import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_favorite_provider.dart';

import 'card_restaurant.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildList()
          ],
        ),
      ),
    );
  }

  _buildList() {
    return Consumer<RestaurantFavoriteProvider>(
      builder: (context, state, _) {
        if (state.state == ResultFavoriteState.loading) {
          return const Expanded(
            child: Center(
                child: CircularProgressIndicator()),
          );
        } else if (state.state == ResultFavoriteState.hasData) {
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.result.length,
              itemBuilder: (context, index) {
                var data = state.result[index];
                return CardRestaurant(data: data);
              },
            ),
          );
        } else if (state.state == ResultFavoriteState.noData) {
          return Expanded(
            child: Center(
              child: Material(
                child: Text(state.message),
              ),
            ),
          );
        } else if (state.state == ResultFavoriteState.error) {
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
