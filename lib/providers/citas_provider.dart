import 'package:campanas_grid/api/api_campaigns.dart';
import 'package:campanas_grid/models/model_cliente_citas.dart';
import 'package:campanas_grid/providers/prospectos_provider.dart';
import 'package:flutter/material.dart';
import '../router/globals.dart' as globals;

class CitasProvider extends ChangeNotifier {
  
  ProspectosProvider prospectosProvider;

  CitasProvider(this.prospectosProvider);

   void updateWith(ProspectosProvider newProspectosProvider) {
    prospectosProvider = newProspectosProvider;
    notifyListeners();
  }

  List<ModelClienteCitas> citas = [];

  getCitas() async {
    final resp = await ApiCampaigns.httpGet(
      prospectosProvider.rolePerfil == 'ZONAL' || prospectosProvider.rolePerfil == 'MAESTRO'
        ? 
        '/cliente/citas?tenantId=${prospectosProvider.nomEmpresa}&sucursal=${prospectosProvider.numeroSucursal}&type=ALL'
        : prospectosProvider.rolePerfil == 'GERENTE'
            ? '/cliente/citas?tenantId=${globals.tenantId}&sucursal=${globals.sucursal}&type=ALL'
            : '/cliente/citas?tenantId=${globals.tenantId}&sucursal=${globals.sucursal}&type=ALL&channel=${globals.channel}');
    //'/cliente/citas?numEmpleado=${globals.user}&tenantId=${globals.tenantId}&channel=${globals.channel}');
    List<dynamic> dynamicList = resp;
    List<ModelClienteCitas> citasList =
        dynamicList.map((item) => ModelClienteCitas.fromMap(item)).toList();
    citas = citasList;
    notifyListeners();
  }
}
