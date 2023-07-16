import 'dart:async';
import 'package:flutter/material.dart';

import '../data/api/api_service.dart';
import '../data/model/search_restaurant_response.dart';

enum ResultState { loading, noData, hasData, error }

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchProvider({required this.apiService}) {
    _searchRestaurant(null);
  }

  late SearchRestaurantResponse _restaurantResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  SearchRestaurantResponse get result => _restaurantResult;

  ResultState get state => _state;

  void setSearchQuery(String query) {
    _searchRestaurant(query);
    notifyListeners();
  }

  Future<dynamic> _searchRestaurant(String? query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final data = await apiService.searchRestaurant(query);
      if (data.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = data;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'There is unknown error';
    }
  }
}
