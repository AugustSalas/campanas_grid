import 'package:campanas_grid/providers/prospectos_provider.dart';
import 'package:campanas_grid/providers/resumen_gestiones_provider.dart';
import 'package:campanas_grid/style_labels/style_labels.dart';
import 'package:campanas_grid/ui/shared/buttons/custom_dropdown.dart';
import 'package:campanas_grid/ui/shared/buttons/custom_dropdown_double.dart';
import 'package:campanas_grid/ui/shared/components/card_resumen.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectsResumen extends StatefulWidget {
  final double width;
  final Function(dynamic) onChanged;
  final Function(dynamic) onChanged2;

  const SelectsResumen({
    super.key,
    required this.width,
    required this.onChanged,
    required this.onChanged2,
  });

  @override
  State<SelectsResumen> createState() => _SelectsResumenState();
}

class _SelectsResumenState extends State<SelectsResumen> {
  @override
  Widget build(BuildContext context) {
    final resumen = Provider.of<ResumenGestionesProvider>(context);
    final Size screenSize = MediaQuery.of(context).size;

    final List<String> arrayEmpresa = [
      'AEF',
      'FISA',
    ];

    List<String> meses = [
      "Enero",
      "Febrero",
      "Marzo",
      "Abril",
      "Mayo",
      "Junio",
      "Julio",
      "Agosto",
      "Septiembre",
      "Octubre",
      "Noviembre",
      "Diciembre"
    ];

    List<String> periodoCompuesto = resumen.periodos.map((periodo) {
      String tipo = "";
      String mes = "";
      String cod = "";

      if (periodo.startsWith("CPL")) {
        tipo = "Complemento";
      } else if (periodo.startsWith("INI")) {
        tipo = "Inicial";
      }

      mes = meses[int.parse(periodo.substring(3, 5)) - 1];
      cod = periodo.substring(5);

      return "$tipo-$mes-$cod";
    }).toList();

    return Column(
      children: [
        CustomDropdown(
          hintDrop: 'Empresa',
          onChanged: (value) {
            setState(() {
              widget.onChanged(value);
            });
          },
          width: widget.width,
          height: 49,
          selectedValue: resumen.prospectosProvider.empresa,
          data: arrayEmpresa,
        ),
        const SizedBox(height: 10),
        DropSearchSucursales(
          width: widget.width,
          height: 50,
          empresa: resumen.prospectosProvider.empresa,
          onChanged2: (value) {
            setState(() {
              widget.onChanged2(value);
            });
          },
        ),
        const SizedBox(height: 10),
        CustomDropdownDouble(
          width: screenSize.width > 430 ? screenSize.width * 0.27: screenSize.width * 0.60,
          hintDrop: 'Periodo',
          length: resumen.periodos.length,
          onChanged: (value) {
            setState(() {
              resumen.selectedPeriodo = value as String;
              resumen.nomPeriodo = resumen.selectedPeriodo!;
              resumen.getGestionesSuc();
            });
          },
          selectedValue: resumen.selectedPeriodo,
          data: resumen.periodos,
          data2: periodoCompuesto,
        ),
        const SizedBox(height: 20),
        resumen.periodos.isEmpty
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
              width: screenSize.width > 430 ? screenSize.width * 0.3: screenSize.width * 0.95,
              height: screenSize.height *  0.42,
              child: Swiper(
                  itemCount: resumen.gestionesSucursal.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: const Color.fromARGB(255, 229, 238, 255),
                      elevation: 4.0,
                      shadowColor: const Color.fromARGB(137, 0, 0, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: const Color.fromARGB(255, 68, 68, 68)
                              .withOpacity(0.4),
                          width: 2,
                        ), // Borde de la tarjeta
                      ),
                      margin: const EdgeInsets.all(10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CardResumen(
                          campana: resumen.gestionesSucursal[index].campaign,
                          asignadas: resumen.gestionesSucursal[index].total,
                          gestionadas: resumen.gestionesSucursal[index].gestionadas,
                          noGestionadas: resumen.gestionesSucursal[index].noGestionadas,
                          citas: resumen.gestionesSucursal[index].citas,
                          dispuestas: resumen.gestionesSucursal[index].aprobadas,
                          avanceGestion: resumen.gestionesSucursal[index].avance,
                          width:  screenSize.width > 430 ? screenSize.width * 0.13 : screenSize.width * 0.16,
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
    );
  }
}

// ignore: must_be_immutable
class DropSearchSucursales extends StatefulWidget {
  final double width;
  final double height;
  String? empresa;
  final Function(dynamic) onChanged2;

  DropSearchSucursales({
    super.key,
    required this.width,
    required this.height,
    this.empresa,
    required this.onChanged2,
  });

  @override
  State<DropSearchSucursales> createState() => _DropSearchSucursalesState();
}

class _DropSearchSucursalesState extends State<DropSearchSucursales> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProspectosProvider>(context, listen: false).getSucursal();
  }

  @override
  Widget build(BuildContext context) {
    final prospectos = Provider.of<ProspectosProvider>(context);
    return DropdownSearch<dynamic>(
      enabled: widget.empresa != null,
      dropdownDecoratorProps: DropDownDecoratorProps(
        baseStyle: StyleLabels.itemDrop,
        dropdownSearchDecoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          label: Text('Sucursales',
              style: widget.empresa != null
                  ? StyleLabels.textoDrop2
                  : StyleLabels.textoDrop3),
          suffixIconColor: widget.empresa != null
              ? const Color.fromARGB(255, 68, 68, 68)
              : const Color.fromARGB(255, 160, 155, 155),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 68, 68, 68),
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 160, 155, 155),
            ),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 68, 68, 68),
              )),
          constraints: BoxConstraints(
            maxWidth: widget.width,
            maxHeight: widget.height,
          ),
        ),
      ),
      popupProps: const PopupProps.menu(
          searchFieldProps: TextFieldProps(), showSearchBox: true),
      items: widget.empresa == null
          ? []
          : prospectos.sucursal
              .map((e) => '${e.descripcionSucursal} - ${e.noSucursal}')
              .toList(),
      onChanged: (value) {
        setState(() {
          widget.onChanged2(value);
        });
      },
      selectedItem: prospectos.selectedSucursal,
    );
  }
}
