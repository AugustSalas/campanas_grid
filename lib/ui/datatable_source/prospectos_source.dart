import 'package:campanas_grid/models/model_prospectos.dart';
import 'package:campanas_grid/providers/prospectos_provider.dart';
import 'package:campanas_grid/style_labels/style_labels.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProspectosSource extends DataTableSource {
  final List<ModelProspectos> tableProspectos;
  final BuildContext context;

  ProspectosSource(this.tableProspectos, this.context);

  @override
  DataRow? getRow(int index) {
    final vTable = tableProspectos[index];
    final prospectos = Provider.of<ProspectosProvider>(context);
    var f = NumberFormat("#,##0.00", "en_US");

    return DataRow(
      cells: [
      DataCell(
        Center(
          child: FittedBox(
            child: Text(
              vTable.propensidad,
              style: StyleLabels.dataCell2,
            ),
          ),
        ),
        onTap: () async {
          prospectos.prospectosScaffoldKey.currentState?.openEndDrawer();
          prospectos.idCliente = vTable.idCliente;
        },
      ),
      DataCell(
        Center(
          child: SelectableText(
            '${vTable.numeroCliente}',
            style: StyleLabels.dataCell2,
          ),
        ),
        onTap: () async {
          prospectos.prospectosScaffoldKey.currentState?.openEndDrawer();
          prospectos.idCliente = vTable.idCliente;
        },
      ),
      DataCell(
        Center(
          child: SelectableText(
            vTable.nombreCliente,
            style: StyleLabels.dataCell2,
          ),
        ),
        onTap: () async {
          prospectos.prospectosScaffoldKey.currentState?.openEndDrawer();
          prospectos.idCliente = vTable.idCliente;
        },
      ),
      DataCell(
        Center(
          child: SelectableText(
            '${vTable.numeroContrato}',
            style: StyleLabels.dataCell2,
          ),
        ),
        onTap: () async {
          prospectos.prospectosScaffoldKey.currentState?.openEndDrawer();
          prospectos.idCliente = vTable.idCliente;
        },
      ),
      DataCell(
        Center(
          child: SelectableText(
            vTable.nombreCampana,
            style: StyleLabels.dataCell2,
          ),
        ),
        onTap: () async {
          prospectos.prospectosScaffoldKey.currentState?.openEndDrawer();
          prospectos.idCliente = vTable.idCliente;
        },
      ),
      DataCell(
        Center(
          child: SelectableText(
            vTable.promos,
            style: StyleLabels.dataCell2,
          ),
        ),
        onTap: () async {
          prospectos.prospectosScaffoldKey.currentState?.openEndDrawer();
          prospectos.idCliente = vTable.idCliente;
        },
      ),
      DataCell(
        Center(
          child: SelectableText(
            vTable.productoSugerido,
            style: StyleLabels.dataCell2,
          ),
        ),
        onTap: () async {
          prospectos.prospectosScaffoldKey.currentState?.openEndDrawer();
          prospectos.idCliente = vTable.idCliente;
        },
      ),
      DataCell(
        Center(
          child: SelectableText(
            //globals.tenantId == 'AFI'
            //  ?
            //'${f.format(vTable.montoADisponer)} USD'
            //:
            '\$ ${f.format(vTable.montoADisponer)} MXN',
            style: StyleLabels.dataCell2,
          ),
        ),
        onTap: () async {
          prospectos.prospectosScaffoldKey.currentState?.openEndDrawer();
          prospectos.idCliente = vTable.idCliente;
        },
      ),
      DataCell(
        Center(
          child: SelectableText(
            //globals.tenantId == 'AFI'
            // ?
            //'${f.format(vTable.montoEstimado)} USD'
            //:
            '\$ ${f.format(vTable.montoEstimado)} MXN',
            style: StyleLabels.dataCell2,
          ),
        ),
        onTap: () async {
          prospectos.prospectosScaffoldKey.currentState?.openEndDrawer();
          prospectos.idCliente = vTable.idCliente;
        },
      ),
      DataCell(
        Center(
          child: SelectableText(
            vTable.plazoSugerido,
            style: StyleLabels.dataCell2,
          ),
        ),
        onTap: () async {
          prospectos.prospectosScaffoldKey.currentState?.openEndDrawer();
          prospectos.idCliente = vTable.idCliente;
        },
      ),
      DataCell(
        Center(
          child: SelectableText(
            vTable.frecuenciaPagoSugerido,
            style: StyleLabels.dataCell2,
          ),
        ),
        onTap: () async {
          prospectos.prospectosScaffoldKey.currentState?.openEndDrawer();
          prospectos.idCliente = vTable.idCliente;
        },
      ),
      DataCell(
        Center(
          child: SelectableText(
            vTable.fechaTermino,
            style: StyleLabels.dataCell2,
          ),
        ),
        onTap: () async {
          prospectos.prospectosScaffoldKey.currentState?.openEndDrawer();
          prospectos.idCliente = vTable.idCliente;
        },
      ),
      DataCell(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              vTable.diasSinGestion,
              style: StyleLabels.dataCell2,
            ),
            const SizedBox(
              width: 10,
            ),
            if (int.parse(vTable.diasSinGestion) <= 3)
              const Icon(
                Icons.warning,
                size: 20,
                color: Color.fromARGB(255, 71, 255, 71),
              )
            else if (int.parse(vTable.diasSinGestion) == 4 ||
                int.parse(vTable.diasSinGestion) == 5)
              const Icon(
                Icons.warning,
                size: 20,
                color: Color.fromARGB(255, 253, 199, 72),
              )
            else if (int.parse(vTable.diasSinGestion) > 5)
              const Icon(
                Icons.warning,
                size: 20,
                color: Color.fromARGB(255, 233, 57, 57),
              )
          ],
        ),
        onTap: () async {
          prospectos.prospectosScaffoldKey.currentState?.openEndDrawer();
          prospectos.idCliente = vTable.idCliente;
        },
      ),
      DataCell(
        Center(
          child: SelectableText(
            vTable.fechaDeUltimaGestion,
            style: StyleLabels.dataCell2,
          ),
        ),
        onTap: () async {
          prospectos.prospectosScaffoldKey.currentState?.openEndDrawer();
          prospectos.idCliente = vTable.idCliente;
        },
      ),
      DataCell(
        Center(
          child: SelectableText(
            vTable.resultadoUltimaGestion,
            style: StyleLabels.dataCell2,
          ),
        ),
        onTap: () async {
          prospectos.prospectosScaffoldKey.currentState?.openEndDrawer();
          prospectos.idCliente = vTable.idCliente;
        },
      ),
      DataCell(
        Center(
          child: SelectableText(
            '${vTable.intentosDeContacto}',
            style: StyleLabels.dataCell2,
          ),
        ),
        onTap: () async {
          prospectos.prospectosScaffoldKey.currentState?.openEndDrawer();
          prospectos.idCliente = vTable.idCliente;
        },
      ),
      DataCell(
        Center(
          child: SelectableText(
            vTable.fechaInicio,
            style: StyleLabels.dataCell2,
          ),
        ),
        onTap: () async {
          prospectos.prospectosScaffoldKey.currentState?.openEndDrawer();
          prospectos.idCliente = vTable.idCliente;
        },
      ),
      DataCell(
        Center(
          child: SelectableText(
            vTable.nombreDelEjecutivo,
            style: StyleLabels.dataCell2,
          ),
        ),
        onTap: () async {
          prospectos.prospectosScaffoldKey.currentState?.openEndDrawer();
          prospectos.idCliente = vTable.idCliente;
        },
      ),
      DataCell(
        Center(
          child: SelectableText(
            '${vTable.numeroSucursal}',
            style: StyleLabels.dataCell2,
          ),
        ),
        onTap: () async {
          prospectos.prospectosScaffoldKey.currentState?.openEndDrawer();
          prospectos.idCliente = vTable.idCliente;
        },
      ),
      DataCell(
        Center(
          child: SelectableText(
            vTable.periodo,
            style: StyleLabels.dataCell2,
          ),
        ),
        onTap: () async {
          prospectos.prospectosScaffoldKey.currentState?.openEndDrawer();
          prospectos.idCliente = vTable.idCliente;
        },
      ),
      DataCell(
        Center(
          child: SelectableText(
            vTable.tipoOferta,
            style: StyleLabels.dataCell2,
          ),
        ),
        onTap: () async {
          prospectos.prospectosScaffoldKey.currentState?.openEndDrawer();
          prospectos.idCliente = vTable.idCliente;
        },
      ),
      DataCell(
        Center(
          child: SelectableText(
            vTable.observaciones,
            style: StyleLabels.dataCell2,
          ),
        ),
        onTap: () async {
          prospectos.prospectosScaffoldKey.currentState?.openEndDrawer();
          prospectos.idCliente = vTable.idCliente;
        },
      ),
      DataCell(
        Center(
          child: SelectableText(
            vTable.appCliente,
            style: StyleLabels.dataCell2,
          ),
        ),
        onTap: () async {
          prospectos.prospectosScaffoldKey.currentState?.openEndDrawer();
          prospectos.idCliente = vTable.idCliente;
        },
      ),
      DataCell(
        Center(
          child: SelectableText(
            vTable.seguros.join(','),
            style: StyleLabels.dataCell2,
          ),
        ),
        onTap: () async {
          prospectos.prospectosScaffoldKey.currentState?.openEndDrawer();
          prospectos.idCliente = vTable.idCliente;
        },
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => tableProspectos.length;

  @override
  int get selectedRowCount => 0;
}