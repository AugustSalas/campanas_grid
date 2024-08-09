import 'dart:convert';
import 'package:campanas_grid/providers/prospectos_provider.dart';
import 'package:campanas_grid/router/router.dart';
import 'package:campanas_grid/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../../router/globals.dart' as globals;
import 'package:universal_html/html.dart' as html;
import 'package:http/http.dart' as http;

class AceptarOferta {
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 10),
              Text("Por favor espera..."),
            ],
          ),
        );
      },
    );
  }

  static Future<void> enviarSolicitud(
      BuildContext context, String idOferta) async {
    void navigateTo(String routeName) {
      NavigationService.replaceTo(routeName);
    }

    showLoadingDialog(context); // Muestra la alerta de espera

    final url = Uri.parse('${dotenv.env['URL_CRM_BFF_CAMPANAS']}/oferta');
    final body = jsonEncode({
      'idOferta': idOferta,
      'numEmp': globals.user,
      'channel': globals.channel
    });
    final headers = {'Content-Type': 'application/json'};

    final response = await http.post(url, headers: headers, body: body);
    // ignore: use_build_context_synchronously
    Navigator.pop(context); // Cierra la alerta de espera

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final responseData = jsonDecode(response.body);
      final idSolicitud = responseData['idSolicitud'];

      if (responseData['success'] == true) {
        QuickAlert.show(
          // ignore: use_build_context_synchronously
          context: context,
          type: QuickAlertType.success,
          title: 'Éxito',
          text: 'La oferta fue aceptada correctamente.',
          confirmBtnText: 'Aceptar',
          confirmBtnColor: const Color.fromRGBO(0, 117, 213, 1),
          onConfirmBtnTap: () {
            var url =
                '${dotenv.env['URL_FINDEP_HAWKING']}?id=$idSolicitud&isFlow=true';
            html.window.location.replace(url);
          },
        );
      } else {
        QuickAlert.show(
          // ignore: use_build_context_synchronously
          context: context,
          type: QuickAlertType.error,
          text: 'Ocurrió un error al generar la solicitud',
          confirmBtnText: 'Aceptar',
          confirmBtnColor: const Color.fromRGBO(0, 117, 213, 1),
          onConfirmBtnTap: () {
            Navigator.pop(context);
            // Navigator.pushNamed(
            //   context,
            //   '/prospectos?tenantId=${globals.tenantId}&user=${globals.user}&sucursal=${globals.sucursal}&type=${globals.type}&channel=${globals.channel}',
            // );
            navigateTo(
              '${Flurorouter.prospectosRoute}?tenantId=${globals.tenantId}&user=${globals.user}&sucursal=${globals.sucursal}&type=${globals.type}&channel=${globals.channel}',
            );
          },
        );
      }
    } else {
      final responseBody = json.decode(utf8.decode(response.bodyBytes));
      final errorMessage = responseBody['error'] ?? 'Error desconocido';

      QuickAlert.show(
        // ignore: use_build_context_synchronously
        context: context,
        type: QuickAlertType.error,
        text: errorMessage,
        confirmBtnText: 'Aceptar',
        confirmBtnColor: const Color.fromRGBO(0, 117, 213, 1),
        onConfirmBtnTap: () {
          Navigator.pop(context);
          // Navigator.pushNamed(
          //   context,
          //   '/prospectos?tenantId=${globals.tenantId}&user=${globals.user}&sucursal=${globals.sucursal}&type=${globals.type}&channel=${globals.channel}',
          // );
          navigateTo(
            '${Flurorouter.prospectosRoute}?tenantId=${globals.tenantId}&user=${globals.user}&sucursal=${globals.sucursal}&type=${globals.type}&channel=${globals.channel}',
          );
        },
      );
    }
  }

  static void show(BuildContext context, String idOferta) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      title: '¿Quieres aceptar la oferta?',
      confirmBtnText: 'Aceptar',
      cancelBtnText: 'Cancelar',
      confirmBtnColor: const Color.fromRGBO(0, 117, 213, 1),
      showCancelBtn: true,
      width: 530,
      onConfirmBtnTap: () {
        Navigator.pop(context);
        enviarSolicitud(context, idOferta);
      },
      onCancelBtnTap: () {
        Navigator.pop(context);
      },
    );
  }
}

class AcceptOfferView extends StatefulWidget {
  const AcceptOfferView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AcceptOfferViewState createState() => _AcceptOfferViewState();
}

class _AcceptOfferViewState extends State<AcceptOfferView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var idOferta =
          Provider.of<ProspectosProvider>(context, listen: false).currentJson;
      AceptarOferta.show(context, idOferta!.id.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: null,
      body: Center(),
    );
  }
}
