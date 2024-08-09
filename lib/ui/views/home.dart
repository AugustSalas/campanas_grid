import 'package:campanas_grid/providers/prospectos_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

    @override
  void initState() {
    super.initState();
    Provider.of<ProspectosProvider>(context, listen: false).getSucursal();
  }
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        width: screenSize.width * 0.8,
        height: screenSize.height * 0.7,
        child: const Image(
          image: AssetImage('assets/principal.png'),
          fit: BoxFit.contain,
          //width: screenSize.width * 0.8,
          //height: screenSize.height * 0.8,
        ),
      ),
    );
  }
}
