import 'dart:convert';

class ModelProspectos {
    final String appCliente;
    final List<String> seguros;
    final num montoEstimado;
    final String propensidad;
    final String idSolicitud;
    final int idCliente;
    final int idOferta;
    final String diasSinGestion;
    final int numeroSucursal;
    final String periodo;
    final String nombreCampana;
    final String fechaInicio;
    final String fechaTermino;
    final int numeroCliente;
    final int numeroContrato;
    final String nombreCliente;
    final String productoSugerido;
    final num montoADisponer;
    final String frecuenciaPagoSugerido;
    final String plazoSugerido;
    final String promos;
    final int intentosDeContacto;
    final String resultadoUltimaGestion;
    final String nombreDelEjecutivo;
    final String fechaDeUltimaGestion;
    final String comentario;
    final String descuentos;
    final String observaciones;
    final String tipoOferta;

    ModelProspectos({
        required this.appCliente,
        required this.seguros,
        required this.montoEstimado,
        required this.propensidad,
        required this.idSolicitud,
        required this.idCliente,
        required this.idOferta,
        required this.diasSinGestion,
        required this.numeroSucursal,
        required this.periodo,
        required this.nombreCampana,
        required this.fechaInicio,
        required this.fechaTermino,
        required this.numeroCliente,
        required this.numeroContrato,
        required this.nombreCliente,
        required this.productoSugerido,
        required this.montoADisponer,
        required this.frecuenciaPagoSugerido,
        required this.plazoSugerido,
        required this.promos,
        required this.intentosDeContacto,
        required this.resultadoUltimaGestion,
        required this.nombreDelEjecutivo,
        required this.fechaDeUltimaGestion,
        required this.comentario,
        required this.descuentos,
        required this.observaciones,
        required this.tipoOferta,
    });

    factory ModelProspectos.fromJson(String str) => ModelProspectos.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ModelProspectos.fromMap(Map<String, dynamic> json) => ModelProspectos(
        appCliente: json["appCliente"],
        seguros: List<String>.from(json["seguros"].map((x) => x)),
        montoEstimado: json["montoEstimado"],
        propensidad: json["propensidad"],
        idSolicitud: json["idSolicitud"],
        idCliente: json["idCliente"],
        idOferta: json["idOferta"],
        diasSinGestion: json["diasSinGestion"],
        numeroSucursal: json["numeroSucursal"],
        periodo: json["periodo"],
        nombreCampana: json["nombreCampana"],
        fechaInicio: json["fechaInicio"],
        fechaTermino: json["fechaTermino"],
        numeroCliente: json["numeroCliente"],
        numeroContrato: json["numeroContrato"],
        nombreCliente: json["nombreCliente"],
        productoSugerido: json["productoSugerido"],
        montoADisponer: json["montoADisponer"],
        frecuenciaPagoSugerido: json["frecuenciaPagoSugerido"],
        plazoSugerido: json["plazoSugerido"],
        promos: json["promos"],
        intentosDeContacto: json["intentosDeContacto"],
        resultadoUltimaGestion: json["resultadoUltimaGestion"],
        nombreDelEjecutivo: json["nombreDelEjecutivo"],
        fechaDeUltimaGestion: json["fechaDeUltimaGestion"],
        comentario: json["comentario"],
        descuentos: json["descuentos"],
        observaciones: json["observaciones"],
        tipoOferta: json["tipoOferta"],
    );

    Map<String, dynamic> toMap() => {
        "appCliente": appCliente,
        "seguros": List<dynamic>.from(seguros.map((x) => x)),
        "montoEstimado": montoEstimado,
        "propensidad": propensidad,
        "idSolicitud": idSolicitud,
        "idCliente": idCliente,
        "idOferta": idOferta,
        "diasSinGestion": diasSinGestion,
        "numeroSucursal": numeroSucursal,
        "periodo": periodo,
        "nombreCampana": nombreCampana,
        "fechaInicio": fechaInicio,
        "fechaTermino": fechaTermino,
        "numeroCliente": numeroCliente,
        "numeroContrato": numeroContrato,
        "nombreCliente": nombreCliente,
        "productoSugerido": productoSugerido,
        "montoADisponer": montoADisponer,
        "frecuenciaPagoSugerido": frecuenciaPagoSugerido,
        "plazoSugerido": plazoSugerido,
        "promos": promos,
        "intentosDeContacto": intentosDeContacto,
        "resultadoUltimaGestion": resultadoUltimaGestion,
        "nombreDelEjecutivo": nombreDelEjecutivo,
        "fechaDeUltimaGestion": fechaDeUltimaGestion,
        "comentario": comentario,
        "descuentos": descuentos,
        "observaciones": observaciones,
        "tipoOferta": tipoOferta,
    };
}
