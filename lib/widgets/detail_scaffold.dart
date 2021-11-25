import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_app/data/models/details.dart';

class DetailScaffold extends StatelessWidget {
  final RestaurantDetailElement restaurantDetail;
  const DetailScaffold({Key? key, required this.restaurantDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cupertinoTheme = CupertinoTheme.of(context);
    final imageUrl = "https://restaurant-api.dicoding.dev/images/medium/" +
        restaurantDetail.pictureId;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24),
                  Text(restaurantDetail.name,
                      style: cupertinoTheme.textTheme.navLargeTitleTextStyle),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.location_solid,
                        color: CupertinoColors.label,
                      ),
                      Text(
                        "${restaurantDetail.address}, ${restaurantDetail.city}",
                        style: cupertinoTheme.textTheme.navTitleTextStyle,
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Row(
                      children: restaurantDetail.categories
                          .map((category) => Container(
                              padding: const EdgeInsets.all(3),
                              margin: const EdgeInsets.only(right: 8.0),
                              decoration:
                                  BoxDecoration(color: Colors.blue.shade100),
                              child: Text(
                                category.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: CupertinoColors.activeBlue),
                              )))
                          .toList()),
                  SizedBox(height: 24),
                  Text(
                    "Rating",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Column(
                      children: [
                        RatingBar.builder(
                          initialRating: restaurantDetail.rating,
                          minRating: restaurantDetail.rating,
                          maxRating: restaurantDetail.rating,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            CupertinoIcons.star_fill,
                            color: CupertinoColors.activeBlue,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        SizedBox(height: 10),
                        Text(
                          "${restaurantDetail.rating}/5",
                          style: cupertinoTheme.textTheme.actionTextStyle,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Description",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    restaurantDetail.description,
                    style: cupertinoTheme.textTheme.textStyle,
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
