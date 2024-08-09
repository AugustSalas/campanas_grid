import 'package:campanas_grid/api/api_campaigns.dart';
import 'package:campanas_grid/models/model_gestiones.dart';
import 'package:campanas_grid/providers/prospectos_provider.dart';
import 'package:flutter/material.dart';
import '../router/globals.dart' as globals;


class GestionesProvider extends ChangeNotifier {

   ProspectosProvider prospectosProvider;

  GestionesProvider(this.prospectosProvider);

   void updateWith(ProspectosProvider newProspectosProvider) {
    prospectosProvider = newProspectosProvider;
    notifyListeners();
  }

  final GlobalKey<ScaffoldState> gestionesScaffoldKey =
      GlobalKey<ScaffoldState>();
  
   

  List<ModelGestiones> gestiones = [];

  getGestiones() async {
    final resp = await ApiCampaigns.httpGet(
      prospectosProvider.rolePerfil == 'GERENTE' 
        ? 
        '/cliente/gestiones?page=${prospectosProvider.counter}&tenantId=${globals.tenantId}&sucursal=${globals.sucursal}&type=${globals.type}'
        : prospectosProvider.rolePerfil == 'ZONAL' || prospectosProvider.rolePerfil == 'MAESTRO'
            ? '/cliente/gestiones?page=${prospectosProvider.counter}&tenantId=${prospectosProvider.nomEmpresa}&sucursal=${prospectosProvider.numeroSucursal}&type=${globals.type}'
            : '/cliente/gestiones?page=${prospectosProvider.counter}&tenantId=${globals.tenantId}&sucursal=${globals.sucursal}&type=${globals.type}&user=${globals.user}');
    
    List<dynamic> dynamicList = resp;
    List<ModelGestiones> gestionesList =
        dynamicList.map((item) => ModelGestiones.fromMap(item)).toList();
    gestiones = gestionesList;
    notifyListeners();
  }

    GlobalKey<PaginatedDataTableState> keyT =
      GlobalKey<PaginatedDataTableState>();


}