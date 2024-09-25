import 'package:campanas_grid/api/api_campaigns.dart';
import 'package:campanas_grid/models/model_active_campaigns.dart';
import 'package:campanas_grid/models/model_buscador.dart';
import 'package:campanas_grid/models/model_codigo_gestiones.dart';
import 'package:campanas_grid/models/model_ejecutivo_perfil.dart';
import 'package:campanas_grid/models/model_historial_gestiones.dart';
import 'package:campanas_grid/models/model_informacion_oferta.dart';
import 'package:campanas_grid/models/model_prospectos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import '../router/globals.dart' as globals;
import 'package:universal_html/html.dart' as html;

class ProspectosProvider extends ChangeNotifier {
  final GlobalKey<ScaffoldState> prospectosScaffoldKey =
      GlobalKey<ScaffoldState>();

  final GlobalKey<ScaffoldState> buscadorScaffoldKey =
      GlobalKey<ScaffoldState>();

  int counter = 0;
   String? empresa;
   String? selectedSucursal;


  List<ModelProspectos> prospectos = [];
  String numeroSucursal = '0000';
  String nomCampana = '';

  void resetValues() {
    numeroSucursal = '0000';
    nomEmpresa = 'A';
    nomCampana = '';
    isVisible = false;
    empresa = null;
    selectedSucursal = null;
    Future.delayed(Duration.zero, notifyListeners);
  }

  Future<void> getProspectos() async {
    final resp = await ApiCampaigns.httpGet(
      rolePerfil == 'ZONAL' || rolePerfil == 'MAESTRO'
          ? '/cliente/ofertas/informacion?page=$counter&tenantId=$nomEmpresa&sucursal=$numeroSucursal&type=$nomCampana&channel=${globals.channel}'
          : '/cliente/ofertas/informacion?page=$counter&tenantId=${globals.tenantId}&user=${globals.user}&sucursal=${globals.sucursal}&channel=${globals.channel}'
    );
    List<dynamic> dynamicList = resp;
    List<ModelProspectos> prospectosList =
        dynamicList.map((item) => ModelProspectos.fromMap(item)).toList();
    prospectos = prospectosList;
    notifyListeners();
  }

  List<String> campaigns = [];

  getActiveCampaigns() async {
    final resp = await ApiCampaigns.httpGet(
      rolePerfil == 'ZONAL' ||
            rolePerfil == 'MAESTRO'
        ? '/activeCampaigns?tenant=$nomEmpresa&sucursal=$numeroSucursal&channel=${globals.channel}'
        : rolePerfil == 'GERENTE'
            ? '/activeCampaigns?tenant=${globals.tenantId}&sucursal=${globals.sucursal}&channel=${globals.channel}'
            : '/activeCampaigns?tenant=${globals.tenantId}&sucursal=${globals.sucursal}&channel=${globals.channel}&ejecutivo=${globals.user}');
    final activeCampaignsResp = ModelActiveCampaigns.fromMap(resp);
    campaigns = [...activeCampaignsResp.activeCampaigns];
    campaigns.add('ALL');
    notifyListeners();
  }

  List<Sucursale> sucursal = [];
  String nomEmpresa = 'A';
  String rolePerfil = '';

  getSucursal() async {
    final resp = await ApiCampaigns.httpGet(
      nomEmpresa == 'A'
        ? '/ejecutivo/perfil?numEmpleado=${globals.user}&tenantId=${globals.tenantId}&channel=${globals.channel}'
        : '/ejecutivo/perfil?numEmpleado=${globals.user}&tenantId=$nomEmpresa&channel=${globals.channel}');
    final sucursalResp = ModelEjecutivoPerfil.fromMap(resp);
    List<dynamic> myList = [sucursalResp.perfil];
    rolePerfil = myList.join();
    sucursal = [...sucursalResp.sucursales];
    notifyListeners();
  }

