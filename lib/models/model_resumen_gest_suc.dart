import 'dart:convert';

class ModelResumenGestSuc {
    final int total;
    final int gestionadas;
    final int noGestionadas;
    final int citas;
    final int aprobadas;
    final String campaign;
    final String avance;

    ModelResumenGestSuc({
        required this.total,
        required this.gestionadas,
        required this.noGestionadas,
        required this.citas,
        required this.aprobadas,
        required this.campaign,
        required this.avance,
    });

    factory ModelResumenGestSuc.fromJson(String str) => ModelResumenGestSuc.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ModelResumenGestSuc.fromMap(Map<String, dynamic> json) => ModelResumenGestSuc(
        total: json["total"],
        gestionadas: json["gestionadas"],
        noGestionadas: json["no_gestionadas"],
        citas: json["citas"],
        aprobadas: json["aprobadas"],
        campaign: json["campaign"],
        avance: json["avance"],
    );

    Map<String, dynamic> toMap() => {
        "total": total,
        "gestionadas": gestionadas,
        "no_gestionadas": noGestionadas,
        "citas": citas,
        "aprobadas": aprobadas,
        "campaign": campaign,
        "avance": avance,
    };
}
