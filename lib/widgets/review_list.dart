import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/details.dart';

class ReviewList extends StatelessWidget {
  final RestaurantDetailElement restaurantDetail;
  const ReviewList({Key? key, required this.restaurantDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: restaurantDetail.customerReviews.map((review) {
            return Padding(
              padding: EdgeInsets.all(14.0),
              child: Container(
                decoration: BoxDecoration(
                    color: CupertinoColors.lightBackgroundGray,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.review,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Divider(
                        color: CupertinoColors.inactiveGray,
                      ),
                      Text(review.name),
                      Text(review.date)
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
