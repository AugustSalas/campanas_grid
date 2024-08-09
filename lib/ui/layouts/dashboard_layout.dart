import 'package:flutter/material.dart';
import 'package:campanas_grid/providers/home_provider.dart';
import 'package:campanas_grid/ui/shared/components/custom_drawer.dart';
import 'package:campanas_grid/ui/shared/navbar.dart';
import 'package:provider/provider.dart';

class DashboardLayout extends StatefulWidget {
  final Widget child;
  const DashboardLayout({super.key, required this.child});

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> {
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final home = Provider.of<HomeProvider>(context);

    return Scaffold(
      key: home.scaffoldKey,
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                      size.width > 930 ? const NavBar() :  const NavBarMobile(),
                    Expanded(
                      child: Stack(
                        children: [
                          widget.child,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
