import 'dart:convert';

class ModelPeriodos {
    final List<String> periodos;

    ModelPeriodos({
        required this.periodos,
    });

    factory ModelPeriodos.fromJson(String str) => ModelPeriodos.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ModelPeriodos.fromMap(Map<String, dynamic> json) => ModelPeriodos(
        periodos: List<String>.from(json["periodos"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "periodos": List<dynamic>.from(periodos.map((x) => x)),
    };
}
