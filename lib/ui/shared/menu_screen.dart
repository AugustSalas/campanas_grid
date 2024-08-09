import 'package:campanas_grid/providers/home_provider.dart';
import 'package:campanas_grid/router/router.dart';
import 'package:campanas_grid/services/navigation_service.dart';
import 'package:campanas_grid/ui/shared/buttons/custom_button_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../router/globals.dart' as globals;

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  void navigateTo(String routeName) {
    NavigationService.replaceTo(routeName);
  }

  @override
  Widget build(BuildContext context) {
    final home = Provider.of<HomeProvider>(context);

    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 30),
            CustomButtonScreen(
              text: 'Prospectos',
              changeColor:
                  home.screenMenu == 'Prospectos' ? true : false,
              camFunc: () {
                navigateTo(
                    '${Flurorouter.prospectosRoute}?tenantId=${globals.tenantId}&user=${globals.user}&sucursal=${globals.sucursal}&type=${globals.type}&channel=${globals.channel}');
              },
              tamBtnW: 180,
              icon: Icons.groups,
            ),
            CustomButtonScreen(
              text: 'Gestiones',
               changeColor:
                  home.screenMenu == 'Gestiones' ? true : false,
              camFunc: () {
                navigateTo(
                  '${Flurorouter.gestionesRoute}?tenantId=${globals.tenantId}&user=${globals.user}&sucursal=${globals.sucursal}&type=${globals.type}&channel=${globals.channel}');
           
              },
              tamBtnW: 180,
              icon: Icons.person,
            ),
            CustomButtonScreen(
              text: 'Citas',
              changeColor: home.screenMenu == 'Citas' ? true : false,
              camFunc: () {
                navigateTo(
                  '${Flurorouter.citasRoute}?tenantId=${globals.tenantId}&user=${globals.user}&sucursal=${globals.sucursal}&type=${globals.type}&channel=${globals.channel}',
                );
              },
              tamBtnW: 150,
              icon: Icons.calendar_today,
            ),
            CustomButtonScreen(
              text: 'Reasignación',
              tamBtnW: 210,
              camFunc: () {
                navigateTo(
                  Flurorouter.prospectosRoute,
                );
              },
              icon: Icons.person_add_alt_1,
            ),
          ],
        ),
      ],
    );
  }
}
