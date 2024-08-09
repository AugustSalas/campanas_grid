// ignore_for_file: use_build_context_synchronously

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:campanas_grid/providers/form_telefonos_provider.dart';
import 'package:campanas_grid/providers/prospectos_provider.dart';
import 'package:campanas_grid/ui/shared/buttons/custom_outlined_button.dart';
import 'package:campanas_grid/ui/shared/components/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../../router/globals.dart' as globals;

class FormTelefonosView extends StatefulWidget {
  const FormTelefonosView({
    super.key,
  });
  @override
  // ignore: library_private_types_in_public_api
  _FormTelefonosViewState createState() => _FormTelefonosViewState();
}

class _FormTelefonosViewState extends State<FormTelefonosView> {
  TextEditingController textarea = TextEditingController();
  TextEditingController nameController = TextEditingController();
  static List<String> phoneList = [''];
  TextEditingController nameController2 = TextEditingController();
  static List<String> phoneList2 = [''];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    nameController2 = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    nameController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FormTelefonosProvider(),
      child: Builder(builder: (context) {
        final telefonoProvider =
            Provider.of<FormTelefonosProvider>(context, listen: false);

        return Center(
          child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: buildForm(telefonoProvider)),
        );
      }),
    );
  }

  LayoutBuilder buildForm(FormTelefonosProvider telProvider) {
    final prospectos = Provider.of<ProspectosProvider>(context, listen: false);
    return LayoutBuilder(builder: (context, constraints) {
      void saveTelefonos() async {
        try {
          final response = await telProvider.registerTelefonos(
            textarea.text,
            prospectos.currentJson!.id,
            prospectos.resultadoGestion,
            globals.user!,
            phoneList,
            phoneList2,
            telProvider.estatusCliente = prospectos.estatusCliente,
            telProvider.respuestaCliente = prospectos.respuestaCliente,
            globals.channel!,
          );

          if (response.statusCode == 200) {
            ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.success,
                title: "Guardado",
                onConfirm: () {
                  telProvider.formTelefonosKey.currentState!.reset();
                  phoneList = [''];
                  phoneList = [''];
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
                text: "No se pudo guardar los télefonos.",
                onConfirm: () {
                  telProvider.formTelefonosKey.currentState!.reset();
                  phoneList = [''];
                  phoneList = [''];
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
              text: "Ocurrió un error al guardar los télefonos.",
              onConfirm: () {
                telProvider.formTelefonosKey.currentState!.reset();
                phoneList = [''];
                phoneList = [''];
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
            ),
          );
        }
      }

      return Form(
        key: telProvider.formTelefonosKey,
        child: Column(
          children: [
            ..._getPhones(),
            const SizedBox(height: 10),
            ..._getPhones2(),
            const SizedBox(height: 20),
            SizedBox(
              width: constraints.maxWidth * 0.85,
              child: TextFormField(
                controller: textarea,
                onChanged: (value) => telProvider.comentario = value,
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
                final validForm = telProvider.validateForm();
                if (!validForm) return;
                saveTelefonos();
              },
              text: 'Terminar Gestión',
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    });
  }

  /// get firends text-fields
  List<Widget> _getPhones() {
    List<Widget> friendsTextFields = [];
    for (int i = 0; i < phoneList.length; i++) {
      friendsTextFields.add(
        LayoutBuilder(builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth * 0.85,
            child: Row(
              children: [
                Expanded(child: PhoneFields(i)),
                _addRemoveButton(i == phoneList.length - 1, i),
              ],
            ),
          );
        }),
      );
    }
    return friendsTextFields;
  }

  List<Widget> _getPhones2() {
    List<Widget> friendsTextFields = [];
    for (int i = 0; i < phoneList2.length; i++) {
      friendsTextFields.add(
        LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth * 0.85,
              child: Row(
                children: [
                  Expanded(child: PhoneFields2(i)),
                  _addRemoveButton2(i == phoneList2.length - 1, i),
                ],
              ),
            );
          },
        ),
      );
    }
    return friendsTextFields;
  }

  /// add / remove button
  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          phoneList.insert(0, '');
        } else {
          phoneList.removeAt(index);
        }
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: (add) ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            (add) ? Icons.add : Icons.remove,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _addRemoveButton2(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          phoneList2.insert(0, '');
        } else {
          phoneList2.removeAt(index);
        }
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: (add) ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            (add) ? Icons.add : Icons.remove,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class PhoneFields extends StatefulWidget {
  final int index;
  const PhoneFields(this.index, {super.key});
  @override
  // ignore: library_private_types_in_public_api
  _PhoneFieldsState createState() => _PhoneFieldsState();
}

class _PhoneFieldsState extends State<PhoneFields> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = _FormTelefonosViewState.phoneList[widget.index];
    });

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        validator: (v) {
          if (v!.trim().isEmpty) return 'Agrega un celular';
          return null;
        },
        controller: _nameController,
        onChanged: (v) => _FormTelefonosViewState.phoneList[widget.index] = v,
        //obscureText: true,
        decoration: CustomInputs.customInputDecoration(
            hint: 'Ingresa el celular',
            icon: Icons.phone_iphone,
            label: 'Celular'),
      ),
    );
  }
}

class PhoneFields2 extends StatefulWidget {
  final int index;
  const PhoneFields2(this.index, {super.key});
  @override
  // ignore: library_private_types_in_public_api
  _PhoneFields2State createState() => _PhoneFields2State();
}

class _PhoneFields2State extends State<PhoneFields2> {
  late TextEditingController _nameController2;

  @override
  void initState() {
    super.initState();
    _nameController2 = TextEditingController();
  }

  @override
  void dispose() {
    _nameController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController2.text = _FormTelefonosViewState.phoneList2[widget.index];
    });

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        validator: (v) {
          if (v!.trim().isEmpty) return 'Agrega un télefono';
          return null;
        },
        controller: _nameController2,
        onChanged: (v) => _FormTelefonosViewState.phoneList2[widget.index] = v,
        //obscureText: true,
        decoration: CustomInputs.customInputDecoration(
            hint: 'Ingresa el télefono', icon: Icons.phone, label: 'Télefono'),
      ),
    );
  }
}
