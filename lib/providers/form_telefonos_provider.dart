import 'package:campanas_grid/api/api_campaigns.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FormTelefonosProvider extends ChangeNotifier {
  GlobalKey<FormState> formTelefonosKey = GlobalKey<FormState>();
  TextEditingController dateinput = TextEditingController();

  String comentario = '';
  int idOferta = 0;
  String resultado = '';
  String vendedor = '';
  List<String> celulares = [];
  List<String> telefonos = [];
  String estatusCliente = '';
  String respuestaCliente = '';
  String channel = '';

  validateForm() {
    if (formTelefonosKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  Future<Response> registerTelefonos(
    String comentario,
    int idOferta,
    String resultado,
    String vendedor,
    List<String> celulares,
    List<String> telefonos,
    String estatusCliente,
    String respuestaCliente,
    String channel,
  ) async {
    final dataCita = {
      'comentario': comentario,
      'idOferta': idOferta,
      'resultado': resultado,
      'vendedor': vendedor,
      'celulares': celulares,
      'telefonos': telefonos,
      'estatusCliente': estatusCliente,
      'respuestaCliente': respuestaCliente,
      'channel': channel,
    };
    return ApiCampaigns.post('/nuevoTelefono', dataCita);
  }
}
