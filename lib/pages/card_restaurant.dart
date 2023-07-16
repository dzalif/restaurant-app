import 'package:flutter/material.dart';

import '../data/model/list_restaurant_response.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant data;

  const CardRestaurant({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.black54)),
      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: data.pictureId,
          child: Image.network(
            'https://restaurant-api.dicoding.dev/images/medium/${data.pictureId}',
            width: 100,
          ),
        ),
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
        onTap: () {

        },
      ),
    );
  }
}