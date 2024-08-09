import 'dart:convert';

class ModelGestiones {
    final int idCliente;
    final int idOferta;
    final String nombreCampana;
    final int numeroCliente;
    final String nombreCliente;
    final String resultadoUltimaGestion;
    final String nombreDelEjecutivo;
    final String fechaDeUltimaGestion;
    final String comentario;
    final String descuentos;

    ModelGestiones({
        required this.idCliente,
        required this.idOferta,
        required this.nombreCampana,
        required this.numeroCliente,
        required this.nombreCliente,
        required this.resultadoUltimaGestion,
        required this.nombreDelEjecutivo,
        required this.fechaDeUltimaGestion,
        required this.comentario,
        required this.descuentos,
    });

    factory ModelGestiones.fromJson(String str) => ModelGestiones.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ModelGestiones.fromMap(Map<String, dynamic> json) => ModelGestiones(
        idCliente: json["idCliente"],
        idOferta: json["idOferta"],
        nombreCampana: json["nombreCampana"],
        numeroCliente: json["numeroCliente"],
        nombreCliente: json["nombreCliente"],
        resultadoUltimaGestion: json["resultadoUltimaGestion"],
        nombreDelEjecutivo: json["nombreDelEjecutivo"],
        fechaDeUltimaGestion: json["fechaDeUltimaGestion"],
        comentario: json["comentario"],
        descuentos: json["descuentos"],
    );

    Map<String, dynamic> toMap() => {
        "idCliente": idCliente,
        "idOferta": idOferta,
        "nombreCampana": nombreCampana,
        "numeroCliente": numeroCliente,
        "nombreCliente": nombreCliente,
        "resultadoUltimaGestion": resultadoUltimaGestion,
        "nombreDelEjecutivo": nombreDelEjecutivo,
        "fechaDeUltimaGestion": fechaDeUltimaGestion,
        "comentario": comentario,
        "descuentos": descuentos,
    };
}
