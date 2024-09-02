import 'package:campanas_grid/providers/prospectos_provider.dart';
import 'package:campanas_grid/style_labels/style_labels.dart';
import 'package:campanas_grid/ui/shared/buttons/custom_dropdown.dart';
import 'package:campanas_grid/ui/shared/components/row_text_ofertas.dart';
import 'package:campanas_grid/ui/shared/gestion_opciones.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../router/globals.dart' as globals;

class ContactoCliente extends StatefulWidget {
  const ContactoCliente({super.key});

  @override
  State<ContactoCliente> createState() => _ContactoClienteState();
}

class _ContactoClienteState extends State<ContactoCliente> {
  String? tipoTelefono;
  String? telefono;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final client = Provider.of<ProspectosProvider>(context, listen: false);
      client.getInfOfertas().then((_) {
        if (!mounted) return;
        if (client.infOfertas.isNotEmpty) {
          setState(() {
            client.currentJson = client.infOfertas.first;
          });
        }
      });
      client.getCodigoGestiones();
    });
  }

  @override
  Widget build(BuildContext context) {
    final prospectos = Provider.of<ProspectosProvider>(context);

    final List<String> tipoGestion = prospectos.codGestiones == null
        ? []
        : globals.tenantId == 'AFI'
            ? prospectos.codGestiones!.configuration.afi.tipoGestion
            : globals.tenantId == 'FISA'
                ? prospectos.codGestiones!.configuration.fisa.tipoGestion
                : prospectos.codGestiones!.configuration.aef.tipoGestion;

    return prospectos.currentJson == null ||
            prospectos.currentJson!.idCliente != prospectos.idCliente
        ? const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 0, 117, 213),
              ),
            ),
          )
        : LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text('Contacto Cliente', style: StyleLabels.titulo),
                    const SizedBox(height: 10),
                    RowTextOfertas(
                      title: 'Último télefono marcado',
                      data: prospectos.currentJson!.lastPhone,
                      width: constraints.maxWidth * 0.4,
                      style: StyleLabels.detalle,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomDropdown(
                          width: constraints.maxWidth * 0.6,
                          height: 50,
                          hintDrop: 'Tipo télefono',
                          onChanged: (value) {
                            setState(() {
                              tipoTelefono = value as String;
                            });
                          },
                          selectedValue: tipoTelefono,
                          data: tipoGestion,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    tipoTelefono == null
                        ? const SizedBox.shrink()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomDropdown(
                                width: constraints.maxWidth * 0.41,
                                height: 50,
                                hintDrop: prospectos.currentJson == null
                                    ? ''
                                    : tipoTelefono == 'Celular'
                                        ? prospectos.currentJson!.telefonoMovil
                                                .isEmpty
                                            ? 'Sin registros'
                                            : prospectos.currentJson!
                                                .telefonoMovil.first
                                        : prospectos.currentJson!
                                                .telefonoDirecto.isEmpty
                                            ? 'Sin registros'
                                            : prospectos.currentJson!
                                                .telefonoDirecto.first,
                                onChanged: (value) {
                                  setState(() {
                                    telefono = value as String;
                                  });
                                },
                                selectedValue: telefono,
                                data: prospectos.currentJson == null
                                    ? []
                                    : tipoTelefono == 'Celular'
                                        ? prospectos.currentJson!.telefonoMovil
                                            .toSet()
                                            .toList()
                                        : prospectos
                                            .currentJson!.telefonoDirecto
                                            .toSet()
                                            .toList(),
                              ),
                              SizedBox(width: constraints.maxWidth * 0.02),
                              ElevatedButton(
                                style: ButtonStyle(
                                  maximumSize: WidgetStateProperty.all<Size>(
                                      Size(constraints.maxWidth * 0.3,
                                          constraints.maxWidth * 0.3)),
                                ),
                                onPressed: () {
                                  Clipboard.setData(
                                      ClipboardData(text: telefono!));
                                },
                                child: const Text(
                                  "Copiar",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 117, 213),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                    const SizedBox(height: 20),
                    telefono == null
                        ? const SizedBox.shrink()
                        : const GestionOpciones(),
                  ],
                ),
              );
            },
          );
  }
}
