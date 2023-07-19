import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/detail_restaurant_response.dart';
import 'package:restaurant_app/pages/detail_review_page.dart';
import 'package:restaurant_app/provider/add_restaurant_favorite_provider.dart';
import 'package:restaurant_app/provider/detail_restaurant_favorite_provider.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';

import '../common/navigation.dart';
import '../db/app_database.dart';

class DetailRestaurantPage extends StatefulWidget {
  static const routeName = '/detail_restaurant';

  final String? id;

  const DetailRestaurantPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailRestaurantPage> createState() => _DetailRestaurantPageState();
}

class _DetailRestaurantPageState extends State<DetailRestaurantPage> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DetailRestaurantProvider>(context, listen: false)
          .fetchDetailRestaurant(widget.id);

      Provider.of<DetailRestaurantFavoriteProvider>(context, listen: false)
          .getDetailRestaurantFavorite(widget.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<DetailRestaurantFavoriteProvider>(
          builder: (context, state, _) {
            // Check isFavorite null atau tidak
            if (state.result?.isFavorite != null) {
              _isFavorite = state.result!.isFavorite;
            }

            return FloatingActionButton(
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
                _addToFavorite();
                _showSnackBar();
              },
              child: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border_outlined),
            );
          },
        ),
      ),
      body: Consumer<DetailRestaurantProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: false,
                  expandedHeight: 300,
                  flexibleSpace: FlexibleSpaceBar(
                    title: const Text(''),
                    background: Image.network(
                      'https://restaurant-api.dicoding.dev/images/medium/${state.result?.restaurant.pictureId}',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.result!.restaurant.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                              '${state.result!.restaurant.city}, ${state.result!.restaurant.address}'),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                state.result!.restaurant.rating.toString(),
                                style: const TextStyle(color: Colors.amber),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(state.result!.restaurant.description),
                          const SizedBox(height: 16),
                          const Text(
                            'Kategori',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          _buildCategories(state.result!.restaurant.categories),
                          const Text(
                            'Menu',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          _buildFoodMenus(state.result!.restaurant.menus),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Reviews',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigation.intentWithData(
                                      DetailReviewPage.routeName,
                                      state.result!.restaurant.customerReviews);
                                },
                                child: const Row(
                                  children: [
                                    Text(
                                      'See All',
                                      style: TextStyle(color: Colors.amber),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.amber,
                                      size: 14,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          _buildReviews(
                              state.result!.restaurant.customerReviews),
                        ],
                      ),
                    ),
                  ),
                )
              ],
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
      ),
    );
  }

  _buildCategories(List<Category> categories) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          var data = categories[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Chip(label: Text(data.name)),
          );
        },
      ),
    );
  }

  _buildFoodMenus(Menus menus) {
    return Column(
      children: [
        _buildFoods(menus.foods),
        const SizedBox(height: 8),
        _buildDrinks(menus.drinks)
      ],
    );
  }

  _buildFoods(List<Category> foods) {
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: foods.length,
            itemBuilder: (context, index) {
              var data = foods[index];
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Chip(label: Text(data.name)),
              );
            },
          ),
        ),
      ],
    );
  }

  _buildDrinks(List<Category> drinks) {
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: drinks.length,
            itemBuilder: (context, index) {
              var data = drinks[index];
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Chip(label: Text(data.name)),
              );
            },
          ),
        ),
      ],
    );
  }

  _buildReviews(List<CustomerReview> customerReviews) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: customerReviews.length < 3 ? customerReviews.length : 3,
            itemBuilder: (context, index) {
              var data = customerReviews[index];
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Card(
                  child: SizedBox(
                    width: 200,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      title: Text(
                        data.name,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.date),
                          const SizedBox(height: 4),
                          Text(data.review),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showSnackBar() {
    var snackBar = SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(_isFavorite
          ? 'Berhasil menambahkan ke favorite!'
          : 'Berhasil hapus dari favorite!'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _addToFavorite() {
    DetailRestaurant? restaurant =
        Provider.of<DetailRestaurantProvider>(context, listen: false).result?.restaurant;

    final RestaurantTableData data = RestaurantTableData(
        id: restaurant!.id,
        name: restaurant.name,
        description: restaurant.description,
        pictureId: restaurant.pictureId,
        city: restaurant.city,
        rating: restaurant.rating,
        isFavorite: _isFavorite);

    Provider.of<AddRestaurantFavoriteProvider>(context, listen: false)
        .addRestaurantToFavorite(data);
  }
}
