import 'package:campanas_grid/providers/prospectos_provider.dart';
import 'package:campanas_grid/router/router.dart';
import 'package:campanas_grid/services/navigation_service.dart';
import 'package:campanas_grid/style_labels/style_labels.dart';
import 'package:campanas_grid/ui/shared/components/custom_end_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../router/globals.dart' as globals;

class DialogBuscador extends StatefulWidget {
  const DialogBuscador({super.key});

  @override
  State<DialogBuscador> createState() => _DialogBuscadorState();
}

class _DialogBuscadorState extends State<DialogBuscador> {
  late SearchController searchController;


  void navigateTo(String routeName) {
    NavigationService.replaceTo(routeName);
  }
  

  @override
  void initState() {
    super.initState();
    searchController = SearchController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //Provider.of<ProspectosProvider>(context, listen: false).getBuscador();
      showDialog(
        //barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          final prospectos = Provider.of<ProspectosProvider>(context);
          return AlertDialog(
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      navigateTo(
                          '${Flurorouter.prospectosRoute}?tenantId=${globals.tenantId}&user=${globals.user}&sucursal=${globals.sucursal}&type=${globals.type}&channel=${globals.channel}');
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Colors.black,
                    ))
              ],
            ),
            title: ListTile(
              // leading: const Icon(
              //   Icons.library_books,
              //   color: Colors.black,
              // ),
              title: Text(
                'Buscador prospectos',
                style: StyleLabels.btnNavBar,
                textAlign: TextAlign.center,
              ),
            ),
            
            content: SearchAnchor(
              searchController: searchController,
                          builder: (BuildContext context, SearchController controller) {
                        return SearchBar(
                          // constraints: BoxConstraints(
                          //   maxWidth: constraints.maxWidth * 0.35,
                          //   maxHeight: 100
                          // ),
                          controller: searchController,
                          padding: const WidgetStatePropertyAll<EdgeInsets>(
                              EdgeInsets.symmetric(horizontal: 16.0)),
                          onTap: () {
                            searchController.openView();
                          },
                          onChanged: (_) {
                            searchController.openView();
                          },
                          leading: const Icon(Icons.search),
                        );
                      }, suggestionsBuilder:
                              (BuildContext context, SearchController controller) {
                        return  prospectos.buscador.map((cliente) {
                          return ListTile(
                            title: Text(cliente.nombre),
                            onTap: () async {
                                prospectos.buscadorScaffoldKey.currentState?.openEndDrawer();
                                prospectos.idCliente = cliente.cliente;
                                Navigator.of(context).pop();
                                Navigator.pop(context);
                            },
                          );
                        },);
                      },),


          );
        },
      );
    });
  }

   @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prospectos = Provider.of<ProspectosProvider>(context);
    return  Scaffold(
       key: prospectos.buscadorScaffoldKey,
      endDrawer: const CustomEndDrawer(),
      body: const SizedBox.shrink(),
    );
  }
}
