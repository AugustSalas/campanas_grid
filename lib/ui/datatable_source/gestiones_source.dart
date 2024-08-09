import 'package:campanas_grid/models/model_gestiones.dart';
import 'package:campanas_grid/providers/gestiones_provider.dart';
import 'package:campanas_grid/style_labels/style_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class GestionesSource extends DataTableSource{
  final List<ModelGestiones> tableGestiones;
  final BuildContext context;

   GestionesSource(this.tableGestiones, this.context);

    @override
  DataRow? getRow(int index) {
    final vTable = tableGestiones[index];
     final gestiones = Provider.of<GestionesProvider>(context);
  
  return DataRow(cells: [
    DataCell(
          Center(
            child: Text(
              vTable.nombreCampana,
              style: StyleLabels.dataCell2,
            ),
          ),
          onTap: () async {
            gestiones.prospectosProvider.idCliente = vTable.idCliente;
            gestiones.gestionesScaffoldKey.currentState!.openEndDrawer();
            
          },
        ),
         DataCell(
          Center(
            child: Text(
              '${vTable.numeroCliente}',
              style: StyleLabels.dataCell2,
            ),
          ),
          onTap: () async {
            gestiones.prospectosProvider.idCliente = vTable.idCliente;
            gestiones.gestionesScaffoldKey.currentState!.openEndDrawer();
            
          },
        ),
        DataCell(
          Center(
            child: Text(
              vTable.nombreCliente,
              style: StyleLabels.dataCell2,
            ),
          ),
          onTap: () async {
            gestiones.prospectosProvider.idCliente = vTable.idCliente;
            gestiones.gestionesScaffoldKey.currentState!.openEndDrawer();
            
          },
        ),
        DataCell(
          Center(
            child: Text(
              vTable.resultadoUltimaGestion,
              style: StyleLabels.dataCell2,
            ),
          ),
          onTap: () async {
            gestiones.prospectosProvider.idCliente = vTable.idCliente;
            gestiones.gestionesScaffoldKey.currentState!.openEndDrawer();
            
          },
        ),
        DataCell(
          Center(
            child: Text(
              vTable.nombreDelEjecutivo,
              style: StyleLabels.dataCell2,
            ),
          ),
          onTap: () async {
            gestiones.prospectosProvider.idCliente = vTable.idCliente;
            gestiones.gestionesScaffoldKey.currentState!.openEndDrawer();
            
          },
        ),
        DataCell(
          Center(
            child: Text(
              vTable.fechaDeUltimaGestion,
              style: StyleLabels.dataCell2,
            ),
          ),
          onTap: () async {
            gestiones.prospectosProvider.idCliente = vTable.idCliente;
            gestiones.gestionesScaffoldKey.currentState!.openEndDrawer();
            
          },
        ),
        DataCell(
          Center(
            child: Text(
              vTable.comentario,
              style: StyleLabels.dataCell2,
            ),
          ),
          onTap: () async {
            gestiones.prospectosProvider.idCliente = vTable.idCliente;
            gestiones.gestionesScaffoldKey.currentState!.openEndDrawer();
            
          },
        ),
        DataCell(
          Center(
            child: Text(
              vTable.descuentos,
              style: StyleLabels.dataCell2,
            ),
          ),
          onTap: () async {
            gestiones.prospectosProvider.idCliente = vTable.idCliente;
            gestiones.gestionesScaffoldKey.currentState!.openEndDrawer();
            
          },
        ),

  ],);
  
  
  }



  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => tableGestiones.length;

  @override
  int get selectedRowCount => 0;

}