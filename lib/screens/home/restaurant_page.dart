import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/list_provider.dart';
import 'package:restaurant_app/widgets/card_list.dart';

class RestaurantPage extends StatelessWidget {
  static const routeName = '/restaurant_page';
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          middle: Text("Restaurant Page"), automaticallyImplyLeading: false),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 16.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Restaurant",
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .navLargeTitleTextStyle,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Recomended restaurant for you!",
                      style: CupertinoTheme.of(context).textTheme.textStyle,
                    ),
                    SizedBox(height: 8),
                  ],
                )
              ],
            ),
            Expanded(child: Container(child: _buildRestaurantItem())),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantItem() {
    return ChangeNotifierProvider(
      create: (_) => ListProvider(apiService: ApiService()),
      child: Consumer<ListProvider>(
        builder: (context, state, _) {
          if (state.searchState == StateList.loading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator(), Text("Please wait")],
              ),
            );
          } else if (state.searchState == StateList.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.searchResult!.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = state.searchResult!.restaurants[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CardList(
                    restaurant: restaurant,
                  ),
                );
              },
            );
          } else if (state.searchState == StateList.noData) {
            return Center(
              child: Text('${state.message}'),
            );
          } else if (state.searchState == StateList.error) {
            return Builder(
              builder: (context) {
                if (state.message.contains("SocketException")) {
                  return Center(
                    child: Text("No Internet"),
                  );
                } else {
                  return Center(
                    child: Text(state.message),
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
