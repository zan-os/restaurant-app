import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/widgets/search_card_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();

  String q = '';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          middle: Text("Search Page"), automaticallyImplyLeading: false),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              ChangeNotifierProvider<SearchProvider>(
                create: (_) => SearchProvider(apiService: ApiService()),
                child: Consumer<SearchProvider>(
                  builder: (context, state, _) {
                    return CupertinoTextField(
                      controller: _searchController,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: CupertinoColors.inactiveGray),
                          borderRadius: BorderRadius.circular(5)),
                      placeholder: "Search...",
                      prefix: Icon(
                        CupertinoIcons.search,
                        color: CupertinoColors.inactiveGray,
                      ),
                      onSubmitted: (String query) {
                        setState(() {
                          q = query;
                          state.fetchAllSearch(query);
                        });
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Expanded(child: _buildSearchItem(context))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchItem(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchProvider(
        apiService: ApiService(),
      ),
      child: Consumer<SearchProvider>(
        builder: (context, state, _) {
          if (state.searchState == StateSearch.loading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text("Please Wait"),
                ],
              ),
            );
          } else if (state.searchState == StateSearch.hasData) {
            state.fetchAllSearch(q);
            return Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.searchResult!.restaurants.length,
                itemBuilder: (context, index) {
                  var restaurantSearch = state.searchResult!.restaurants[index];
                  return SearchList(
                    restaurantSearch: restaurantSearch,
                  );
                },
              ),
            );
          } else if (state.searchState == StateSearch.noData) {
            q = '';
            return Center(
              child: Text(state.mesage),
            );
          } else if (state.searchState == StateSearch.error) {
            state.fetchAllSearch(q);
            return Builder(
              builder: (context) {
                if (state.mesage.contains("SocketException")) {
                  return Center(
                    child: Text("No Internet"),
                  );
                } else {
                  return Center(
                    child: Text(state.mesage),
                  );
                }
              },
            );
          } else {
            return Text('');
          }
        },
      ),
    );
  }
}
