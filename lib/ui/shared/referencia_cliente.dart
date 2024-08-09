import 'package:campanas_grid/providers/prospectos_provider.dart';
import 'package:campanas_grid/style_labels/style_labels.dart';
import 'package:campanas_grid/ui/forms/form_referencias_view.dart';
import 'package:campanas_grid/ui/shared/buttons/custom_outlined_button.dart';
import 'package:campanas_grid/ui/shared/components/card_referencias_info.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReferenciaCliente extends StatefulWidget {
  const ReferenciaCliente({super.key});

  @override
  State<ReferenciaCliente> createState() => _ReferenciaClienteState();
}

class _ReferenciaClienteState extends State<ReferenciaCliente> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _formKey = GlobalKey();
  bool isVisible = false;
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

  void _scrollToForm() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_formKey.currentContext != null) {
        Scrollable.ensureVisible(
          _formKey.currentContext!,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final refProspecto = Provider.of<ProspectosProvider>(context);

    return refProspecto.currentJson == null ||
            refProspecto.currentJson!.idCliente != refProspecto.idCliente
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
                controller: _scrollController,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.account_circle_outlined,
                            color: Color.fromARGB(255, 0, 117, 213),
                            size: 28,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            refProspecto.currentJson!.nombreCliente,
                            style: StyleLabels.titleReferencia,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                      refProspecto.currentJson!.referencias.isEmpty
                        ? const Center(
                            child: Text(
                              "No hay referencias",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 68, 68, 68),
                              ),
                            ),
                          )
                      : SizedBox(
                      height: screenSize.width > 1280 || screenSize.width < 450
                          ? constraints.maxHeight * 0.4
                          : constraints.maxHeight * 0.6,
                      width: screenSize.width > 450
                          ? constraints.maxWidth * 0.85
                          : constraints.maxWidth * 0.95,
                      child: Swiper(
                              itemCount:
                                  refProspecto.currentJson!.referencias.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  color:
                                      const Color.fromARGB(255, 229, 238, 255),
                                  elevation: 4.0,
                                  shadowColor:
                                      const Color.fromARGB(137, 0, 0, 0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                      color:
                                          const Color.fromARGB(255, 68, 68, 68)
                                              .withOpacity(0.4),
                                      width: 2,
                                    ), // Borde de la tarjeta
                                  ),
                                  margin: const EdgeInsets.all(10.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: CardReferenciasInfo(
                                      width: constraints.maxWidth * 0.3,
                                      nombre: refProspecto.currentJson!
                                          .referencias[index].nombre,
                                      apellidoMat: refProspecto.currentJson!
                                          .referencias[index].apellidoMat,
                                      apellidoPat: refProspecto.currentJson!
                                          .referencias[index].apellidoPat,
                                      telefono: refProspecto.currentJson!
                                          .referencias[index].numsContacto
                                          .map((e) => e.telefono)
                                          .join(),
                                      tipoPlan: refProspecto.currentJson!
                                          .referencias[index].numsContacto
                                          .map((e) => e.tipoPlan)
                                          .join(),
                                      idCatParentesco: refProspecto.currentJson!
                                          .referencias[index].idCatParentesco
                                          .toString(),
                                    ),
                                  ),
                                );
                              },
                              pagination: const SwiperPagination(
                                builder: DotSwiperPaginationBuilder(
                                  activeColor: Color.fromARGB(255, 0, 117, 213),
                                  color: Colors.grey,
                                  size: 10.0,
                                  activeSize: 12.0,
                                ),
                              ),
                              control: const SwiperControl(
                                padding: EdgeInsets.only(right: 5, left: 12),
                                color: Color.fromARGB(255, 0, 117, 213),
                              ),
                            ),
                    ),
                    const SizedBox(height: 20),
                    CustomOutlinedButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                          _scrollToForm();
                        });
                      },
                      text: 'Nueva referencia',
                    ),
                    const SizedBox(height: 20),
                    isVisible
                        ? FormReferenciasView(
                            key: _formKey,
                            idCliente: refProspecto.currentJson!.idCliente)
                        : const SizedBox.shrink(),
                  ],
                ),
              );
            },
          );
  }
}
