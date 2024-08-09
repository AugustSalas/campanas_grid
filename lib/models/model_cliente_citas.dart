import 'dart:convert';

class ModelClienteCitas {
    final int idOferta;
    final String nombre;
    final DateTime fecha;

    ModelClienteCitas({
        required this.idOferta,
        required this.nombre,
        required this.fecha,
    });

    factory ModelClienteCitas.fromJson(String str) => ModelClienteCitas.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ModelClienteCitas.fromMap(Map<String, dynamic> json) => ModelClienteCitas(
        idOferta: json["idOferta"],
        nombre: json["nombre"],
        fecha: DateTime.parse(json["fecha"]),
    );

    Map<String, dynamic> toMap() => {
        "idOferta": idOferta,
        "nombre": nombre,
        "fecha": fecha.toIso8601String(),
    };
}
