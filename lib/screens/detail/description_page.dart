import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/detail_provider.dart';
import 'package:restaurant_app/widgets/detail_scaffold.dart';

class RestaurantDescriptionPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final String id;
  const RestaurantDescriptionPage({Key? key, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Detail"),
        ),
        child: _buildRestaurantDetails());
  }

  Widget _buildRestaurantDetails() {
    return ChangeNotifierProvider<DetailProvider>(
      create: (_) => DetailProvider(apiService: ApiService(), id: id),
      child: Consumer<DetailProvider>(
        builder: (context, state, _) {
          if (state.detailState == StateDetail.loading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text("Please wait"),
                ],
              ),
            );
          } else if (state.detailState == StateDetail.hasData) {
            return DetailScaffold(
                restaurantDetail: state.resultState!.restaurant);
          } else if (state.detailState == StateDetail.noData) {
            return Center(
              child: Text(state.message),
            );
          } else if (state.detailState == StateDetail.error) {
            return Builder(builder: (context) {
              if (state.message.contains("SocketException")) {
                return Center(
                  child: Text("No Internet"),
                );
              } else {
                return Center(
                  child: Text(state.message),
                );
              }
            });
          } else {
            return Text('');
          }
        },
      ),
    );
  }
}
