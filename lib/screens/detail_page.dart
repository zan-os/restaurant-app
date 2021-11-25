import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/screens/detail/description_page.dart';
import 'package:restaurant_app/screens/detail/menu_page.dart';
import 'package:restaurant_app/screens/detail/review_page.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/detail_page';

  final String id;
  const RestaurantDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.news),
          label: 'Restaurant',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.book),
          label: 'Menus',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.star),
          label: 'Review',
        ),
      ]),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return RestaurantDescriptionPage(
              id: id,
            );
          case 1:
            return RestaurantDrinkPage(
              id: id,
            );
          case 2:
            return RestaurantReviewPage(id: id);
          default:
            return Center(
              child: Text("Page Not Found"),
            );
        }
      },
    );
  }
}
