import 'package:campanas_grid/api/api_campaigns.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FormComentarioProvider extends ChangeNotifier {
  GlobalKey<FormState> formComentarioKey = GlobalKey<FormState>();

  int idOferta = 0;
  String comentario = '';
  String vendedor = '';
  String resultado = '';
  String estatusCliente = '';
  String respuestaCliente = '';
  String channel = '';

  validateForm() {
    if (formComentarioKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  Future<Response> registerComentario(
    String comentario,
    int idOferta,
    String resultado,
    String vendedor,
    String estatusCliente,
    String respuestaCliente,
    String channel,
  ) async {
    final data = {
      'comentario': comentario,
      'idOferta': idOferta,
      'resultado': resultado,
      'vendedor': vendedor,
      'estatusCliente': estatusCliente,
      'respuestaCliente': respuestaCliente,
      'channel': channel,
    };

   return ApiCampaigns.post('/comentario', data);
  }
}
