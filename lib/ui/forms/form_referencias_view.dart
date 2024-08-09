// ignore_for_file: use_build_context_synchronously

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:campanas_grid/providers/form_referencias_providers.dart';
import 'package:campanas_grid/ui/shared/buttons/custom_outlined_button.dart';
import 'package:campanas_grid/ui/shared/buttons/dropdown_form.dart';
import 'package:campanas_grid/ui/shared/components/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FormReferenciasView extends StatefulWidget {
  final int idCliente;

  const FormReferenciasView({
    super.key,
    required this.idCliente,
  });

  @override
  State<FormReferenciasView> createState() => _FormReferenciasViewState();
}

class _FormReferenciasViewState extends State<FormReferenciasView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FormReferenciasProvider(),
      child: Builder(builder: (context) {
        final referenciaProvider =
            Provider.of<FormReferenciasProvider>(context, listen: false);

        final List<String> tips = ['Celular', 'Teléfono fijo'];

        void saveReferencia() async {
          try {
            final response = await referenciaProvider.registerReferencias(
              referenciaProvider.cliente = widget.idCliente,
              referenciaProvider.nombre,
              referenciaProvider.apellidoPat,
              referenciaProvider.apellidoMat,
              referenciaProvider.telefono,
              referenciaProvider.tipoPlan,
            );

            if (response.statusCode == 200) {
              ArtSweetAlert.show(
                context: context,
                artDialogArgs: ArtDialogArgs(
                  type: ArtSweetAlertType.success,
                  title: "Guardado",
                  onConfirm: () {
                    referenciaProvider.formKey.currentState!.reset();
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
                  text: "No se pudo guardar la referencia.",
                  onConfirm: () {
                    referenciaProvider.formKey.currentState!.reset();
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
                text: "Ocurrió un error al guardar la referencia.",
                onConfirm: () {
                  referenciaProvider.formKey.currentState!.reset();
                  Navigator.of(context).pop();
                  Navigator.pop(context);
                },
              ),
            );
          }
        }

        return LayoutBuilder(builder: (context, constraints) {
          return Form(
            key: referenciaProvider.formKey,
            child: Column(
              children: [
                SizedBox(
                  width: constraints.maxWidth * 0.85,
                  child: TextFormField(
                    //controller: referenciaProvider.dateinput,
                    onChanged: (value) => referenciaProvider.nombre = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese un nombre';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: CustomInputs.customInputDecoration(
                      hint: 'Ingrese un nombre',
                      icon: Icons.person,
                      label: 'Nombre',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: constraints.maxWidth * 0.85,
                  child: TextFormField(
                    //controller: referenciaProvider.dateinput,
                    onChanged: (value) =>
                        referenciaProvider.apellidoPat = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese el apellido paterno';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: CustomInputs.customInputDecoration(
                      hint: 'Ingrese el apellido paterno',
                      icon: Icons.person,
                      label: 'Apellido paterno',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: constraints.maxWidth * 0.85,
                  child: TextFormField(
                    //controller: referenciaProvider.dateinput,
                    onChanged: (value) =>
                        referenciaProvider.apellidoMat = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese el apellido materno';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: CustomInputs.customInputDecoration(
                      hint: 'Ingrese el apellido materno',
                      icon: Icons.person,
                      label: 'Apellido materno',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: constraints.maxWidth * 0.85,
                  child: TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese un télefono';
                      }
                      return null;
                    },
                    //controller: referenciaProvider.dateinput,
                    onChanged: (value) => referenciaProvider.telefono = value,
                    //obscureText: true,
                    decoration: CustomInputs.customInputDecoration(
                      hint: 'Ingresa el télefono',
                      icon: Icons.phone_android_outlined,
                      label: 'Télefono',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: constraints.maxWidth * 0.85,
                  child: DropdownForm(
                    hintDrop: 'Ingrese tipo de teléfono',
                    iconDrop: Icons.article_rounded,
                    hintLabel: 'Tipo de teléfono',
                    selectedValue: referenciaProvider.tipoPlan,
                    data: tips,
                    onChanged: (value) {
                      setState(() {
                        referenciaProvider.tipoPlan = value as String;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese un tipo de teléfono';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                CustomOutlinedButton(
                  onPressed: () {
                    final validForm = referenciaProvider.validateForm();
                    if (!validForm) return;
                    saveReferencia();
                  },
                  text: 'Agregar referencia',
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        });
      }),
    );
  }
}
