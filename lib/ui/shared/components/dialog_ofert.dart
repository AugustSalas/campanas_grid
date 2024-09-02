import 'package:campanas_grid/providers/prospectos_provider.dart';
import 'package:campanas_grid/style_labels/style_labels.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../router/globals.dart' as globals;

class DialogOfert extends StatefulWidget {
  const DialogOfert({super.key});

  @override
  State<DialogOfert> createState() => _DialogOfertState();
}

class _DialogOfertState extends State<DialogOfert> {
  var f = NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    final prospectos = Provider.of<ProspectosProvider>(context);

    return FilledButton.icon(
      style: const ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              side:
                  BorderSide(color: Color.fromARGB(255, 68, 68, 68), width: 1)),
        ),
        backgroundColor: WidgetStatePropertyAll(
          Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      icon: const Icon(
        Icons.list,
        color: Color.fromARGB(255, 68, 68, 68),
        weight: 3,
        size: 23,
      ),
      label: const Text(
        'Selecciona una oferta',
        style: TextStyle(
          color: Color.fromARGB(255, 68, 68, 68),
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              insetAnimationDuration: const Duration(milliseconds: 200),
              insetAnimationCurve: Curves.easeInExpo,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                side: BorderSide(
                  color: Color.fromARGB(255, 68, 68, 68), 
                  width: 2,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ...prospectos.infOfertas.map(
                      (item) => SizedBox(
                        width: 500,
                        child: ListTile(
                          leading: const Icon(
                            Icons.money_rounded,
                            color: Color.fromARGB(255, 68, 68, 68),
                          ),
                          title: Text(
                            globals.tenantId == 'AFI RENO' ||
                                    globals.tenantId == 'AFI'
                                ? '${f.format(item.montoCreditoRenovacion)} USD - ${item.plazoRenovacion}'
                                : '\$${f.format(item.montoCreditoRenovacion)} MXN - ${item.plazoRenovacion}',
                            style: StyleLabels.titles,
                          ),
                          onTap: () {
                            prospectos.updateJson(item.id);
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
