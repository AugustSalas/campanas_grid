import 'package:campanas_grid/style_labels/style_labels.dart';
import 'package:campanas_grid/ui/shared/contacto_cliente.dart';
import 'package:campanas_grid/ui/shared/gestiones_cliente.dart';
import 'package:campanas_grid/ui/shared/oferta.dart';
import 'package:campanas_grid/ui/shared/referencia_cliente.dart';
import 'package:flutter/material.dart';

class CustomEndDrawer extends StatefulWidget {
  const CustomEndDrawer({super.key});

  @override
  State<CustomEndDrawer> createState() => _CustomEndDrawerState();
}

class _CustomEndDrawerState extends State<CustomEndDrawer>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
      return Drawer(
        width: constraints.maxWidth > 1282
            ? constraints.maxWidth * 0.32
            : constraints.maxWidth > 440
                ? constraints.maxWidth * 0.45
                : constraints.maxWidth * 0.80,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              color: const Color.fromARGB(255, 229, 238, 255),
              child: TabBar(
                indicatorColor: const Color.fromARGB(255, 0, 117, 213),
                controller: tabController,
                labelStyle: StyleLabels.dataColumn3,
                unselectedLabelStyle: StyleLabels.dataCell3,
                tabs:  [
                  constraints.maxWidth > 1036 ?
                  const Tab(
                    text: 'Oferta',
                    icon: Icon(Icons.local_offer_outlined),
                  )
                  : const Tab( icon: Icon(Icons.local_offer_outlined)),
                  constraints.maxWidth > 1036 ?
                  const Tab(
                    text: 'Gestión oferta',
                    icon: Icon(Icons.credit_card_rounded),
                  )
                  :
                   const Tab(
                    icon: Icon(Icons.credit_card_rounded)),
                   constraints.maxWidth > 1036 ?
                  const Tab(
                    text: 'Gestiones',
                    icon: Icon(Icons.book_rounded),
                  )
                  : const Tab(icon: Icon(Icons.book_rounded)),
                  constraints.maxWidth > 1036 ?
                  const Tab(
                    text: 'Referencias',
                    icon: Icon(Icons.person),
                  )
                  : const Tab(icon: Icon(Icons.person)),
                ],
              ),
            ),
            Expanded(
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
          ],
        ),
      );
    });
  }
}
