import 'package:api_project/model/Items_model.dart';

import 'package:flutter/material.dart';

class ItemSearchDelegate extends SearchDelegate<Items_data> {
  final List<Items_data> itemList;

  ItemSearchDelegate({
    required this.itemList,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
        // close(context,  null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSearchResults(itemList);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildSearchResults(itemList);
  }

  Widget buildSearchResults(List<Items_data> itemList) {
    // Implement the UI for displaying search results
    return ListView.builder(
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(itemList[index].itemName ?? ""),
          // Handle tapping on the search result item
          onTap: () {
            // Implement the action when a search result is tapped
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => Details_page(
            //       // Pass the selected item
            //       store: store,
            //       item: itemList[index],
            //     ),
            //   ),
            // );
          },
        );
      },
    );
  }
}
