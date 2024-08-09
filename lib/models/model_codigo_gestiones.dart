import 'dart:convert';

class ModelCodigoGestiones {
    final int id;
    final String name;
    final String tenant;
    final String callFrom;
    final Configuration configuration;
    final String createdAt;
    final String updatedAt;

    ModelCodigoGestiones({
        required this.id,
        required this.name,
        required this.tenant,
        required this.callFrom,
        required this.configuration,
        required this.createdAt,
        required this.updatedAt,
    });

    factory ModelCodigoGestiones.fromRawJson(String str) => ModelCodigoGestiones.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ModelCodigoGestiones.fromJson(Map<String, dynamic> json) => ModelCodigoGestiones(
        id: json["id"],
        name: json["name"],
        tenant: json["tenant"],
        callFrom: json["callFrom"],
        configuration: Configuration.fromJson(json["configuration"]),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tenant": tenant,
        "callFrom": callFrom,
        "configuration": configuration.toJson(),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
    };
}

class Configuration {
    final Aef aef;
    final Aef afi;
    final Aef fisa;

    Configuration({
        required this.aef,
        required this.afi,
        required this.fisa,
    });

    factory Configuration.fromRawJson(String str) => Configuration.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Configuration.fromJson(Map<String, dynamic> json) => Configuration(
        aef: Aef.fromJson(json["AEF"]),
        afi: Aef.fromJson(json["AFI"]),
        fisa: Aef.fromJson(json["FISA"]),
    );

    Map<String, dynamic> toJson() => {
        "AEF": aef.toJson(),
        "AFI": afi.toJson(),
        "FISA": fisa.toJson(),
    };
}

class Aef {
    final List<String> titular;
    final List<String> terceros;
    final List<String> sinContacto;
    final List<String> tipoGestion;
    final List<String> statusCliente;
    final List<String> causaDelCliente;

    Aef({
        required this.titular,
        required this.terceros,
        required this.sinContacto,
        required this.tipoGestion,
        required this.statusCliente,
        required this.causaDelCliente,
    });

    factory Aef.fromRawJson(String str) => Aef.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Aef.fromJson(Map<String, dynamic> json) => Aef(
        titular: List<String>.from(json["titular"].map((x) => x)),
        terceros: List<String>.from(json["terceros"].map((x) => x)),
        sinContacto: List<String>.from(json["sinContacto"].map((x) => x)),
        tipoGestion: List<String>.from(json["tipoGestion"].map((x) => x)),
        statusCliente: List<String>.from(json["statusCliente"].map((x) => x)),
        causaDelCliente: List<String>.from(json["causaDelCliente"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "titular": List<dynamic>.from(titular.map((x) => x)),
        "terceros": List<dynamic>.from(terceros.map((x) => x)),
        "sinContacto": List<dynamic>.from(sinContacto.map((x) => x)),
        "tipoGestion": List<dynamic>.from(tipoGestion.map((x) => x)),
        "statusCliente": List<dynamic>.from(statusCliente.map((x) => x)),
        "causaDelCliente": List<dynamic>.from(causaDelCliente.map((x) => x)),
    };
}
