import 'package:campanas_grid/providers/home_provider.dart';
import 'package:campanas_grid/ui/shared/citas_calendario.dart';
import 'package:campanas_grid/ui/views/citas_view.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:campanas_grid/ui/views/home.dart';
import 'package:campanas_grid/ui/views/table_info_menu.dart';
import 'package:campanas_grid/ui/views/table_resumen_view.dart';
import 'package:provider/provider.dart';
import '../router/globals.dart' as globals;


class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static String homeRoute = '/home';
  static String prospectosRoute = '/prospectos';
  static String resumenRoute = '/resumen';
  static String citasRoute = '/citas';

  static void configureRoutes() {
    router.define('/',
        handler: _handlerUrl, transitionType: TransitionType.fadeIn);

    router.define(homeRoute,
        handler: home, transitionType: TransitionType.fadeIn);

    router.define(prospectosRoute,
        handler: prospectos, transitionType: TransitionType.fadeIn);

    router.define(resumenRoute,
        handler: resumen, transitionType: TransitionType.fadeIn);
    
    router.define(citasRoute,
        handler: citas, transitionType: TransitionType.fadeIn);
  }

  static final Handler _handlerUrl = Handler(
    handlerFunc: (context, params) => const Center(
      child: CircularProgressIndicator(
        color: Colors.black,
      ),
    ),
  );

  static Handler home = Handler(handlerFunc: (context, params) {
    globals.sucursal = params['sucursal']?[0];
    globals.user = params['user']?[0];
    globals.channel = params['channel']?[0];
    globals.tenantId = params['tenantId']?[0];
    globals.type = params['type']?[0];
    final home = Provider.of<HomeProvider>(context!);
    String result = homeRoute.replaceAll(RegExp('/'), '');
    home.screenMenu = '${result[0].toUpperCase()}${result.substring(1)}';
    return const Home();
  });

  static Handler prospectos = Handler(handlerFunc: (context, params) {
    globals.sucursal = params['sucursal']?[0];
    globals.user = params['user']?[0];
    globals.channel = params['channel']?[0];
    globals.tenantId = params['tenantId']?[0];
    globals.type = params['type']?[0];
    final home = Provider.of<HomeProvider>(context!);
    String result = prospectosRoute.replaceAll(RegExp('/'), '');
    home.screenMenu = '${result[0].toUpperCase()}${result.substring(1)}';
    return const TableInfoMenu();
  });

   static Handler resumen = Handler(handlerFunc: (context, params) {
    globals.sucursal = params['sucursal']?[0];
    globals.user = params['user']?[0];
    globals.channel = params['channel']?[0];
    globals.tenantId = params['tenantId']?[0];
    globals.type = params['type']?[0];
    return const TableResumenView();
  });

  static Handler citas = Handler(handlerFunc: (context, params) {
    globals.sucursal = params['sucursal']?[0];
    globals.user = params['user']?[0];
    globals.tenantId = params['tenantId']?[0];
    globals.type = params['type']?[0];
    globals.channel = params['channel']?[0];
    final home = Provider.of<HomeProvider>(context!);
    String result = citasRoute.replaceAll(RegExp('/'), '');
    home.screenMenu = '${result[0].toUpperCase()}${result.substring(1)}';
    return const CitasView();
  });
}
