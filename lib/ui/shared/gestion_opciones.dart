import 'package:campanas_grid/providers/prospectos_provider.dart';
import 'package:campanas_grid/style_labels/style_labels.dart';
import 'package:campanas_grid/ui/forms/form_cita.dart';
import 'package:campanas_grid/ui/forms/form_cita_sucursal.dart';
import 'package:campanas_grid/ui/forms/form_comentario.dart';
import 'package:campanas_grid/ui/forms/form_telefonos_view.dart';
import 'package:campanas_grid/ui/shared/buttons/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../router/globals.dart' as globals;

class GestionOpciones extends StatefulWidget {
  const GestionOpciones({super.key});

  @override
  State<GestionOpciones> createState() => _GestionOpcionesState();
}

class _GestionOpcionesState extends State<GestionOpciones> {
  
  final GlobalKey _formGestKey = GlobalKey();

  String? estatusCliente;
  String? opcionRespuesta;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final client = Provider.of<ProspectosProvider>(context, listen: false);
      client.getCodigoGestiones();
    });
  }

  void _scrollToForm() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_formGestKey.currentContext != null) {
        Scrollable.ensureVisible(
          _formGestKey.currentContext!,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final prospectos = Provider.of<ProspectosProvider>(context);

    final List<String> arrayStatus = prospectos.codGestiones == null
        ? []
        : globals.tenantId == 'AFI'
            ? prospectos.codGestiones!.configuration.afi.statusCliente
            : globals.tenantId == 'FISA'
                ? prospectos.codGestiones!.configuration.fisa.statusCliente
                : prospectos.codGestiones!.configuration.aef.statusCliente;

    final List<String> arraySinContacto = prospectos.codGestiones == null
        ? []
        : globals.tenantId == 'AFI'
            ? prospectos.codGestiones!.configuration.afi.sinContacto
            : globals.tenantId == 'FISA'
                ? prospectos.codGestiones!.configuration.fisa.sinContacto
                : prospectos.codGestiones!.configuration.aef.sinContacto;

    final List<String> arrayTercero = prospectos.codGestiones == null
        ? []
        : globals.tenantId == 'AFI'
            ? prospectos.codGestiones!.configuration.afi.terceros
            : globals.tenantId == 'FISA'
                ? prospectos.codGestiones!.configuration.fisa.terceros
                : prospectos.codGestiones!.configuration.aef.terceros;

    final List<String> arrayTitular = prospectos.codGestiones == null
        ? []
        : globals.tenantId == 'AFI'
            ? prospectos.codGestiones!.configuration.afi.titular
            : globals.tenantId == 'FISA'
                ? prospectos.codGestiones!.configuration.fisa.titular
                : prospectos.codGestiones!.configuration.aef.titular;

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
              return Column(
                children: [
                  const SizedBox(height: 10),
                  Text('Gestión de llamada', style: StyleLabels.titulo),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomDropdown(
                        width: constraints.maxWidth * 0.6,
                        height: 50,
                        hintDrop: 'Estatus cliente',
                        onChanged: (value) {
                          setState(() {
                            estatusCliente = value as String;
                            prospectos.estatusCliente = value;
                            opcionRespuesta = null;
                          });
                        },
                        selectedValue: estatusCliente,
                        data: arrayStatus,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  estatusCliente == null
                      ? const SizedBox.shrink()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomDropdown(
                              width: constraints.maxWidth * 0.6,
                              height: 50,
                              hintDrop: 'Respuesta',
                              onChanged: (value) {
                                setState(() {
                                  opcionRespuesta = value as String;
                                  prospectos.resultadoGestion = value;
                                  prospectos.respuestaCliente = value;
                                  estatusCliente = null;
                                   _scrollToForm();
                                });
                              },
                              selectedValue: opcionRespuesta,
                              data: estatusCliente == 'Sin contacto'
                                  ? arraySinContacto
                                  : estatusCliente == 'Tercero'
                                      ? arrayTercero
                                      : arrayTitular,
                            ),
                          ],
                        ),
                  opcionRespuesta == 'Cita' ||
                          opcionRespuesta == 'CITA TELEFONICA'
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(opcionRespuesta!, style: StyleLabels.dataCellResumen),
                            const SizedBox(height: 10),
                             FormCita(key: _formGestKey)
                          ],
                        )
                      : opcionRespuesta == 'Nuevo teléfono'
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(opcionRespuesta!,
                                    style: StyleLabels.dataCellResumen),
                                const SizedBox(height: 10),
                                 FormTelefonosView(key: _formGestKey)
                              ],
                            )
                          : opcionRespuesta == 'Oferta aceptada'
                              ? Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(opcionRespuesta!,
                                        style: StyleLabels.dataCellResumen),
                                    const SizedBox(height: 10),
                                    const Text('Aqui la oferta aceptada')
                                  ],
                                )
                              : opcionRespuesta == 'Cita sucursal' ||
                                      opcionRespuesta == 'CITA TELEFONICA'
                                  ? Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(opcionRespuesta!,
                                            style: StyleLabels.dataCellResumen),
                                        const SizedBox(height: 10),
                                        FormCitaSucursal(key: _formGestKey)
                                      ],
                                    )
                                  : opcionRespuesta == null
                                      ? const SizedBox.shrink()
                                      : Column(
                                          children: [
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(opcionRespuesta!,
                                                style: StyleLabels.dataCellResumen),
                                            const SizedBox(height: 10),
                                            FormComentario(key: _formGestKey)
                                          ],
                                        ),
                ],
              );
            },
          );
  }
}
