import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/detail_restaurant_response.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';

class DetailRestaurantPage extends StatefulWidget {
  static const routeName = '/detail_restaurant';

  final String? id;

  const DetailRestaurantPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailRestaurantPage> createState() => _DetailRestaurantPageState();
}

class _DetailRestaurantPageState extends State<DetailRestaurantPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DetailRestaurantProvider>(context, listen: false)
          .fetchDetailRestaurant(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          Text('${state.result!.restaurant.city}, ${state.result!.restaurant.address}'),
                          Row(children: [
                            const Icon(Icons.star, color: Colors.amber, size: 14,),
                            const SizedBox(width: 4),
                            Text(state.result!.restaurant.rating.toString(), style: const TextStyle(color: Colors.amber),)
                          ],),
                          const SizedBox(height: 8),
                          Text(state.result!.restaurant.description),
                          const SizedBox(height: 16),
                          const Text('Kategori', style: TextStyle(fontWeight: FontWeight.bold),),
                          _buildCategories(state.result!.restaurant.categories),
                          const Text('Menu', style: TextStyle(fontWeight: FontWeight.bold),),
                          _buildFoodMenus(state.result!.restaurant.menus),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            const Text('Reviews', style: TextStyle(fontWeight: FontWeight.bold),),
                            Row(
                              children: const [
                                Text('See All', style: TextStyle(color: Colors.amber),),
                                Icon(Icons.arrow_forward, color: Colors.amber, size: 14,)
                              ],
                            )
                          ],),
                          const SizedBox(height: 8),
                          _buildReviews(state.result!.restaurant.customerReviews),
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
            itemCount: 5,
            itemBuilder: (context, index) {
              var data = customerReviews[index];
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Card(child: Container(
                  width: 200,
                  child: ListTile(
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                ),),
              );
            },
          ),
        ),
      ],
    );
  }
}
