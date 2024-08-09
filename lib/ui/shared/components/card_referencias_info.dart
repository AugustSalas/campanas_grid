import 'package:campanas_grid/style_labels/style_labels.dart';
import 'package:flutter/material.dart';

class CardReferenciasInfo extends StatelessWidget {
  final String nombre;
  final String apellidoMat;
  final String apellidoPat;
  final String telefono;
  final String tipoPlan;
  final String idCatParentesco;
  final double width;
  const CardReferenciasInfo({
    super.key,
    required this.width,
    required this.nombre,
    required this.apellidoMat,
    required this.apellidoPat,
    required this.telefono,
    required this.tipoPlan,
    required this.idCatParentesco,
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
                    'Nombre',
                    style: StyleLabels.cardTitle,
                  ),
                  subtitle: Text('$nombre $apellidoPat $apellidoMat', style: StyleLabels.cardSubtitle),
                ),
                ListTile(
                  title: Text(
                    'Telefono',
                    style: StyleLabels.cardTitle,
                  ),
                  subtitle: Text(telefono, style: StyleLabels.cardSubtitle),
                ),
                ListTile(
                  title: Text(
                    'Tipo Plan',
                    style: StyleLabels.cardTitle,
                  ),
                  subtitle: Text(tipoPlan, style: StyleLabels.cardSubtitle),
                ),
                ListTile(
                  title: Text(
                    'ID',
                    style: StyleLabels.cardTitle,
                  ),
                  subtitle: Text(idCatParentesco, style: StyleLabels.cardSubtitle),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
