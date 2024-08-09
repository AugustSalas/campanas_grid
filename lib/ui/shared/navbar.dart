import 'package:campanas_grid/providers/prospectos_provider.dart';
import 'package:expandable_search_bar/expandable_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:campanas_grid/providers/home_provider.dart';
import 'package:campanas_grid/router/router.dart';
import 'package:campanas_grid/services/navigation_service.dart';
import 'package:campanas_grid/ui/shared/components/search_text.dart';
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
              SizedBox(
                width: constraints.maxWidth * 0.30,
                child: SearchText(
                  onChanged: (value) {
                      setState(() {
                        prospectos.changeSearchString(value);
                      });
                  },
                  hint: 'Buscar Prospecto',
                ),
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
              size.width > 560
                  ? SizedBox(
                      width: constraints.maxWidth * 0.30,
                      child: SearchText(
                        onChanged: (value) {},
                        hint: 'Buscar Prospecto',
                      ))
                  : ExpandableSearchBar(
                      iconBackgroundColor:
                          const Color.fromARGB(255, 225, 222, 222),
                      iconColor: const Color.fromARGB(255, 108, 108, 108),
                      backgroundColor: const Color.fromARGB(255, 236, 235, 235),
                      // onTap: () => print(editTextController!.text.toString()),
                      onTap: () {},
                      hintText: "Buscar Prospecto",
                      editTextController: editTextController,
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
