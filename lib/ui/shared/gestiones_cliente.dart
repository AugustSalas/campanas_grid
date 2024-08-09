import 'package:campanas_grid/providers/prospectos_provider.dart';
import 'package:campanas_grid/style_labels/style_labels.dart';
import 'package:campanas_grid/ui/shared/components/card_gestiones_info.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GestionesCliente extends StatefulWidget {
  const GestionesCliente({super.key});

  @override
  State<GestionesCliente> createState() => _GestionesClienteState();
}

class _GestionesClienteState extends State<GestionesCliente> {
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
      client.getGestiones();
    });
  } 

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final gestProspecto = Provider.of<ProspectosProvider>(context);

    gestProspecto.gestiones.sort((a, b) => a.fecha.compareTo(b.fecha));

    return gestProspecto.currentJson == null ||
            gestProspecto.currentJson!.idCliente != gestProspecto.idCliente
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
                          const SizedBox(width: 10),
                          Text(
                            gestProspecto.currentJson!.nombreCliente,
                            style: StyleLabels.titleReferencia,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    gestProspecto.gestiones.isEmpty
                        ? const Center(
                            child: Text(
                              "No hay gestiones",
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
                              itemCount: gestProspecto.gestiones.length,
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
                                    child: CardGestionesInfo(
                                      fecha:
                                          gestProspecto.gestiones[index].fecha,
                                      comentario: gestProspecto
                                          .gestiones[index].comentario,
                                      ejecutivo: gestProspecto
                                          .gestiones[index].ejecutivo,
                                      gestion: gestProspecto
                                          .gestiones[index].gestion,
                                      resultado: gestProspecto
                                          .gestiones[index].resultado,
                                      statusCliente: gestProspecto
                                          .gestiones[index].statusCliente,
                                      respuestaCliente: gestProspecto
                                          .gestiones[index].respuestaCliente,
                                      canal:
                                          gestProspecto.gestiones[index].canal,
                                      width: constraints.maxWidth * 0.3,
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
                  ],
                ),
              );
            },
          );
  }
}
