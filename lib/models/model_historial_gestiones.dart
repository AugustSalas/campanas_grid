import 'dart:convert';

class ModelHistorialGestiones {
    final String canal;
    final String fecha;
    final String ejecutivo;
    final String resultado;
    final String comentario;
    final String gestion;
    final String statusCliente;
    final String respuestaCliente;

    ModelHistorialGestiones({
        required this.canal,
        required this.fecha,
        required this.ejecutivo,
        required this.resultado,
        required this.comentario,
        required this.gestion,
        required this.statusCliente,
        required this.respuestaCliente,
    });

    factory ModelHistorialGestiones.fromJson(String str) => ModelHistorialGestiones.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ModelHistorialGestiones.fromMap(Map<String, dynamic> json) => ModelHistorialGestiones(
        canal: json["canal"],
        fecha: json["fecha"],
        ejecutivo: json["ejecutivo"],
        resultado: json["resultado"],
        comentario: json["comentario"],
        gestion: json["gestion"],
        statusCliente: json["statusCliente"],
        respuestaCliente: json["respuestaCliente"],
    );

    Map<String, dynamic> toMap() => {
        "canal": canal,
        "fecha": fecha,
        "ejecutivo": ejecutivo,
        "resultado": resultado,
        "comentario": comentario,
        "gestion": gestion,
        "statusCliente": statusCliente,
        "respuestaCliente": respuestaCliente,
    };
}
