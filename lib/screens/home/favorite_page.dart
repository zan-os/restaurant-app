import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/widgets/card_list.dart';

class FavoriteRestaurant extends StatefulWidget {
  const FavoriteRestaurant({Key? key}) : super(key: key);

  @override
  State<FavoriteRestaurant> createState() => _FavoriteRestaurantState();
}

class _FavoriteRestaurantState extends State<FavoriteRestaurant> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Favorite'),
        ),
        child: _buildList());
  }

  Widget _buildList() {
    return ChangeNotifierProvider(
      create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
      child: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          if (provider.state == StateDatabase.loading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text('Please Wait'),
                ],
              ),
            );
          } else if (provider.state == StateDatabase.hasData) {
            return ListView.builder(
              itemCount: provider.favorites.length,
              itemBuilder: (context, index) {
                return CardList(restaurant: provider.favorites[index]);
              },
            );
          } else if (provider.state == StateDatabase.noData) {
            return Center(
              child: Text(provider.message),
            );
          } else if (provider.state == StateDatabase.error) {
            return Builder(
              builder: (context) {
                if (provider.message.contains("SocketException")) {
                  return Center(
                    child: Text("No Internet"),
                  );
                } else {
                  return Center(
                    child: Text(provider.message),
                  );
                }
              },
            );
          } else {
            return Center(
              child: Text(''),
            );
          }
        },
      ),
    );
  }
}
