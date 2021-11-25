import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/screens/home/favorite_page.dart';
import 'package:restaurant_app/screens/home/restaurant_page.dart';
import 'package:restaurant_app/screens/home/search_page.dart';
import 'package:restaurant_app/screens/home/setting_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.placemark),
          label: 'Restaurant',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.square_favorites_alt),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.settings),
          label: 'Settings',
        ),
      ]),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return RestaurantPage();
          case 1:
            return SearchPage();
          case 2:
            return FavoriteRestaurant();
          case 3:
            return SettingsPage();
          default:
            return Center(
              child: Text("Page Not Found"),
            );
        }
      },
    );
  }
}
