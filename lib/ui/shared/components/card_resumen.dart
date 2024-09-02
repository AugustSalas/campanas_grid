import 'package:campanas_grid/style_labels/style_labels.dart';
import 'package:flutter/material.dart';

class CardResumen extends StatelessWidget {
  final String campana;
  final int asignadas;
  final int gestionadas;
  final int noGestionadas;
  final int citas;
  final int dispuestas;
  final String avanceGestion;
  final double width;
  const CardResumen({
    super.key,
    required this.campana,
    required this.asignadas,
    required this.gestionadas,
    required this.noGestionadas,
    required this.citas,
    required this.dispuestas,
    required this.avanceGestion,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: width, // Define el ancho de la imagen aquí
          height: double.infinity, // Abarca toda la altura de la card
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              bottomLeft: Radius.circular(4),
            ),
            child: Image.network(
              'assets/phone_book.png',
              fit: BoxFit.fill,
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
                    'Campaña',
                    style: StyleLabels.cardTitle,
                  ),
                  subtitle: Text(campana,
                      style: StyleLabels.cardSubtitle),
                ),
                ListTile(
                  title: Text(
                    'Asignadas',
                    style: StyleLabels.cardTitle,
                  ),
                  subtitle: Text('$asignadas', style: StyleLabels.cardSubtitle),
                ),
                ListTile(
                  title: Text(
                    'Gestionadas',
                    style: StyleLabels.cardTitle,
                  ),
                  subtitle: Text('$gestionadas', style: StyleLabels.cardSubtitle),
                ),
                ListTile(
                  title: Text(
                    'No Gestionadas',
                    style: StyleLabels.cardTitle,
                  ),
                  subtitle:
                      Text('$noGestionadas', style: StyleLabels.cardSubtitle),
                ),
                ListTile(
                  title: Text(
                    'Citas',
                    style: StyleLabels.cardTitle,
                  ),
                  subtitle:
                      Text('$citas', style: StyleLabels.cardSubtitle),
                ),
                ListTile(
                  title: Text(
                    'Dispuestas',
                    style: StyleLabels.cardTitle,
                  ),
                  subtitle:
                      Text('$dispuestas', style: StyleLabels.cardSubtitle),
                ),
                ListTile(
                  title: Text(
                    'Avance de gestión',
                    style: StyleLabels.cardTitle,
                  ),
                  subtitle:
                      Text(avanceGestion, style: StyleLabels.cardSubtitle),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
