import 'package:flutter/material.dart';

class SearchClient extends StatefulWidget {
  const SearchClient({super.key});

  @override
  State<SearchClient> createState() => _SearchClientState();
}

class _SearchClientState extends State<SearchClient> {
  @override
  Widget build(BuildContext context) {
    return  Navigator(
  onGenerateRoute: (settings) {
    return MaterialPageRoute(
      builder: (BuildContext context) => 
      SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              constraints: const BoxConstraints(
                          maxWidth: 350,minHeight: 300),
              controller: controller,
              padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0)),
              onTap: () {
                controller.openView();
              },
              onChanged: (_) {
                controller.openView();
              },
              leading: const Icon(Icons.search),
            );
          }, suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
            return List<ListTile>.generate(5, (int index) {
              final String item = 'item $index';
              return ListTile(
                title: Text(item),
                onTap: () {
                  setState(() {
                    controller.closeView(item);
                  });
                },
              );
            },);
          },),
    );
  },
);



  }
}
