import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/details.dart';

class MenuPage extends StatelessWidget {
  final RestaurantDetailElement restaurantDetail;
  const MenuPage({Key? key, required this.restaurantDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 40,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400)),
                child: Text(
                  "Foods",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: restaurantDetail.menus.foods.map((foods) {
                return Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Text(foods.name),
                );
              }).toList(),
            ),
            Container(
                height: 40,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400)),
                child: Text(
                  "Drinks",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: restaurantDetail.menus.drinks.map((drinks) {
                return Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Text(drinks.name),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
