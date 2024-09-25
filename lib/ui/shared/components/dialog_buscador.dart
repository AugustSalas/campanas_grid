import 'package:campanas_grid/providers/prospectos_provider.dart';
import 'package:campanas_grid/router/router.dart';
import 'package:campanas_grid/services/navigation_service.dart';
import 'package:campanas_grid/style_labels/style_labels.dart';
import 'package:campanas_grid/ui/shared/components/custom_end_drawer.dart';
import 'package:campanas_grid/ui/shared/contacto_cliente.dart';
import 'package:campanas_grid/ui/shared/gestiones_cliente.dart';
import 'package:campanas_grid/ui/shared/oferta.dart';
import 'package:campanas_grid/ui/shared/referencia_cliente.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../router/globals.dart' as globals;

class DialogBuscador extends StatefulWidget {
  const DialogBuscador({super.key});

  @override
  State<DialogBuscador> createState() => _DialogBuscadorState();
}

class _DialogBuscadorState extends State<DialogBuscador> 
with SingleTickerProviderStateMixin {

  void navigateTo(String routeName) {
    NavigationService.replaceTo(routeName);
  }

   TabController? tabController;

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  void showBuscador(){

    showDialog(
      barrierDismissible: false,
      context: context, builder:  (BuildContext context) {
final size = MediaQuery.of(context).size;
      return  AlertDialog(
        
          shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        title:  Container(
          decoration: const BoxDecoration(
             color:Color.fromARGB(255, 229, 238, 255),
                   borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
             
              child: TabBar(
                splashBorderRadius: const BorderRadius.all(Radius.circular(30)),
                dividerColor: Colors.transparent,
                indicator: const BoxDecoration(
                    color:Color.fromARGB(255, 229, 238, 255),
                   borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                indicatorColor: const Color.fromARGB(255, 0, 117, 213),
                controller: tabController,
                labelStyle: StyleLabels.dataColumn3,
                unselectedLabelStyle: StyleLabels.dataCell3,
                tabs:  [
                  size.width > 1036 ?
                  const Tab(
                    text: 'Oferta',
                    icon: Icon(Icons.local_offer_outlined),
                  )
                  : const Tab( icon: Icon(Icons.local_offer_outlined)),
                   size.width > 1036 ?
                  const Tab(
                    text: 'Gestión oferta',
                    icon: Icon(Icons.credit_card_rounded),
                  )
                  :
                   const Tab(
                    icon: Icon(Icons.credit_card_rounded)),
                    size.width > 1036 ?
                  const Tab(
                    text: 'Gestiones',
                    icon: Icon(Icons.book_rounded),
                  )
                  : const Tab(icon: Icon(Icons.book_rounded)),
                   size.width > 1036 ?
                  const Tab(
                    text: 'Referencias',
                    icon: Icon(Icons.person),
                  )
                  : const Tab(icon: Icon(Icons.person)),
                ],
              ),
            ),
        content: SizedBox(
          width: size.width * 0.45,
              child: TabBarView(
                controller: tabController,
                children: const [
                  Oferta(),
                  ContactoCliente(),
                  GestionesCliente(),
                  ReferenciaCliente()
                ],
              ),
            ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      
      showDialog(
        barrierDismissible: false,
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
              title: Text(
                'Prospectos encontrados',
                style: StyleLabels.btnNavBar,
                textAlign: TextAlign.center,
              ),
            ),
            content: prospectos.buscador.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 0, 117, 213),
                    ),
                  )
                : Column(
                    children: prospectos.buscador
                        .map(
                          (e) => ListTile(
                            title: Text(
                              e.nombre,
                              style: StyleLabels.dataCell4,
                            ),
                            onTap: () async {
                              prospectos.idCliente = e.cliente;

                              showBuscador();

                              // prospectos.buscadorScaffoldKey.currentState
                              //     ?.openEndDrawer();

                              // Navigator.of(context).pop();
                            },
                          ),
                        )
                        .toList(), // Convierte el iterable a una lista de widgets
                  ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SizedBox.shrink(),);
  }
}

