import 'dart:convert';

class ModelInformacionOferta {
    final num tasaOferta;
    final num tasaActual;
    final String proxLiquidar;
    final int id;
    final List<Referencia> referencias;
    final String campaign;
    final num montoDisponibleActual;
    final num montoDisponible;
    final num newMoney;
    final num saldoLiquidar;
    final String idSolicitud;
    final int idCliente;
    final String nombreCliente;
    final String vigencia;
    final num montoCreditoRenovacion;
    final num montoPagoRenovacion;
    final String plazoRenovacion;
    final String frecuenciaARenovar;
    final String promocion;
    final num montoRenovar;
    final String productoRenovar;
    final String productoActual;
    final num montoCreditoActual;
    final num montoPagoActual;
    final String plazoActual;
    final String frecuenciaActual;
    final String fechaUltimoMovimiento;
    final String comentarios;
    final List<String> telefonoDirecto;
    final List<String> telefonoMovil;

    ModelInformacionOferta({
        required this.tasaOferta,
        required this.tasaActual,
        required this.proxLiquidar,
        required this.id,
        required this.referencias,
        required this.campaign,
        required this.montoDisponibleActual,
        required this.montoDisponible,
        required this.newMoney,
        required this.saldoLiquidar,
        required this.idSolicitud,
        required this.idCliente,
        required this.nombreCliente,
        required this.vigencia,
        required this.montoCreditoRenovacion,
        required this.montoPagoRenovacion,
        required this.plazoRenovacion,
        required this.frecuenciaARenovar,
        required this.promocion,
        required this.montoRenovar,
        required this.productoRenovar,
        required this.productoActual,
        required this.montoCreditoActual,
        required this.montoPagoActual,
        required this.plazoActual,
        required this.frecuenciaActual,
        required this.fechaUltimoMovimiento,
        required this.comentarios,
        required this.telefonoDirecto,
        required this.telefonoMovil,
    });

    factory ModelInformacionOferta.fromJson(String str) => ModelInformacionOferta.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ModelInformacionOferta.fromMap(Map<String, dynamic> json) => ModelInformacionOferta(
        tasaOferta: json["tasaOferta"],
        tasaActual: json["tasaActual"],
        proxLiquidar: json["proxLiquidar"],
        id: json["id"],
        referencias: List<Referencia>.from(json["referencias"].map((x) => Referencia.fromMap(x))),
        campaign: json["campaign"],
        montoDisponibleActual: json["montoDisponibleActual"],
        montoDisponible: json["montoDisponible"],
        newMoney: json["newMoney"],
        saldoLiquidar: json["saldoLiquidar"],
        idSolicitud: json["idSolicitud"],
        idCliente: json["idCliente"],
        nombreCliente: json["nombreCliente"],
        vigencia: json["vigencia"],
        montoCreditoRenovacion: json["montoCreditoRenovacion"],
        montoPagoRenovacion: json["montoPagoRenovacion"],
        plazoRenovacion: json["plazoRenovacion"],
        frecuenciaARenovar: json["frecuenciaARenovar"],
        promocion: json["promocion"],
        montoRenovar: json["montoRenovar"],
        productoRenovar: json["productoRenovar"],
        productoActual: json["productoActual"],
        montoCreditoActual: json["montoCreditoActual"],
        montoPagoActual: json["montoPagoActual"],
        plazoActual: json["plazoActual"],
        frecuenciaActual: json["frecuenciaActual"],
        fechaUltimoMovimiento: json["fechaUltimoMovimiento"],
        comentarios: json["comentarios"],
        telefonoDirecto: List<String>.from(json["telefonoDirecto"].map((x) => x)),
        telefonoMovil: List<String>.from(json["telefonoMovil"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "tasaOferta": tasaOferta,
        "tasaActual": tasaActual,
        "proxLiquidar": proxLiquidar,
        "id": id,
        "referencias": List<dynamic>.from(referencias.map((x) => x.toMap())),
        "campaign": campaign,
        "montoDisponibleActual": montoDisponibleActual,
        "montoDisponible": montoDisponible,
        "newMoney": newMoney,
        "saldoLiquidar": saldoLiquidar,
        "idSolicitud": idSolicitud,
        "idCliente": idCliente,
        "nombreCliente": nombreCliente,
        "vigencia":vigencia,
        "montoCreditoRenovacion": montoCreditoRenovacion,
        "montoPagoRenovacion": montoPagoRenovacion,
        "plazoRenovacion": plazoRenovacion,
        "frecuenciaARenovar": frecuenciaARenovar,
        "promocion": promocion,
        "montoRenovar": montoRenovar,
        "productoRenovar": productoRenovar,
        "productoActual": productoActual,
        "montoCreditoActual": montoCreditoActual,
        "montoPagoActual": montoPagoActual,
        "plazoActual": plazoActual,
        "frecuenciaActual": frecuenciaActual,
        "fechaUltimoMovimiento": fechaUltimoMovimiento,
        "comentarios": comentarios,
        "telefonoDirecto": List<dynamic>.from(telefonoDirecto.map((x) => x)),
        "telefonoMovil": List<dynamic>.from(telefonoMovil.map((x) => x)),
    };
}

class Referencia {
    final String nombre;
    final String apellidoMat;
    final String apellidoPat;
    final List<NumsContacto> numsContacto;
    final int idCatParentesco;

    Referencia({
        required this.nombre,
        required this.apellidoMat,
        required this.apellidoPat,
        required this.numsContacto,
        required this.idCatParentesco,
    });

    factory Referencia.fromJson(String str) => Referencia.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Referencia.fromMap(Map<String, dynamic> json) => Referencia(
        nombre: json["nombre"],
        apellidoMat: json["apellidoMat"],
        apellidoPat: json["apellidoPat"],
        numsContacto: List<NumsContacto>.from(json["numsContacto"].map((x) => NumsContacto.fromMap(x))),
        idCatParentesco: json["idCatParentesco"],
    );

    Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "apellidoMat": apellidoMat,
        "apellidoPat": apellidoPat,
        "numsContacto": List<dynamic>.from(numsContacto.map((x) => x.toMap())),
        "idCatParentesco": idCatParentesco,
    };
}

class NumsContacto {
    final String telefono;
    final String tipoPlan;

    NumsContacto({
        required this.telefono,
        required this.tipoPlan,
    });

    factory NumsContacto.fromJson(String str) => NumsContacto.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory NumsContacto.fromMap(Map<String, dynamic> json) => NumsContacto(
        telefono: json["telefono"],
        tipoPlan: json["tipoPlan"],
    );

    Map<String, dynamic> toMap() => {
        "telefono": telefono,
        "tipoPlan": tipoPlan,
    };
}
