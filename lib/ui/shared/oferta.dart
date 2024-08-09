import 'package:campanas_grid/providers/prospectos_provider.dart';
import 'package:campanas_grid/style_labels/style_labels.dart';
import 'package:campanas_grid/ui/shared/buttons/button_detail.dart';
import 'package:campanas_grid/ui/shared/components/aceptar_oferta.dart';
import 'package:campanas_grid/ui/shared/components/dialog_ofert.dart';
import 'package:campanas_grid/ui/shared/components/row_text_ofertas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import '../../router/globals.dart' as globals;

class Oferta extends StatefulWidget {
  const Oferta({super.key});

  @override
  State<Oferta> createState() => OfertaState();
}

class OfertaState extends State<Oferta> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final client = Provider.of<ProspectosProvider>(context, listen: false);
      client.getInfOfertas().then((_) {
        if (!mounted) return;
        if (client.infOfertas.isNotEmpty) {
          setState(() {
            client.currentJson = client.infOfertas.first;
          });
        }
      });
    });
  }

  final Widget iframeWidget = HtmlElementView(
    viewType: 'iframeElement',
    key: UniqueKey(),
  );

  @override
  Widget build(BuildContext context) {
    final prospectos = Provider.of<ProspectosProvider>(context);

    final number = prospectos.currentJson == null
        ? ''
        : prospectos.currentJson!.idCliente.toString();

    final numCeros = 12 - number.length;
    var number2 = 0;
    String formattedNumber = number2.toString().padLeft(numCeros, '0');
    String cliente = formattedNumber + number;

    prospectos.iframe.src =
        '${dotenv.env['URL_CORE_WEB_CLIENTS']}/#/card?client=$cliente';

    prospectos.iframe.style.border = 'none';
// ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
      (int viewId) => prospectos.iframe,
    );
    return prospectos.currentJson == null ||
            prospectos.currentJson!.idCliente != prospectos.idCliente
        ? const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 0, 117, 213),
              ),
            ),
          )
        : LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text('Información Detallada', style: StyleLabels.titulo),
                    const SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      width: constraints.maxWidth * 0.85,
                      height: 200,
                      child: Stack(
                        children: [
                          iframeWidget,
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const DialogOfert(),
                    const SizedBox(height: 10),
                    Text('Nuevo Crédito', style: StyleLabels.titulo),
                    const SizedBox(height: 10),
                    RowTextOfertas(
                      title: 'Vigencia',
                      data: prospectos.currentJson!.vigencia,
                      width: constraints.maxWidth * 0.4,
                      style: StyleLabels.detalle,
                    ),
                    const SizedBox(height: 10),
                    RowTextOfertas(
                      title: 'Producto',
                      data: prospectos.currentJson!.productoRenovar,
                      width: constraints.maxWidth * 0.4,
                      style: StyleLabels.detalle,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 35,
                      width: constraints.maxWidth * 0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 0, 125, 252),
                      ),
                      child: RowTextOfertas(
                        title: 'Crédito',
                        data: globals.tenantId == 'AFI RENO' ||
                                globals.tenantId == 'AFI'
                            ? '${prospectos.f.format(prospectos.currentJson!.montoCreditoRenovacion)} USD'
                            : '\$ ${prospectos.f.format(prospectos.currentJson!.montoCreditoRenovacion)} MXN',
                        width: constraints.maxWidth * 0.4,
                        style: StyleLabels.resaltado,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 35,
                      width: constraints.maxWidth * 0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 0, 125, 252),
                      ),
                      child: RowTextOfertas(
                        title: 'Monto a pagar',
                        data: globals.tenantId == 'AFI RENO' ||
                                globals.tenantId == 'AFI'
                            ? '${prospectos.f.format(prospectos.currentJson!.montoPagoRenovacion)} USD'
                            : '\$ ${prospectos.f.format(prospectos.currentJson!.montoPagoRenovacion)} MXN',
                        width: constraints.maxWidth * 0.4,
                        style: StyleLabels.resaltado,
                      ),
                    ),
                    const SizedBox(height: 10),
                    RowTextOfertas(
                      title: 'Plazo a pagar',
                      data: prospectos.currentJson!.plazoRenovacion,
                      width: constraints.maxWidth * 0.4,
                      style: StyleLabels.detalle,
                    ),
                    const SizedBox(height: 10),
                    RowTextOfertas(
                      title: 'Frecuencia',
                      data: prospectos.currentJson!.frecuenciaARenovar,
                      width: constraints.maxWidth * 0.4,
                      style: StyleLabels.detalle,
                    ),
                    const SizedBox(height: 10),
                    RowTextOfertas(
                      title: 'Tasa oferta',
                      data: '${prospectos.currentJson!.tasaOferta}',
                      width: constraints.maxWidth * 0.4,
                      style: StyleLabels.detalle,
                    ),
                    const SizedBox(height: 10),
                    prospectos.currentJson!.campaign.contains("ILC") ||
                            prospectos.currentJson!.campaign.contains("ilc")
                        ? RowTextOfertas(
                            title: 'Monto disponible',
                            data: globals.tenantId == 'AFI RENO' ||
                                    globals.tenantId == 'AFI'
                                ? '${prospectos.f.format(prospectos.currentJson!.montoDisponible)} USD'
                                : '\$ ${prospectos.f.format(prospectos.currentJson!.montoDisponible)} MXN',
                            width: constraints.maxWidth * 0.4,
                            style: StyleLabels.detalle,
                          )
                        : Column(
                            children: [
                              RowTextOfertas(
                                title: 'Dinero nuevo',
                                data: globals.tenantId == 'AFI RENO' ||
                                        globals.tenantId == 'AFI'
                                    ? '${prospectos.f.format(prospectos.currentJson!.newMoney)} USD'
                                    : '\$ ${prospectos.f.format(prospectos.currentJson!.newMoney)} MXN',
                                width: constraints.maxWidth * 0.4,
                                style: StyleLabels.detalle,
                              ),
                              const SizedBox(height: 10),
                              RowTextOfertas(
                                title: 'Saldo a liquidar',
                                data: globals.tenantId == 'AFI RENO' ||
                                        globals.tenantId == 'AFI'
                                    ? '${prospectos.f.format(prospectos.currentJson!.saldoLiquidar)} USD'
                                    : '\$ ${prospectos.f.format(prospectos.currentJson!.saldoLiquidar)} MXN',
                                width: constraints.maxWidth * 0.4,
                                style: StyleLabels.detalle,
                              ),
                            ],
                          ),
                    const SizedBox(height: 10),
                    RowTextOfertas(
                      title: 'Próximo a liquidar',
                      data: prospectos.currentJson!.proxLiquidar,
                      width: constraints.maxWidth * 0.4,
                      style: StyleLabels.detalle,
                    ),
                    const SizedBox(height: 20),
                    Text('Último Crédito', style: StyleLabels.titulo2),
                    const SizedBox(height: 10),
                    RowTextOfertas(
                      title: 'Producto',
                      data: prospectos.currentJson!.productoActual,
                      width: constraints.maxWidth * 0.4,
                      style: StyleLabels.detalle2,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 35,
                      width: constraints.maxWidth * 0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey,
                      ),
                      child: RowTextOfertas(
                        title: 'Monto del Crédito',
                        data: globals.tenantId == 'AFI RENO' ||
                                globals.tenantId == 'AFI'
                            ? '${prospectos.f.format(prospectos.currentJson!.montoCreditoActual)} USD'
                            : '\$ ${prospectos.f.format(prospectos.currentJson!.montoCreditoActual)} MXN',
                        width: constraints.maxWidth * 0.4,
                        style: StyleLabels.resaltado2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 35,
                      width: constraints.maxWidth * 0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey,
                      ),
                      child: RowTextOfertas(
                        title: 'Monto a Pagar',
                        data: globals.tenantId == 'AFI RENO' ||
                                globals.tenantId == 'AFI'
                            ? '${prospectos.f.format(prospectos.currentJson!.montoPagoActual)} USD'
                            : '\$ ${prospectos.f.format(prospectos.currentJson!.montoPagoActual)} MXN',
                        width: constraints.maxWidth * 0.4,
                        style: StyleLabels.resaltado2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    RowTextOfertas(
                      title: 'Plazo a pagar',
                      data: prospectos.currentJson!.plazoActual,
                      width: constraints.maxWidth * 0.4,
                      style: StyleLabels.detalle2,
                    ),
                    const SizedBox(height: 10),
                    RowTextOfertas(
                      title: 'Frecuencia',
                      data: prospectos.currentJson!.frecuenciaActual,
                      width: constraints.maxWidth * 0.4,
                      style: StyleLabels.detalle2,
                    ),
                    const SizedBox(height: 10),
                    RowTextOfertas(
                      title: 'Tasa actual',
                      data: '${prospectos.currentJson!.tasaActual}',
                      width: constraints.maxWidth * 0.4,
                      style: StyleLabels.detalle2,
                    ),
                    const SizedBox(height: 10),
                    prospectos.currentJson!.campaign.contains("ILC") ||
                            prospectos.currentJson!.campaign.contains("ilc")
                        ? RowTextOfertas(
                            title: 'Monto disponible actual',
                            data: globals.tenantId == 'AFI RENO' ||
                                    globals.tenantId == 'AFI'
                                ? '${prospectos.f.format(prospectos.currentJson!.montoDisponibleActual)} USD'
                                : '\$ ${prospectos.f.format(prospectos.currentJson!.montoDisponibleActual)} MXN',
                            width: constraints.maxWidth * 0.4,
                            style: StyleLabels.detalle2,
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonDetail(
                          onPressed: () {
                            var idOferta = prospectos.currentJson!.id;
                            AceptarOferta.show(context, idOferta.toString());
                          },
                          textButton: 'Aceptar Oferta',
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              );
            },
          );
  }
}
