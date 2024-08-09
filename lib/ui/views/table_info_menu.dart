import 'package:campanas_grid/providers/prospectos_provider.dart';
import 'package:campanas_grid/ui/shared/components/custom_end_drawer.dart';
import 'package:campanas_grid/ui/shared/components/titulo_navegacion.dart';
import 'package:campanas_grid/ui/shared/menu_screen.dart';
import 'package:campanas_grid/ui/views/prospectos_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TableInfoMenu extends StatefulWidget {
  const TableInfoMenu({super.key});

  @override
  State<TableInfoMenu> createState() => _TableInfoMenuState();
}

class _TableInfoMenuState extends State<TableInfoMenu> {

   @override
  void initState() {
    super.initState();
    Provider.of<ProspectosProvider>(context, listen: false).getSucursal();
  }
  
  @override
  Widget build(BuildContext context) {
    final prospectos = Provider.of<ProspectosProvider>(context);
    final size = MediaQuery.of(context).size;
    return  Scaffold(
      key: prospectos.prospectosScaffoldKey,
      endDrawer: const CustomEndDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const TitulosNavegacion(),
            const SizedBox(height: 20),
            size.width > 770 
            ? const MenuScreen()
            : const SizedBox.shrink(),
            const SizedBox(height: 10),
             prospectos.rolePerfil != ''
             ? const ProspectosView()
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
