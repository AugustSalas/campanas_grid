import 'package:campanas_grid/style_labels/style_labels.dart';
import 'package:flutter/material.dart';

class CardGestionesInfo extends StatelessWidget {
  final String fecha;
  final String comentario;
  final String ejecutivo;
  final String gestion;
  final String resultado;
  final String statusCliente;
  final String respuestaCliente;
  final String canal;
  final double width;
  const CardGestionesInfo({
    super.key,
    required this.fecha,
    required this.comentario,
    required this.ejecutivo,
    required this.gestion,
    required this.resultado,
    required this.statusCliente,
    required this.respuestaCliente,
    required this.canal,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: width, 
          height: double.infinity, 
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              bottomLeft: Radius.circular(4),
            ),
            child: Image.network(
              'assets/information.png',
              fit:BoxFit.fill,
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    'Fecha',
                    style: StyleLabels.cardTitle,
                  ),
                  subtitle: Text(fecha, style: StyleLabels.cardSubtitle),
                ),
                ListTile(
                  title: Text(
                    'Comentario',
                    style: StyleLabels.cardTitle,
                  ),
                  subtitle: Text(comentario, style: StyleLabels.cardSubtitle),
                ),
                ListTile(
                  title: Text(
                    'Ejecutivo',
                    style: StyleLabels.cardTitle,
                  ),
                  subtitle: Text(ejecutivo, style: StyleLabels.cardSubtitle),
                ),
                ListTile(
                  title: Text(
                    'Gestión',
                    style: StyleLabels.cardTitle,
                  ),
                  subtitle: Text(gestion, style: StyleLabels.cardSubtitle),
                ),
                ListTile(
                  title: Text(
                    'Resultado',
                    style: StyleLabels.cardTitle,
                  ),
                  subtitle: Text(resultado, style: StyleLabels.cardSubtitle),
                ),
                ListTile(
                  title: Text(
                    'Status cliente',
                    style: StyleLabels.cardTitle,
                  ),
                  subtitle: Text(statusCliente, style: StyleLabels.cardSubtitle),
                ),
                 ListTile(
                  title: Text(
                    'Resultado cliente',
                    style: StyleLabels.cardTitle,
                  ),
                  subtitle: Text(respuestaCliente, style: StyleLabels.cardSubtitle),
                ),
                 ListTile(
                  title: Text(
                    'Canal',
                    style: StyleLabels.cardTitle,
                  ),
                  subtitle: Text(canal, style: StyleLabels.cardSubtitle),
                ),
                
              ],
            ),
          ),
        ),
      ],
    );
  }
}
