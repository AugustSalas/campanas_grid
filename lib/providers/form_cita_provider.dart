import 'package:campanas_grid/api/api_campaigns.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FormCitaProvider extends ChangeNotifier {
  GlobalKey<FormState> formCitaKey = GlobalKey<FormState>();
  TextEditingController dateinput = TextEditingController();

  String comentario = '';
  int idOferta = 0;
  String resultado = '';
  String vendedor = '';
  String fechaHora = '';
  String medioContacto = '';
  String estatusCliente = '';
  String respuestaCliente = '';
  String channel = '';

  validateForm() {
    if (formCitaKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  Future<Response> registerCita(
    String comentario,
    int idOferta,
    String resultado,
    String vendedor,
    String fechaHora,
    String medioContacto,
    String estatusCliente,
    String respuestaCliente,
    String channel,
  ) async {
    final dataCita = {
      'comentario': comentario,
      'idOferta': idOferta,
      'resultado': resultado,
      'vendedor': vendedor,
      'fechaHora': fechaHora,
      'medioContacto': medioContacto,
      'estatusCliente': estatusCliente,
      'respuestaCliente': respuestaCliente,
      'channel':channel,
    };

    return ApiCampaigns.post('/cita', dataCita);
  }
}