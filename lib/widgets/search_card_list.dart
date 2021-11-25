import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/search.dart';

class SearchList extends StatelessWidget {
  final RestaurantSearchElement restaurantSearch;
  const SearchList({Key? key, required this.restaurantSearch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl = "https://restaurant-api.dicoding.dev/images/medium/" +
        restaurantSearch.pictureId;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail_page',
            arguments: restaurantSearch.id);
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: CupertinoColors.inactiveGray,
                  spreadRadius: 2,
                  blurRadius: 1,
                  offset: Offset(2, 3)),
            ],
            borderRadius: BorderRadius.circular(8),
            color: CupertinoColors.white,
            border: Border.all(color: CupertinoColors.systemGrey3)),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7),
                          topRight: Radius.circular(7)),
                      child: Image.network(imageUrl)),
                  SizedBox(height: 15.0),
                  Row(
                    children: [
                      SizedBox(width: 15.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurantSearch.name,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5.0),
                          Text(restaurantSearch.city)
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0)
                ],
              ),
            ),
            Positioned(
              bottom: 50.0,
              right: 40.0,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: CupertinoColors.white),
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.star_fill, size: 22),
                    SizedBox(width: 3),
                    Text(
                      restaurantSearch.rating.toString(),
                      style: TextStyle(fontSize: 24),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
