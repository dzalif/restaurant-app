import 'package:flutter/material.dart';

import '../common/navigation.dart';
import 'detail_restaurant_page.dart';


class CardRestaurant extends StatelessWidget {
  static const _baseUrlImage = 'https://restaurant-api.dicoding.dev/images/medium';
  final dynamic data;

  const CardRestaurant({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () {
          Navigation.intentWithData(DetailRestaurantPage.routeName, data.id);
        },
        child: Card(
          elevation: 4,
          child: Column(
            children: [
              Image.network('$_baseUrlImage/${data.pictureId}',
                width: MediaQuery.of(context).size.width),
              ListTile(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                title: Text(
                  data.name,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.city),
                    const SizedBox(height: 4),
                    Row(children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14,),
                      const SizedBox(width: 4),
                      Text(data.rating.toString(), style: const TextStyle(color: Colors.amber),)
                    ],)
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ),
      ),
    );
  }
}