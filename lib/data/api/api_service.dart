import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/list_restaurant_response.dart';
import 'package:restaurant_app/data/model/review/add_review_request.dart';
import 'package:restaurant_app/data/model/search_restaurant_response.dart';

import '../model/detail_restaurant_response.dart';
import '../model/review/add_review_response.dart';

class ApiService {
  final http.Client? client;

  ApiService(this.client);

  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<ListRestaurantResponse> getListRestaurant() async {
    final response = await client!.get(Uri.parse("$_baseUrl/list"));
    if (response.statusCode == 200) {
      return ListRestaurantResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant');
    }
  }

  Future<SearchRestaurantResponse> searchRestaurant(String? query) async {
    final response = await client!.get(Uri.parse("$_baseUrl/search?q=$query"));
    if (response.statusCode == 200) {
      return SearchRestaurantResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant');
    }
  }

  Future<DetailRestaurantResponse> getDetailRestaurant(String? id) async {
    final response = await client!.get(Uri.parse("$_baseUrl/detail/$id"));
    if (response.statusCode == 200) {
      return DetailRestaurantResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant');
    }
  }

  Future<AddReviewResponse> addReview(AddReviewRequest request) async {
    final response = await client!.post(Uri.parse("$_baseUrl/review"), body: request.toJson());
    if (response.statusCode == 200) {
      return AddReviewResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post review');
    }
  }
}