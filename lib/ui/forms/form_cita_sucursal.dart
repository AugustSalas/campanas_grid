// ignore_for_file: use_build_context_synchronously

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:campanas_grid/providers/form_cita_provider.dart';
import 'package:campanas_grid/providers/prospectos_provider.dart';
import 'package:campanas_grid/ui/shared/buttons/custom_outlined_button.dart';
import 'package:campanas_grid/ui/shared/components/custom_inputs.dart';
import 'package:campanas_grid/ui/shared/components/fecha_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../router/globals.dart' as globals;

class FormCitaSucursal extends StatefulWidget {
  const FormCitaSucursal({super.key});

  @override
  State<FormCitaSucursal> createState() => _FormCitaSucursalState();
}

class _FormCitaSucursalState extends State<FormCitaSucursal> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FormCitaProvider(),
      child: Builder(
        builder: (context) {
          final myController = TextEditingController();
          final prospectos =
              Provider.of<ProspectosProvider>(context, listen: false);

          final citaProvider =
              Provider.of<FormCitaProvider>(context, listen: false);

          void saveCita() async {
            try {
              final response = await citaProvider.registerCita(
                citaProvider.comentario,
                citaProvider.idOferta = prospectos.currentJson!.id,
                citaProvider.resultado = prospectos.resultadoGestion,
                citaProvider.vendedor = globals.user!,
                citaProvider.fechaHora,
                citaProvider.medioContacto = '',
                citaProvider.estatusCliente = prospectos.estatusCliente,
                citaProvider.respuestaCliente = prospectos.respuestaCliente,
                citaProvider.channel = globals.channel!,
              );

              if (response.statusCode == 200) {
                ArtSweetAlert.show(
                  context: context,
                  artDialogArgs: ArtDialogArgs(
                    type: ArtSweetAlertType.success,
                    title: "Guardado",
                    onConfirm: () {
                      citaProvider.formCitaKey.currentState!.reset();
                      Navigator.of(context).pop();
                      Navigator.pop(context);
                    },
                  ),
                );
              } else {
                ArtSweetAlert.show(
                  context: context,
                  artDialogArgs: ArtDialogArgs(
                    type: ArtSweetAlertType.danger,
                    title: "Error",
                    text: "No se pudo guardar la cita sucursal.",
                    onConfirm: () {
                      citaProvider.formCitaKey.currentState!.reset();
                      Navigator.of(context).pop();
                      Navigator.pop(context);
                    },
                  ),
                );
              }
            } catch (error) {
              ArtSweetAlert.show(
                context: context,
                artDialogArgs: ArtDialogArgs(
                  type: ArtSweetAlertType.danger,
                  title: "Error",
                  text: "Ocurrió un error al guardar la cita sucursal.",
                  onConfirm: () {
                    citaProvider.formCitaKey.currentState!.reset();
                    Navigator.of(context).pop();
                    Navigator.pop(context);
                  },
                ),
              );
            }
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              return Form(
                key: citaProvider.formCitaKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: constraints.maxWidth * 0.85,
                      child: FechaForm(
                        validator: (value) {
                          if (value == null) {
                            return 'Ingrese una fecha';
                          }
                          return null;
                        },
                        hintDrop: 'Ingrese una Fecha',
                        hintLabel: 'Fecha',
                        iconDrop: Icons.calendar_today,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: constraints.maxWidth * 0.85,
                      child: TextFormField(
                        controller: myController,
                        onChanged: (value) => citaProvider.comentario = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese un comentario';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        style: const TextStyle(color: Colors.black),
                        decoration: CustomInputs.customInputDecoration(
                          hint: 'Ingrese un comentario',
                          icon: Icons.message_outlined,
                          label: 'Comentario',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomOutlinedButton(
                      onPressed: () {
                        final validForm = citaProvider.validateForm();
                        if (!validForm) return;
                        saveCita();
                      },
                      text: 'Terminar Gestión',
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
