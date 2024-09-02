import 'package:campanas_grid/providers/prospectos_provider.dart';
import 'package:campanas_grid/style_labels/style_labels.dart';
import 'package:campanas_grid/ui/datatable_source/prospectos_source.dart';
import 'package:campanas_grid/ui/shared/buttons/custom_dropdown.dart';
import 'package:campanas_grid/ui/shared/components/page_counter.dart';
import 'package:campanas_grid/ui/shared/components/search_text.dart';
import 'package:campanas_grid/ui/shared/components/selects_emp_suc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TableProspectos extends StatefulWidget {
  const TableProspectos({super.key});

  @override
  State<TableProspectos> createState() => _TableProspectosState();
}

class _TableProspectosState extends State<TableProspectos> {
  String? selectedCampaigns;
  int currentSortColumn = 0;
  bool isAscending = true;
  int rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  final ScrollController horizontal = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final prospectosProvider =
          Provider.of<ProspectosProvider>(context, listen: false);
      prospectosProvider.resetValues();
      prospectosProvider.getSucursal();
      prospectosProvider.getActiveCampaigns();
      prospectosProvider.getProspectos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final prospectos = Provider.of<ProspectosProvider>(context);

    void removeProspecto() {
      setState(() {
        prospectos.counter--;
        prospectos.getProspectos();
      });
    }

