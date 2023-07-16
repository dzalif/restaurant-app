import 'package:flutter/material.dart';

import '../data/model/detail_restaurant_response.dart';

class DetailReviewPage extends StatefulWidget {
  static const routeName = '/detail_review';

  final List<CustomerReview> reviews;

  const DetailReviewPage({Key? key, required this.reviews}) : super(key: key);

  @override
  State<DetailReviewPage> createState() => _DetailReviewPageState();
}

class _DetailReviewPageState extends State<DetailReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Reviews', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.reviews.length,
                itemBuilder: (context, index) {
                  var data = widget.reviews[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0, bottom: 16),
                    child: Card(child: ListTile(
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
                    ),),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
