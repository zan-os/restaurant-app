import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/provider/database_provider.dart';

class CardList extends StatefulWidget {
  final RestaurantElement restaurant;
  const CardList({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  @override
  Widget build(BuildContext context) {
    final imageUrl = "https://restaurant-api.dicoding.dev/images/medium/" +
        widget.restaurant.pictureId;
    return ChangeNotifierProvider(
      create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
      child: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          return FutureBuilder<bool>(
              future: provider.isFavorited(widget.restaurant.id),
              builder: (context, snapshot) {
                var isFavorited = snapshot.data ?? false;
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/detail_page',
                        arguments: widget.restaurant.id);
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.restaurant.name,
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 5.0),
                                        Text(widget.restaurant.city)
                                      ],
                                    ),
                                    isFavorited
                                        ? CupertinoButton(
                                            onPressed: () => setState(() {
                                              provider.removeFavorite(
                                                  widget.restaurant.id);
                                            }),
                                            child: Icon(
                                              CupertinoIcons.heart_solid,
                                              color: CupertinoColors.systemRed,
                                              size: 36.0,
                                            ),
                                          )
                                        : CupertinoButton(
                                            onPressed: () => setState(() {
                                              provider.addFavorite(
                                                  widget.restaurant);
                                            }),
                                            child: Icon(
                                                CupertinoIcons.heart_solid,
                                                color: CupertinoColors
                                                    .inactiveGray,
                                                size: 36.0),
                                          )
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.0)
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 70.0,
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
                                  widget.restaurant.rating.toString(),
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
              });
        },
      ),
    );
  }
}
