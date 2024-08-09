import 'package:campanas_grid/providers/gestiones_provider.dart';
import 'package:campanas_grid/style_labels/style_labels.dart';
import 'package:campanas_grid/ui/datatable_source/gestiones_source.dart';
import 'package:campanas_grid/ui/shared/components/page_counter.dart';
import 'package:campanas_grid/ui/shared/components/selects_emp_suc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TablesGestiones extends StatefulWidget {
  const TablesGestiones({super.key});

  @override
  State<TablesGestiones> createState() => _TablesGestionesState();
}

class _TablesGestionesState extends State<TablesGestiones> {
  int currentSortColumn = 0;
  bool isAscending = true;
  int rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  final ScrollController horizontal = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final gestionesProvider =
          Provider.of<GestionesProvider>(context, listen: false);
      gestionesProvider.prospectosProvider.resetValues();
      gestionesProvider.getGestiones();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final gestiones = Provider.of<GestionesProvider>(context);

    void removeGestion() {
      setState(() {
        gestiones.prospectosProvider.counter--;
        gestiones.getGestiones();
      });
    }

    void addGestion() {
      setState(() {
        gestiones.prospectosProvider.counter++;
        gestiones.getGestiones();
      });
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              gestiones.prospectosProvider.rolePerfil == 'ZONAL' ||
                      gestiones.prospectosProvider.rolePerfil == 'MAESTRO'
                  ? Padding(
                      padding:
                          EdgeInsets.only(left: constraints.maxWidth * 0.010),
                      child: SelectsEmpSuc(
                        width: size.width > 770
                            ? constraints.maxWidth * 0.20
                            : constraints.maxWidth * 0.45,
                        onChanged: (value) {
                          setState(() {
                            gestiones.prospectosProvider.empresa =
                                value as String?;
                            if (gestiones.prospectosProvider.empresa != null) {
                              gestiones.prospectosProvider.nomEmpresa =
                                  gestiones.prospectosProvider.empresa!;
                              gestiones.prospectosProvider.getSucursal();
                            }
                          });
                        },
                        onChanged2: (value) {
                          setState(() {
                            gestiones.prospectosProvider.selectedSucursal =
                                value.toString();
                            if (gestiones.prospectosProvider.selectedSucursal !=
                                null) {
                              RegExp regExp = RegExp(r'\d+$');
                              String? match = regExp.stringMatch(gestiones
                                  .prospectosProvider.selectedSucursal!);
                              if (match != null) {
                                gestiones.prospectosProvider.numeroSucursal =
                                    match;
                                gestiones.getGestiones();
                              }
                            }
                          });
                        },
                      ),
                    )
                  : const SizedBox.shrink(),
                  const SizedBox(height: 10),
                  Scrollbar(
                controller: horizontal,
                thumbVisibility: true,
                trackVisibility: true,
                child: PaginatedDataTable(
                  key: gestiones.keyT,
                   header: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PageCounter(
                        add: addGestion,
                        remove: removeGestion,
                      ),
                      //SizedBox(width: 20),
                    ],
                  ),
                  controller: horizontal,
                  initialFirstRowIndex: gestiones.prospectosProvider.firtsrow,
                  sortColumnIndex: currentSortColumn,
                  sortAscending: isAscending,
                  columns: [
                     DataColumn(
                  label: Expanded(
                    child: Center(
                      child: Text(
                        'NOMBRE CAMPAÑA',
                        textAlign: TextAlign.center,
                        style: StyleLabels.dataColumn2,
                      ),
                    ),
                  ),
                  onSort: (columnIndex, _) {
                    setState(() {
                      currentSortColumn = columnIndex;
                      if (isAscending == true) {
                        isAscending = false;
                        gestiones.gestiones.sort((a, b) =>
                            a.nombreCampana.compareTo(b.nombreCampana));
                      } else {
                        isAscending = true;
                        gestiones.gestiones.sort((a, b) =>
                            b.nombreCampana.compareTo(a.nombreCampana));
                      }
                    });
                  },
                ),
                DataColumn(
                  label: Text(
                    'N° CLIENTE',
                    textAlign: TextAlign.center,
                    style: StyleLabels.dataColumn,
                  ),
                  onSort: (columnIndex, _) {
                    setState(() {
                      currentSortColumn = columnIndex;
                      if (isAscending == true) {
                        isAscending = false;
                        gestiones.gestiones.sort((a, b) =>
                            a.numeroCliente.compareTo(b.numeroCliente));
                      } else {
                        isAscending = true;
                        gestiones.gestiones.sort((a, b) =>
                            b.numeroCliente.compareTo(a.numeroCliente));
                      }
                    });
                  },
                ),
                DataColumn(
                  label: Text(
                    'NOMBRE CLIENTE',
                    textAlign: TextAlign.center,
                    style: StyleLabels.dataColumn,
                  ),
                  onSort: (columnIndex, _) {
                    setState(() {
                      currentSortColumn = columnIndex;
                      if (isAscending == true) {
                        isAscending = false;
                        gestiones.gestiones.sort((a, b) =>
                            a.nombreCliente.compareTo(b.nombreCliente));
                      } else {
                        isAscending = true;
                        gestiones.gestiones.sort((a, b) =>
                            b.nombreCliente.compareTo(a.nombreCliente));
                      }
                    });
                  },
                ),
                DataColumn(
                  label: Text(
                    'RESULTADO ÚLTIMA \n GESTIÓN',
                    textAlign: TextAlign.center,
                    style: StyleLabels.dataColumn,
                  ),
                  onSort: (columnIndex, _) {
                    setState(() {
                      currentSortColumn = columnIndex;
                      if (isAscending == true) {
                        isAscending = false;
                        gestiones.gestiones.sort((a, b) => a
                            .resultadoUltimaGestion
                            .compareTo(b.resultadoUltimaGestion));
                      } else {
                        isAscending = true;
                        gestiones.gestiones.sort((a, b) => b
                            .resultadoUltimaGestion
                            .compareTo(a.resultadoUltimaGestion));
                      }
                    });
                  },
                ),
                DataColumn(
                  label: Text(
                    'NOMBRE DEL\n EJECUTIVO ',
                    textAlign: TextAlign.center,
                    style: StyleLabels.dataColumn,
                  ),
                  onSort: (columnIndex, _) {
                    setState(() {
                      currentSortColumn = columnIndex;
                      if (isAscending == true) {
                        isAscending = false;
                        gestiones.gestiones.sort((a, b) => a
                            .nombreDelEjecutivo
                            .compareTo(b.nombreDelEjecutivo));
                      } else {
                        isAscending = true;
                        gestiones.gestiones.sort((a, b) => b
                            .nombreDelEjecutivo
                            .compareTo(a.nombreDelEjecutivo));
                      }
                    });
                  },
                ),
                DataColumn(
                  label: Text(
                    'FECHA ÚLTIMA \n GESTIÓN',
                    textAlign: TextAlign.center,
                    style: StyleLabels.dataColumn,
                  ),
                  onSort: (columnIndex, _) {
                    setState(() {
                      currentSortColumn = columnIndex;
                      if (isAscending == true) {
                        isAscending = false;
                        gestiones.gestiones.sort((a, b) => a
                            .fechaDeUltimaGestion
                            .compareTo(b.fechaDeUltimaGestion));
                      } else {
                        isAscending = true;
                        gestiones.gestiones.sort((a, b) => b
                            .fechaDeUltimaGestion
                            .compareTo(a.fechaDeUltimaGestion));
                      }
                    });
                  },
                ),
                DataColumn(
                  label: Text(
                    'COMENTARIO',
                    textAlign: TextAlign.center,
                    style: StyleLabels.dataColumn,
                  ),
                  onSort: (columnIndex, _) {
                    setState(() {
                      currentSortColumn = columnIndex;
                      if (isAscending == true) {
                        isAscending = false;
                        gestiones.gestiones.sort(
                            (a, b) => a.comentario.compareTo(b.comentario));
                      } else {
                        isAscending = true;
                        gestiones.gestiones.sort(
                            (a, b) => b.comentario.compareTo(a.comentario));
                      }
                    });
                  },
                ),
                DataColumn(
                  label: Text(
                    'DESCUENTOS',
                    textAlign: TextAlign.center,
                    style: StyleLabels.dataColumn,
                  ),
                  onSort: (columnIndex, _) {
                    setState(() {
                      currentSortColumn = columnIndex;
                      if (isAscending == true) {
                        isAscending = false;
                        gestiones.gestiones.sort(
                            (a, b) => a.descuentos.compareTo(b.descuentos));
                      } else {
                        isAscending = true;
                        gestiones.gestiones.sort(
                            (a, b) => b.descuentos.compareTo(a.descuentos));
                      }
                    });
                  },
                ),
                  ],
                  source: GestionesSource(gestiones.gestiones, context),
                  onRowsPerPageChanged: (value) {
                    setState(() {
                      rowsPerPage = value!;
                    });
                  },
                  rowsPerPage: rowsPerPage,

                ),),

            ],
          ),
        );
      },
    );
  }
}
