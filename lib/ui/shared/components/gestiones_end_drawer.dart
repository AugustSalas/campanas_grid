
import 'package:campanas_grid/ui/shared/gestiones_cliente.dart';
import 'package:flutter/material.dart';

class GestionesEndDrawer extends StatefulWidget {
  const GestionesEndDrawer({super.key});

  @override
  State<GestionesEndDrawer> createState() => _GestionesEndDrawerState();
}

class _GestionesEndDrawerState extends State<GestionesEndDrawer> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
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
        child: const Column(
          children: [
            Expanded(child: GestionesCliente()),
          ],
        ),
      );
    });
  }
}
