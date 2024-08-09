import 'package:campanas_grid/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:campanas_grid/router/router.dart';
import 'package:campanas_grid/services/navigation_service.dart';
import 'package:campanas_grid/style_labels/style_labels.dart';
import 'package:provider/provider.dart';
import '../../../router/globals.dart' as globals;

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  void navigateTo(String routeName) {
    NavigationService.replaceTo(routeName);
  }

  @override
  Widget build(BuildContext context) {
    final home = Provider.of<HomeProvider>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 229, 238, 255),
            ),
            child: Center(
              child: Text(
                'Menú campañas',
                style: StyleLabels.titleDrawer,
              ),
            ),
          ),
          ListTile(
              leading: const Icon(
                Icons.campaign,
                color: Colors.black,
              ),
              title: Text(
                'Campañas',
                style: StyleLabels.btnNavBar,
              ),
              onTap: () {
                navigateTo(
                    '${Flurorouter.prospectosRoute}?tenantId=${globals.tenantId}&user=${globals.user}&sucursal=${globals.sucursal}&type=${globals.type}&channel=${globals.channel}');

                home.scaffoldKey.currentState?.closeDrawer();
              }),
          ListTile(
              leading: const Icon(
                Icons.library_books,
                color: Colors.black,
              ),
              title: Text(
                'Resumen gestiones',
                style: StyleLabels.btnNavBar,
              ),
              onTap: () {
                navigateTo(
                    '${Flurorouter.resumenRoute}?tenantId=${globals.tenantId}&user=${globals.user}&sucursal=${globals.sucursal}&type=${globals.type}&channel=${globals.channel}');

                home.scaffoldKey.currentState?.closeDrawer();
              }),
          ListTile(
              leading: const Icon(
                Icons.groups,
                color: Colors.black,
              ),
              title: Text(
                'Prospectos',
                style: StyleLabels.btnNavBar,
              ),
              onTap: () {
                navigateTo(
                    '${Flurorouter.prospectosRoute}?tenantId=${globals.tenantId}&user=${globals.user}&sucursal=${globals.sucursal}&type=${globals.type}&channel=${globals.channel}');

                home.scaffoldKey.currentState?.closeDrawer();
              }),
          ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.black,
              ),
              title: Text(
                'Gestiones',
                style: StyleLabels.btnNavBar,
              ),
              onTap: () {
                navigateTo(Flurorouter.resumenRoute);
                home.scaffoldKey.currentState?.closeDrawer();
              }),
          ListTile(
              leading: const Icon(
                Icons.calendar_today,
                color: Colors.black,
              ),
              title: Text(
                'Citas',
                style: StyleLabels.btnNavBar,
              ),
              onTap: () {
                navigateTo(Flurorouter.resumenRoute);
                home.scaffoldKey.currentState?.closeDrawer();
              }),
          ListTile(
              leading: const Icon(
                Icons.person_add_alt_1,
                color: Colors.black,
              ),
              title: Text(
                'Reasignación',
                style: StyleLabels.btnNavBar,
              ),
              onTap: () {
                navigateTo(Flurorouter.resumenRoute);
                home.scaffoldKey.currentState?.closeDrawer();
              }),
        ],
      ),
    );
  }
}
