import 'package:campanas_grid/providers/prospectos_provider.dart';
import 'package:campanas_grid/providers/resumen_gestiones_provider.dart';
import 'package:campanas_grid/router/router.dart';
import 'package:campanas_grid/services/navigation_service.dart';
import 'package:campanas_grid/style_labels/style_labels.dart';
import 'package:campanas_grid/ui/shared/components/selects_resumen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../router/globals.dart' as globals;

class DialogResumen extends StatefulWidget {
  const DialogResumen({super.key});

  @override
  State<DialogResumen> createState() => _DialogResumenState();
}

class _DialogResumenState extends State<DialogResumen> {
  void navigateTo(String routeName) {
    NavigationService.replaceTo(routeName);
  }
  

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final prospectos =
          Provider.of<ResumenGestionesProvider>(context, listen: false);
          prospectos.prospectosProvider.resetValues();
      prospectos.getPeriodos();
      final Size screenSize = MediaQuery.of(context).size;
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      navigateTo(
                          '${Flurorouter.prospectosRoute}?tenantId=${globals.tenantId}&user=${globals.user}&sucursal=${globals.sucursal}&type=${globals.type}&channel=${globals.channel}');
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Colors.black,
                    ))
              ],
            ),
            title: ListTile(
              // leading: const Icon(
              //   Icons.library_books,
              //   color: Colors.black,
              // ),
              title: Text(
                'Resumen gestiones',
                style: StyleLabels.btnNavBar,
                textAlign: TextAlign.center,
              ),
            ),
            content: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  SelectsResumen(
                    width: screenSize.width > 430 ? screenSize.width * 0.27: screenSize.width * 0.60,
                    onChanged: (value) {
                      setState(() {
                        prospectos.prospectosProvider.empresa = value as String?;
                        if (prospectos.prospectosProvider.empresa != null) {
                          prospectos.prospectosProvider.nomEmpresa = prospectos.prospectosProvider.empresa!;
                          prospectos.prospectosProvider.getSucursal();
                        }
                      });
                    },
                    onChanged2: (value) {
                      setState(() {
                        prospectos.prospectosProvider.selectedSucursal = value.toString();
                        if (prospectos.prospectosProvider.selectedSucursal != null) {
                          RegExp regExp = RegExp(r'\d+$');
                          String? match =
                              regExp.stringMatch(prospectos.prospectosProvider.selectedSucursal!);
                          if (match != null) {
                            prospectos.prospectosProvider.numeroSucursal = match;
                            prospectos.getPeriodos();
                          }
                        }
                      });
                    },
                  ),
                  
                ],
              ),
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
