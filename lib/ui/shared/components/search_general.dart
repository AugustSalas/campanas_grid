import 'package:flutter/material.dart';

class SearchGeneral extends StatefulWidget {
  const SearchGeneral({super.key});

  @override
  State<SearchGeneral> createState() => _SearchGeneralState();
}

class _SearchGeneralState extends State<SearchGeneral> {
  @override
  Widget build(BuildContext context) {
         final Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
                width: screenSize.width * 0.35,
                height: 50,
                child: SearchAnchor(
                          builder: (BuildContext context, SearchController controller) {
                        return SearchBar(
                          // constraints: BoxConstraints(
                          //   maxWidth: constraints.maxWidth * 0.35,
                          //   maxHeight: 100
                          // ),
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
                                print(item);
                              });
                            },
                          );
                        });
                      }),
              );
  }
}