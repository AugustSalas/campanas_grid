import 'package:campanas_grid/api/api_campaigns.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FormReferenciasProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController dateinput = TextEditingController();

  int cliente = 0;
  String nombre = '';
  String apellidoMat = '';
  String apellidoPat = '';
  String telefono = '';
  String? tipoPlan;

  validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  Future<Response> registerReferencias(
    int cliente,
    String nombre,
    String apellidoMat,
    String apellidoPat,
    String telefono,
    String? tipoPlan,
  ) async {
    final dataCita = {
      'cliente':cliente,
      'referencias':{
      'nombre': nombre,
      'apellidoMat': apellidoMat,
      'apellidoPat': apellidoPat,
      'telefono': telefono,
      'tipoPlan': tipoPlan,
       }
    };
    
    return ApiCampaigns.post('/agregarReferencia', dataCita);
  }
  }

