import 'dart:convert';

class ModelEjecutivoPerfil {
    final bool success;
    final String perfil;
    final String numEmp;
    final List<Sucursale> sucursales;

    ModelEjecutivoPerfil({
        required this.success,
        required this.perfil,
        required this.numEmp,
        required this.sucursales,
    });

    factory ModelEjecutivoPerfil.fromJson(String str) => ModelEjecutivoPerfil.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ModelEjecutivoPerfil.fromMap(Map<String, dynamic> json) => ModelEjecutivoPerfil(
        success: json["success"],
        perfil: json["perfil"],
        numEmp: json["numEmp"],
        sucursales: List<Sucursale>.from(json["sucursales"].map((x) => Sucursale.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "success": success,
        "perfil": perfil,
        "numEmp": numEmp,
        "sucursales": List<dynamic>.from(sucursales.map((x) => x.toMap())),
    };
}

class Sucursale {
    final String noSucursal;
    final String descripcionSucursal;

    Sucursale({
        required this.noSucursal,
        required this.descripcionSucursal,
    });

    factory Sucursale.fromJson(String str) => Sucursale.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Sucursale.fromMap(Map<String, dynamic> json) => Sucursale(
        noSucursal: json["noSucursal"],
        descripcionSucursal: json["descripcionSucursal"],
    );

    Map<String, dynamic> toMap() => {
        "noSucursal": noSucursal,
        "descripcionSucursal": descripcionSucursal,
    };
}
