import 'package:campanas_grid/api/api_campaigns.dart';
import 'package:campanas_grid/models/model_periodos.dart';
import 'package:campanas_grid/models/model_resumen_gest_suc.dart';
import 'package:campanas_grid/providers/prospectos_provider.dart';
import 'package:flutter/material.dart';
import '../router/globals.dart' as globals;


class ResumenGestionesProvider extends ChangeNotifier {

  ProspectosProvider prospectosProvider;

  ResumenGestionesProvider(this.prospectosProvider);

    void updateWith(ProspectosProvider newProspectosProvider) {
    prospectosProvider = newProspectosProvider;
    notifyListeners();
  }

  List<String> periodos = [];
  String nomPeriodo = '';
  String? selectedPeriodo;

  getPeriodos() async {
    final resp = await ApiCampaigns.httpGet(
      prospectosProvider.nomEmpresa == 'A'
        ? '/activePeriods?tenant=${globals.tenantId}&sucursal=${globals.sucursal}&channel=${globals.channel}'
        : '/activePeriods?&tenant=${prospectosProvider.nomEmpresa}&sucursal=${prospectosProvider.numeroSucursal}&channel=${globals.channel}');
    final periodosResp = ModelPeriodos.fromMap(resp);
    periodos = [...periodosResp.periodos];
    notifyListeners();
  }

  List<ModelResumenGestSuc> gestionesSucursal = [];

  getGestionesSuc() async {
    final resp = await ApiCampaigns.httpGet(
      prospectosProvider.rolePerfil == 'GERENTE'
       ? '/gestiones_sucursal?tenantId=${globals.tenantId}&sucursal=${globals.sucursal}&channel=${globals.channel}&periodo=$nomPeriodo'
       : '/gestiones_sucursal?tenantId=${prospectosProvider.nomEmpresa}&sucursal=${prospectosProvider.numeroSucursal}&channel=${globals.channel}&periodo=$nomPeriodo');
    List<dynamic> dynamicList = resp;
    List<ModelResumenGestSuc> gestSucList = dynamicList
        .map((item) => ModelResumenGestSuc.fromMap(item))
        .toList();
    gestionesSucursal = gestSucList;
    notifyListeners();
  }
}