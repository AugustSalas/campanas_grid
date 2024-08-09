import 'package:campanas_grid/api/api_campaigns.dart';
import 'package:campanas_grid/providers/citas_provider.dart';
import 'package:campanas_grid/providers/gestiones_provider.dart';
import 'package:campanas_grid/providers/prospectos_provider.dart';
import 'package:campanas_grid/ui/shared/components/custom_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:campanas_grid/providers/home_provider.dart';
import 'package:campanas_grid/router/router.dart';
import 'package:campanas_grid/services/navigation_service.dart';
import 'package:campanas_grid/ui/layouts/dashboard_layout.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  ApiCampaigns.configureDio();
  Flurorouter.configureRoutes();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
           ChangeNotifierProvider(
          lazy: false,
          create: (_) => HomeProvider(),
        ),
        ChangeNotifierProvider<ProspectosProvider>(
          lazy: false,
          create: (_) => ProspectosProvider(),
        ),
        ChangeNotifierProxyProvider<ProspectosProvider, CitasProvider>(
          lazy: false,
          create: (context) => CitasProvider(
            Provider.of<ProspectosProvider>(context, listen: false),
          ),
          update: (_, prospectosProvider, citasProvider) =>
              citasProvider!..updateWith(prospectosProvider),
        ),
         ChangeNotifierProxyProvider<ProspectosProvider, GestionesProvider>(
          lazy: false,
          create: (context) => GestionesProvider(
            Provider.of<ProspectosProvider>(context, listen: false),
          ),
          update: (_, prospectosProvider, gestionesProvider) =>
              gestionesProvider!..updateWith(prospectosProvider),
        ),
         
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: CustomScrollBehavior(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        
      ],
      supportedLocales: const [Locale('es')],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 229, 238, 255),
        useMaterial3: true,
        //fontFamily: 'Poppins'
      ),
      title: 'Campañas',
      initialRoute: '/home',
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      builder: (context, child) {
        return Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (context) => DashboardLayout(child: child!),
            )
          ],
        );
      },
    );
  }
}