    void addProspecto() {
      setState(() {
        prospectos.counter++;
        prospectos.getProspectos();
      });
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              prospectos.rolePerfil == 'ZONAL' ||
                      prospectos.rolePerfil == 'MAESTRO'
                  ? SelectsEmpSuc(
                      width: size.width > 770
                          ? constraints.maxWidth * 0.20
                          : constraints.maxWidth * 0.45,
                      onChanged: (value) {
                        setState(() {
                          prospectos.empresa = value as String?;
                          if (prospectos.empresa != null) {
                            prospectos.nomEmpresa = prospectos.empresa!;
                            prospectos.getSucursal();
                            prospectos.isVisible = false;
                            prospectos.keyT.currentState?.pageTo(0);
                          }
                        });
                      },
                      onChanged2: (value) {
                        setState(() {
                          prospectos.selectedSucursal = value.toString();
                          if (prospectos.selectedSucursal != null) {
                            RegExp regExp = RegExp(r'\d+$');
                            String? match = regExp
                                .stringMatch(prospectos.selectedSucursal!);
                            if (match != null) {
                              prospectos.numeroSucursal = match;
                              prospectos.getProspectos();
                              prospectos.getActiveCampaigns();
                              prospectos.keyT.currentState?.pageTo(0);
                              prospectos.isVisible = true;
                            }
                          }
                        });
                      },
                    )
                  : Row(
                      children: [
                        SizedBox(width: constraints.maxWidth * 0.013),
                        TextButton.icon(
                          onPressed: () {
                            prospectos.reportDownload();
                          },
                          label: Text(
                            'Lista prospectos',
                            style: StyleLabels.dataColumn,
                          ),
                          icon: const Icon(
                            Icons.download_rounded,
                            color: Color.fromARGB(255, 68, 68, 68),
                          ),
                        ),
                      ],
                    ),
              const SizedBox(height: 10),
              Scrollbar(
                controller: horizontal,
                thumbVisibility: true,
                trackVisibility: true,
                child: PaginatedDataTable(
                  key: prospectos.keyT,
                  header: Row(
                    children: [
                      SizedBox(
                        width: constraints.maxWidth * 0.30,
                        child: SearchText(
                          onChanged: (value) {
                            setState(() {
                              prospectos.changeSearchString(value);
                            });
                          },
                          hint: 'Buscar Prospecto',
                        ),
                      ),
                      const Spacer(),
                      CustomDropdown(
                        hintDrop: 'Campañas',
                        onChanged: (value) {
                          setState(() {
                            selectedCampaigns = value as String;
                            prospectos.nomCampana = selectedCampaigns!;
                            prospectos.firtsrow;
                            prospectos.getProspectos();
                          });
                        },
                        width: size.width > 770
                            ? constraints.maxWidth * 0.20
                            : constraints.maxWidth * 0.45,
                        height: 40,
                        selectedValue: selectedCampaigns,
                        data: prospectos.campaigns,
                      ),
                      SizedBox(width: constraints.maxWidth * 0.01),
                      PageCounter(
                        add: addProspecto,
                        remove: removeProspecto,
                      ),
                      //SizedBox(width: 20),
                    ],
                  ),
                  controller: horizontal,
                  initialFirstRowIndex: prospectos.firtsrow,
                  sortColumnIndex: currentSortColumn,
                  sortAscending: isAscending,
                  columns: [
                    DataColumn(
                      label: Text(
                        'PROPENSIDAD',
                        style: StyleLabels.dataColumn2,
                      ),
                      onSort: (columnIndex, _) {
                        setState(
                          () {
                            currentSortColumn = columnIndex;
                            if (isAscending == true) {
                              isAscending = false;
                              prospectos.prospectos.sort((a, b) =>
                                  a.propensidad.compareTo(b.propensidad));
                            } else {
                              isAscending = true;
                              prospectos.prospectos.sort((a, b) =>
                                  b.propensidad.compareTo(a.propensidad));
                            }
                          },
                        );
                      },
                    ),
                    DataColumn(
                      label: Text(
                        'N° CLIENTE',
                        textAlign: TextAlign.center,
                        style: StyleLabels.dataColumn2,
                      ),
                      onSort: (columnIndex, _) {
                        setState(
                          () {
                            currentSortColumn = columnIndex;
                            if (isAscending == true) {
                              isAscending = false;
                              prospectos.prospectos.sort((a, b) =>
                                  a.numeroCliente.compareTo(b.numeroCliente));
                            } else {
                              isAscending = true;
                              prospectos.prospectos.sort((a, b) =>
                                  b.numeroCliente.compareTo(a.numeroCliente));
                            }
                          },
                        );
                      },
                    ),
                    DataColumn(
                      label: Text(
                        'NOMBRE CLIENTE',
                        style: StyleLabels.dataColumn2,
                      ),
                      onSort: (columnIndex, _) {
                        setState(
                          () {
                            currentSortColumn = columnIndex;
                            if (isAscending == true) {
                              isAscending = false;
                              prospectos.prospectos.sort((a, b) =>
                                  a.nombreCliente.compareTo(b.nombreCliente));
                            } else {
                              isAscending = true;
                              prospectos.prospectos.sort((a, b) =>
                                  b.nombreCliente.compareTo(a.nombreCliente));
                            }
                          },
                        );
                      },
                    ),
                    DataColumn(
                      label: Text(
                        'N° CONTRATO',
                        style: StyleLabels.dataColumn2,
                      ),
                      onSort: (columnIndex, _) {
                        setState(
                          () {
                            currentSortColumn = columnIndex;
                            if (isAscending == true) {
                              isAscending = false;
                              prospectos.prospectos.sort((a, b) =>
                                  a.numeroContrato.compareTo(b.numeroContrato));
                            } else {
                              isAscending = true;
                              prospectos.prospectos.sort((a, b) =>
                                  b.numeroContrato.compareTo(a.numeroContrato));
                            }
                          },
                        );
                      },
                    ),
                    DataColumn(
                      label: Text(
                        'CAMPAÑA',
                        style: StyleLabels.dataColumn2,
                      ),
                      onSort: (columnIndex, _) {
                        setState(
                          () {
                            currentSortColumn = columnIndex;
                            if (isAscending == true) {
                              isAscending = false;
                              prospectos.prospectos.sort((a, b) =>
                                  a.nombreCampana.compareTo(b.nombreCampana));
                            } else {
                              isAscending = true;
                              prospectos.prospectos.sort((a, b) =>
                                  b.nombreCampana.compareTo(a.nombreCampana));
                            }
                          },
                        );
                      },
                    ),
                    DataColumn(
                      label: Text(
                        'PROMOCIONES',
                        style: StyleLabels.dataColumn2,
                      ),
                      onSort: (columnIndex, _) {
                        setState(
                          () {
                            currentSortColumn = columnIndex;
                            if (isAscending == true) {
                              isAscending = false;
                              prospectos.prospectos
                                  .sort((a, b) => a.promos.compareTo(b.promos));
                            } else {
                              isAscending = true;
                              prospectos.prospectos
                                  .sort((a, b) => b.promos.compareTo(a.promos));
                            }
                          },
                        );
                      },
                    ),
                    DataColumn(
                      label: Text(
                        'PRODUCTO SUGERIDO',
                        style: StyleLabels.dataColumn2,
                      ),
                      onSort: (columnIndex, _) {
                        setState(
                          () {
                            currentSortColumn = columnIndex;
                            if (isAscending == true) {
                              isAscending = false;
                              prospectos.prospectos.sort((a, b) => a
                                  .productoSugerido
                                  .compareTo(b.productoSugerido));
                            } else {
                              isAscending = true;
                              prospectos.prospectos.sort((a, b) => b
                                  .productoSugerido
                                  .compareTo(a.productoSugerido));
                            }
                          },
                        );
                      },
                    ),
                    DataColumn(
                      label: Text(
                        'MONTO A DISPONER',
                        style: StyleLabels.dataColumn2,
                      ),
                      onSort: (columnIndex, _) {
                        setState(
                          () {
                            currentSortColumn = columnIndex;
                            if (isAscending == true) {
                              isAscending = false;
                              prospectos.prospectos.sort((a, b) =>
                                  a.montoADisponer.compareTo(b.montoADisponer));
                            } else {
                              isAscending = true;
                              prospectos.prospectos.sort((a, b) =>
                                  b.montoADisponer.compareTo(a.montoADisponer));
                            }
                          },
                        );
                      },
                    ),
                    DataColumn(
                      label: Text(
                        'MONTO PAGO',
                        style: StyleLabels.dataColumn2,
                      ),
                      onSort: (columnIndex, _) {
                        setState(
                          () {
                            currentSortColumn = columnIndex;
                            if (isAscending == true) {
                              isAscending = false;
                              prospectos.prospectos.sort((a, b) =>
                                  a.montoEstimado.compareTo(b.montoEstimado));
                            } else {
                              isAscending = true;
                              prospectos.prospectos.sort((a, b) =>
                                  b.montoEstimado.compareTo(a.montoEstimado));
                            }
                          },
                        );
                      },
                    ),
                    DataColumn(
                      label: Text(
                        'PLAZO SUGERIDO',
                        style: StyleLabels.dataColumn2,
                      ),
                      onSort: (columnIndex, _) {
                        setState(
                          () {
                            currentSortColumn = columnIndex;
                            if (isAscending == true) {
                              isAscending = false;
                              prospectos.prospectos.sort((a, b) =>
                                  a.plazoSugerido.compareTo(b.plazoSugerido));
                            } else {
                              isAscending = true;
                              prospectos.prospectos.sort((a, b) =>
                                  b.plazoSugerido.compareTo(a.plazoSugerido));
                            }
                          },
                        );
                      },
                    ),
                    DataColumn(
                      label: Text(
                        'FRECUENCIA PAGO \n SUGERIDO',
                        style: StyleLabels.dataColumn2,
                      ),
                      onSort: (columnIndex, _) {
                        setState(
                          () {
                            currentSortColumn = columnIndex;
                            if (isAscending == true) {
                              isAscending = false;
                              prospectos.prospectos.sort((a, b) => a
                                  .frecuenciaPagoSugerido
                                  .compareTo(b.frecuenciaPagoSugerido));
                            } else {
                              isAscending = true;
                              prospectos.prospectos.sort((a, b) => b
                                  .frecuenciaPagoSugerido
                                  .compareTo(a.frecuenciaPagoSugerido));
                            }
                          },
                        );
                      },
                    ),
                    DataColumn(
                      label: Text(
                        'VIGENCIA',
                        style: StyleLabels.dataColumn2,
                      ),
                      onSort: (columnIndex, _) {
                        setState(
                          () {
                            currentSortColumn = columnIndex;
                            if (isAscending == true) {
                              isAscending = false;
                              prospectos.prospectos.sort((a, b) =>
                                  a.fechaTermino.compareTo(b.fechaTermino));
                            } else {
                              isAscending = true;
                              prospectos.prospectos.sort((a, b) =>
                                  b.fechaTermino.compareTo(a.fechaTermino));
                            }
                          },
                        );
                      },
                    ),
                    DataColumn(
                      label: Text(
                        'DÍAS SIN \n GESTIÓN',
                        style: StyleLabels.dataColumn2,
                      ),
                      onSort: (columnIndex, _) {
                        setState(
                          () {
                            currentSortColumn = columnIndex;
                            if (isAscending == true) {
                              isAscending = false;
                              prospectos.prospectos.sort((a, b) =>
                                  a.diasSinGestion.compareTo(b.diasSinGestion));
                            } else {
                              isAscending = true;
                              prospectos.prospectos.sort((a, b) =>
                                  b.diasSinGestion.compareTo(a.diasSinGestion));
                            }
                          },
                        );
                      },
                    ),
                    DataColumn(
                      label: Text(
                        'FECHA ÚLTIMA \n GESTIÓN',
                        style: StyleLabels.dataColumn2,
                      ),
                      onSort: (columnIndex, _) {
                        setState(
                          () {
                            currentSortColumn = columnIndex;
                            if (isAscending == true) {
                              isAscending = false;
                              prospectos.prospectos.sort((a, b) => a
                                  .fechaDeUltimaGestion
                                  .compareTo(b.fechaDeUltimaGestion));
                            } else {
                              isAscending = true;
                              prospectos.prospectos.sort((a, b) => b
                                  .fechaDeUltimaGestion
                                  .compareTo(a.fechaDeUltimaGestion));
                            }
                          },
                        );
                      },
                    ),
                    DataColumn(
                      label: Text(
                        'RESULTADO ÚLTIMA \n GESTIÓN',
                        style: StyleLabels.dataColumn2,
                      ),
                      onSort: (columnIndex, _) {
                        setState(
                          () {
                            currentSortColumn = columnIndex;
                            if (isAscending == true) {
                              isAscending = false;
                              prospectos.prospectos.sort((a, b) => a
                                  .resultadoUltimaGestion
                                  .compareTo(b.resultadoUltimaGestion));
                            } else {
                              isAscending = true;
                              prospectos.prospectos.sort((a, b) => b
                                  .resultadoUltimaGestion
                                  .compareTo(a.resultadoUltimaGestion));
                            }
                          },
                        );
                      },
                    ),
                    DataColumn(
                      label: Text(
                        'INTENTOS DE \n CONTACTO',
                        style: StyleLabels.dataColumn2,
                      ),
                      onSort: (columnIndex, _) {
                        setState(
                          () {
                            currentSortColumn = columnIndex;
                            if (isAscending == true) {
                              isAscending = false;
                              prospectos.prospectos.sort((a, b) => a
                                  .intentosDeContacto
                                  .compareTo(b.intentosDeContacto));
                            } else {
                              isAscending = true;
                              prospectos.prospectos.sort((a, b) => b
                                  .intentosDeContacto
                                  .compareTo(a.intentosDeContacto));
                            }
                          },
                        );
                      },
                    ),
                    DataColumn(
                      label: Text(
                        'FECHA INICIO',
                        style: StyleLabels.dataColumn2,
                      ),
                      onSort: (columnIndex, _) {
                        setState(
                          () {
                            currentSortColumn = columnIndex;
                            if (isAscending == true) {
                              isAscending = false;
                              prospectos.prospectos.sort((a, b) =>
                                  a.fechaInicio.compareTo(b.fechaInicio));
                            } else {
                              isAscending = true;
                              prospectos.prospectos.sort((a, b) =>
                                  b.fechaInicio.compareTo(a.fechaInicio));
                            }
                          },
                        );
                      },
                    ),
                    DataColumn(
                      label: Text(
                        'NOMBRE DEL EJECUTIVO',
                        style: StyleLabels.dataColumn2,
                      ),
                      onSort: (columnIndex, _) {
                        setState(
                          () {
                            currentSortColumn = columnIndex;
                            if (isAscending == true) {
                              isAscending = false;
                              prospectos.prospectos.sort((a, b) => a
                                  .nombreDelEjecutivo
                                  .compareTo(b.nombreDelEjecutivo));
                            } else {
                              isAscending = true;
                              prospectos.prospectos.sort((a, b) => b
                                  .nombreDelEjecutivo
                                  .compareTo(a.nombreDelEjecutivo));
                            }
                          },
                        );
                      },
                    ),
                    DataColumn(
                      label: Text(
                        'N° SUCURSAL',
                        style: StyleLabels.dataColumn2,
                      ),
                      onSort: (columnIndex, _) {
                        setState(
                          () {
                            currentSortColumn = columnIndex;
                            if (isAscending == true) {
                              isAscending = false;
                              prospectos.prospectos.sort((a, b) =>
                                  a.numeroSucursal.compareTo(b.numeroSucursal));
                            } else {
                              isAscending = true;
                              prospectos.prospectos.sort((a, b) =>
                                  b.numeroSucursal.compareTo(a.numeroSucursal));
                            }
                          },
                        );
                      },
                    ),
                    DataColumn(
                      label: Text(
                        'PERIODO',
                        style: StyleLabels.dataColumn2,
                      ),
                      onSort: (columnIndex, _) {
                        setState(
                          () {
                            currentSortColumn = columnIndex;
                            if (isAscending == true) {
                              isAscending = false;
                              prospectos.prospectos.sort(
                                  (a, b) => a.periodo.compareTo(b.periodo));
                            } else {
                              isAscending = true;
                              prospectos.prospectos.sort(
                                  (a, b) => b.periodo.compareTo(a.periodo));
                            }
                          },
                        );
                      },
                    ),
                    DataColumn(
                      label: Text(
                        'TIPO OFERTA',
                        style: StyleLabels.dataColumn2,
                      ),
                      onSort: (columnIndex, _) {
                        setState(
                          () {
                            currentSortColumn = columnIndex;
                            if (isAscending == true) {
                              isAscending = false;
                              prospectos.prospectos.sort((a, b) =>
                                  a.tipoOferta.compareTo(b.tipoOferta));
                            } else {
                              isAscending = true;
                              prospectos.prospectos.sort((a, b) =>
                                  b.tipoOferta.compareTo(a.tipoOferta));
                            }
                          },
                        );
                      },
                    ),
                    DataColumn(
                      label: Text(
                        'OBSERVACIONES',
                        style: StyleLabels.dataColumn2,
                      ),
                      onSort: (columnIndex, _) {
                        setState(
                          () {
                            currentSortColumn = columnIndex;
                            if (isAscending == true) {
                              isAscending = false;
                              prospectos.prospectos.sort((a, b) =>
                                  a.observaciones.compareTo(b.observaciones));
                            } else {
                              isAscending = true;
                              prospectos.prospectos.sort((a, b) =>
                                  b.observaciones.compareTo(a.observaciones));
                            }
                          },
                        );
                      },
                    ),
                    DataColumn(
                      label: Text(
                        'APP CLIENTE',
                        style: StyleLabels.dataColumn2,
                      ),
                      onSort: (columnIndex, _) {
                        setState(
                          () {
                            currentSortColumn = columnIndex;
                            if (isAscending == true) {
                              isAscending = false;
                              prospectos.prospectos.sort((a, b) =>
                                  a.appCliente.compareTo(b.appCliente));
                            } else {
                              isAscending = true;
                              prospectos.prospectos.sort((a, b) =>
                                  b.appCliente.compareTo(a.appCliente));
                            }
                          },
                        );
                      },
                    ),
                    DataColumn(
                      label: Text(
                        'SEGUROS',
                        style: StyleLabels.dataColumn2,
                      ),
                      onSort: (columnIndex, _) {
                        setState(
                          () {
                            currentSortColumn = columnIndex;
                            if (isAscending == true) {
                              isAscending = false;
                              prospectos.prospectos.sort((a, b) => a.seguros
                                  .join(',')
                                  .compareTo(b.seguros.join(',')));
                            } else {
                              isAscending = true;
                              prospectos.prospectos.sort((a, b) => b.seguros
                                  .join(',')
                                  .compareTo(a.seguros.join(',')));
                            }
                          },
                        );
                      },
                    ),
                  ],
                  source: ProspectosSource(prospectos.prospectos2, context),
                  onRowsPerPageChanged: (value) {
                    setState(() {
                      rowsPerPage = value!;
                    });
                  },
                  rowsPerPage: rowsPerPage,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
