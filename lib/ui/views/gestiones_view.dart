import 'package:campanas_grid/providers/gestiones_provider.dart';
import 'package:campanas_grid/providers/prospectos_provider.dart';
import 'package:campanas_grid/ui/shared/components/gestiones_end_drawer.dart';
import 'package:campanas_grid/ui/shared/components/titulo_navegacion.dart';
import 'package:campanas_grid/ui/shared/menu_screen.dart';
import 'package:campanas_grid/ui/shared/tables_gestiones.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GestionesView extends StatefulWidget {
  const GestionesView({super.key});

  @override
  State<GestionesView> createState() => _GestionesViewState();
}

class _GestionesViewState extends State<GestionesView> {
    @override
  void initState() {
    super.initState();
    Provider.of<ProspectosProvider>(context, listen: false).getSucursal();
  }
  
  @override
  Widget build(BuildContext context) {
    final gestiones = Provider.of<GestionesProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: gestiones.gestionesScaffoldKey,
      endDrawer: const GestionesEndDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const TitulosNavegacion(),
            const SizedBox(height: 20),
            size.width > 770 
            ? const MenuScreen()
            : const SizedBox.shrink(),
            const SizedBox(height: 10),
             gestiones.prospectosProvider.rolePerfil != ''
             ? const TablesGestiones()
            : const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 0, 117, 213),
              ),
            ),
          )
          ],
        ),
      ),
    );
  }
}
