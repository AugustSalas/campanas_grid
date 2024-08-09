// ignore_for_file: use_build_context_synchronously

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:campanas_grid/providers/form_comentario_provider.dart';
import 'package:campanas_grid/providers/prospectos_provider.dart';
import 'package:campanas_grid/ui/shared/buttons/custom_outlined_button.dart';
import 'package:campanas_grid/ui/shared/components/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../router/globals.dart' as globals;

class FormComentario extends StatefulWidget {
  const FormComentario({super.key});

  @override
  State<FormComentario> createState() => _FormComentarioState();
}

class _FormComentarioState extends State<FormComentario> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FormComentarioProvider(),
      child: Builder(
        builder: (context) {
          final prospectos =
              Provider.of<ProspectosProvider>(context, listen: false);

          final comentario =
              Provider.of<FormComentarioProvider>(context, listen: false);
          final myController = TextEditingController();

          void saveComentario() async {
            try {
              final response = await comentario.registerComentario(
                comentario.comentario,
                comentario.idOferta = prospectos.currentJson!.id,
                comentario.resultado = prospectos.resultadoGestion,
                comentario.vendedor = globals.user!,
                comentario.estatusCliente = prospectos.estatusCliente,
                comentario.respuestaCliente = prospectos.respuestaCliente,
                comentario.channel = globals.channel!,
              );

              if (response.statusCode == 200) {
                ArtSweetAlert.show(
                  context: context,
                  artDialogArgs: ArtDialogArgs(
                    type: ArtSweetAlertType.success,
                    title: "Guardado",
                    onConfirm: () {
                      comentario.formComentarioKey.currentState!.reset();
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
                    text: "No se pudo guardar el comentario.",
                   onConfirm: () {
                      comentario.formComentarioKey.currentState!.reset();
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
                  text: "Ocurrió un error al guardar el comentario.",
                  onConfirm: () {
                      comentario.formComentarioKey.currentState!.reset();
                      Navigator.of(context).pop();
                      Navigator.pop(context);
                    },
                ),
              );
            }
          }

          return LayoutBuilder(builder: (context, constraints) {
            return Form(
              key: comentario.formComentarioKey,
              child: Column(
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.85,
                    child: TextFormField(
                      controller: myController,
                      onChanged: (value) => comentario.comentario = value,
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
                      final validForm = comentario.validateForm();
                      if (!validForm) return;
                      saveComentario();
                    },
                    text: 'Terminar Gestión',
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          });
        },
      ),
    );
  }
}
