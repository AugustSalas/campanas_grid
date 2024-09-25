import 'package:campanas_grid/providers/prospectos_provider.dart';
import 'package:flutter/material.dart';
import 'package:campanas_grid/providers/home_provider.dart';
import 'package:campanas_grid/router/router.dart';
import 'package:campanas_grid/services/navigation_service.dart';
import 'package:campanas_grid/style_labels/style_labels.dart';
import 'package:provider/provider.dart';
import '../../router/globals.dart' as globals;

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  void navigateTo(String routeName) {
    NavigationService.replaceTo(routeName);
  }

  

  @override
  Widget build(BuildContext context) {
    final prospectos = Provider.of<ProspectosProvider>(context);

    final myController = TextEditingController();

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          width: constraints.maxWidth * 0.97,
          height: 70,
          decoration: buildBoxDecoration(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: constraints.maxWidth * 0.025),
              InkWell(
                onTap: () {
                  navigateTo(
                      '${Flurorouter.homeRoute}?tenantId=${globals.tenantId}&user=${globals.user}&sucursal=${globals.sucursal}&type=${globals.type}&channel=${globals.channel}');
                },
                child: Image(
                  image: const AssetImage('assets/logo222.png'),
                  width: constraints.maxWidth * 0.128,
                  height: 50,
                ),
              ),
              const Spacer(),
              TextButton.icon(
                icon: const Icon(
                  Icons.campaign,
                  color: Colors.black,
                ),
                label: Text(
                  'Campañas',
                  style: StyleLabels.btnNavBar,
                ),
                onPressed: () {
                  navigateTo(
                      '${Flurorouter.prospectosRoute}?tenantId=${globals.tenantId}&user=${globals.user}&sucursal=${globals.sucursal}&type=${globals.type}&channel=${globals.channel}');
                },
              ),
              SizedBox(width: constraints.maxWidth * 0.045),
              TextButton.icon(
                icon: const Icon(
                  Icons.library_books,
                  color: Colors.black,
                ),
                label: Text(
                  'Resumen gestiones',
                  style: StyleLabels.btnNavBar,
                ),
                onPressed: () {
                  navigateTo(
                      '${Flurorouter.resumenRoute}?tenantId=${globals.tenantId}&user=${globals.user}&sucursal=${globals.sucursal}&type=${globals.type}&channel=${globals.channel}');
                },
              ),
              const Spacer(),
              Row(
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.25,
                    child: TextField(
                      controller: myController,
                      onChanged: (value) {
                        prospectos.infoSearch = value;
                      },
                      decoration: InputDecoration(
                        label: Text('Buscar prospecto',
                            style: StyleLabels.dataColumn2),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 217, 217, 217),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 217, 217, 217),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      return IconButton(
                        onPressed: () {
                          prospectos.getBuscador();
                          
                          navigateTo(
                              '${Flurorouter.buscadorRoute}?tenantId=${globals.tenantId}&user=${globals.user}&sucursal=${globals.sucursal}&type=${globals.type}&channel=${globals.channel}');

                        },
                        icon: const Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 68, 68, 68),
                        ),
                      );
                    }
                  ),
                ],
              ),
              SizedBox(width: constraints.maxWidth * 0.035),
            ],
          ),
        ),
      );
    });
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 3,
          ),
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      );
}

class NavBarMobile extends StatefulWidget {
  const NavBarMobile({super.key});

  @override
  State<NavBarMobile> createState() => _NavBarMobileState();
}

class _NavBarMobileState extends State<NavBarMobile> {
  void navigateTo(String routeName) {
    NavigationService.replaceTo(routeName);
  }

  TextEditingController? editTextController;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final home = Provider.of<HomeProvider>(context);
    final prospectos = Provider.of<ProspectosProvider>(context);

    final myController = TextEditingController();
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          width: constraints.maxWidth * 0.97,
          height: 70,
          decoration: buildBoxDecoration(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: constraints.maxWidth * 0.025),
              IconButton(
                icon: const Icon(
                  Icons.menu,
                  size: 30,
                  color: Colors.black,
                ),
                onPressed: () {
                  home.scaffoldKey.currentState?.openDrawer();
                },
              ),
              InkWell(
                onTap: () {
                  navigateTo(
                      '${Flurorouter.homeRoute}?tenantId=${globals.tenantId}&user=${globals.user}&sucursal=${globals.sucursal}&type=${globals.type}&channel=${globals.channel}');
                },
                child: Image(
                  image: const AssetImage('assets/logo222.png'),
                  width: constraints.maxWidth * 0.128,
                  height: 50,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  SizedBox(
                    width: size.width > 500
                        ? constraints.maxWidth * 0.35
                        : constraints.maxWidth * 0.5,
                    child: TextField(
                      controller: myController,
                      onChanged: (value) {
                        prospectos.infoSearch = value;
                      },
                      decoration: InputDecoration(
                        label: Text('Buscar prospecto',
                            style: StyleLabels.dataColumn2),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 217, 217, 217),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 217, 217, 217),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      prospectos.getBuscador();
                      navigateTo(
                              '${Flurorouter.buscadorRoute}?tenantId=${globals.tenantId}&user=${globals.user}&sucursal=${globals.sucursal}&type=${globals.type}&channel=${globals.channel}');

                    },
                    icon: const Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 68, 68, 68),
                    ),
                  ),
                ],
              ),
              SizedBox(width: constraints.maxWidth * 0.035),
            ],
          ),
        ),
      );
    });
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 3,
          ),
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      );
}