  html.IFrameElement iframe = html.IFrameElement();
  void changeIFrameSrc(String newSrc) {
    iframe.src = newSrc;
  }

  int idCliente = 0;
  NumberFormat f = NumberFormat("#,##0.00", "en_US");
  List<ModelInformacionOferta> infOfertas = [];

  bool isLoading = true;
  ModelInformacionOferta? currentJson;

  void updateJson(int id) {
    currentJson = infOfertas.firstWhere((json) => json.id == id);
    notifyListeners();
  }

  getInfOfertas() async {
    final resp = await ApiCampaigns.httpGet(
        '/cliente/informacion/ofertas/$idCliente/${globals.channel}');
    List<dynamic> dynamicList = resp;
    List<ModelInformacionOferta> ofertasList = dynamicList
        .map((item) => ModelInformacionOferta.fromMap(item))
        .toList();
    infOfertas = ofertasList;
    notifyListeners();
  }
  

  List<ModelHistorialGestiones> gestiones = [];

  getHistorialGestiones() async {
    final resp =
        await ApiCampaigns.httpGet('/cliente/historial/gestiones/$idCliente');
    List<dynamic> dynamicList = resp;
    List<ModelHistorialGestiones> gestionesList = dynamicList
        .map((item) => ModelHistorialGestiones.fromMap(item))
        .toList();
    gestiones = gestionesList;
    notifyListeners();
  }

  ModelCodigoGestiones? codGestiones;
  String estatusCliente = '';
  String resultadoGestion = '';
  String respuestaCliente = '';

  getCodigoGestiones() async {
    final resp = await ApiCampaigns.httpGet2(
        '/api/configuration?name=codigos_gestiones_2');
    codGestiones = ModelCodigoGestiones.fromJson(resp);
    notifyListeners();
  }

  bool isVisible = false;

  openInANewTab(url) {
    html.window.open(url, 'Lista prospectos');
  }

  reportDownload() async {
    final urlReporte = rolePerfil == 'ZONAL' || rolePerfil == 'MAESTRO'
        ? '${dotenv.env['URL_CRM_BFF_CAMPANAS']}/sucursal/reporte?tenantId=$nomEmpresa&sucursal=$numeroSucursal&channel=${globals.channel}'
        : '${dotenv.env['URL_CRM_BFF_CAMPANAS']}/sucursal/reporte?tenantId=${globals.tenantId}&sucursal=${globals.sucursal}&channel=${globals.channel}';
    openInANewTab(urlReporte);
  }

  String searchProspecto = "";

  List<ModelProspectos> get prospectos2 => searchProspecto.isEmpty
    ? prospectos 
    : prospectos.where(
        (val) =>
            val.nombreCliente.toLowerCase().contains(searchProspecto.toLowerCase()) ||
            val.numeroCliente.toString().contains(searchProspecto) ||
            val.numeroContrato.toString().contains(searchProspecto),
      ).toList();

  void changeSearchString(String searchString) {
    searchProspecto = searchString;
    Future.delayed(Duration.zero, notifyListeners);
  }

  int? firtsrow = 0;

  GlobalKey<PaginatedDataTableState> keyT =
      GlobalKey<PaginatedDataTableState>();

  
  String infoSearch = '';
  
  List<ModelBuscador> buscador = [];

    Future<void> getBuscador() async {
    final resp = await ApiCampaigns.httpGet(
      rolePerfil == 'EJECUTIVO' || rolePerfil == 'GERENTE'
          ? '/cliente/buscar?info=$infoSearch&canal=${globals.channel}&sucursal=${globals.sucursal}'
          : '/cliente/buscar?info=$infoSearch&canal=${globals.channel}&sucursal=1'
    );
    List<dynamic> dynamicList = resp;
    List<ModelBuscador> buscadorList =
        dynamicList.map((item) => ModelBuscador.fromMap(item)).toList();
    buscador = buscadorList;
    notifyListeners();
  }







}
