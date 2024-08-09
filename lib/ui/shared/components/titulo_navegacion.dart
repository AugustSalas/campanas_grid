import 'package:campanas_grid/providers/home_provider.dart';
import 'package:campanas_grid/style_labels/style_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TitulosNavegacion extends StatelessWidget {
  const TitulosNavegacion({super.key});

  @override
  Widget build(BuildContext context) {
    final home = Provider.of<HomeProvider>(context);
    final size = MediaQuery.of(context).size;
    return size.width > 732
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 47),
              Text(
                'Todas las campañas',
                style: StyleLabels.titleMenus,
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.double_arrow_rounded,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                home.screenMenu,
                style: StyleLabels.titleMenus2,
              )
            ],
          )
        : Column(
            children: [
              const SizedBox(width: 47),
              Padding(
                padding: const EdgeInsets.only(left: 27),
                child: Row(
                  children: [
                    Text(
                      'Todas las campañas',
                      style: size.width > 410 ? StyleLabels.titleMenus:StyleLabels.titleMenus3
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.double_arrow_rounded,
                      size: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(left: 27),
                child: Row(
                  children: [
                    Text(
                      home.screenMenu,
                      style: StyleLabels.titleMenus2,
                    ),
                  ],
                ),
              )
            ],
          );
  }
}
