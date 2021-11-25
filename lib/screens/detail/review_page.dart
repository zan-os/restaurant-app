import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/detail_provider.dart';
import 'package:restaurant_app/widgets/review_list.dart';

class RestaurantReviewPage extends StatelessWidget {
  final String id;
  const RestaurantReviewPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Review'),
      ),
      child: SafeArea(child: _buildRestaurantReview()),
    );
  }

  Widget _buildRestaurantReview() {
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
            return ReviewList(
              restaurantDetail: state.resultState!.restaurant,
            );
          } else if (state.detailState == StateDetail.noData) {
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
          } else if (state.detailState == StateDetail.error) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Text('');
          }
        },
      ),
    );
  }
}
