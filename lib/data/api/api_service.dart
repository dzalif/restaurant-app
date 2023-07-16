import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/list_restaurant_response.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<ListRestaurantResponse> getListRestaurant() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));
    print('Response status code : ${response.statusCode}');
    if (response.statusCode == 200) {
      print('Response body : ${response.body}');
      return ListRestaurantResponse.fromJson(json.decode(response.body));
    } else {
      print('Errornya ya');
      throw Exception('Failed to load restaurant');
    }
  }
}