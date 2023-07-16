import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/search_provider.dart';

import '../utils/debouncer.dart';
import 'card_restaurant.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _debouncer = Debouncer(500);

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return Scaffold(
      body: Container(padding: const EdgeInsets.only(top: kBottomNavigationBarHeight, left: 16, right: 16), child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        const Text('Search Restaurant', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        const SizedBox(height: 16),
        _searchBar(searchProvider),
        const SizedBox(height: 8),
        _buildList()
      ],)),
    );
  }

  _buildList() {
    return Consumer<SearchProvider>(
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
          return Expanded(
            child: Center(
              child: Material(
                child: Text(state.message),
              ),
            ),
          );
        } else if (state.state == ResultState.error) {
          return Expanded(
            child: Center(
              child: Material(
                child: Text(state.message),
              ),
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

  _searchBar(SearchProvider searchProvider) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(color: Colors.grey[200], border: Border.all(color: Colors.black54), borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        Container(child: const Icon(Icons.search), padding: const EdgeInsets.symmetric(horizontal: 12.0)),
        Expanded(child: TextField(
          cursorColor: Colors.black54, onChanged: (value) {
            _debouncer.run(() {
              searchProvider.setSearchQuery(value);
            });
        },decoration: const InputDecoration(hintText: 'Search restaurant..', border: InputBorder.none),),)
      ],),
    );
  }
}
