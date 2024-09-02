import 'dart:convert';

class ModelBuscador {
    final String nombre;
    final int cliente;
    final int contrato;

    ModelBuscador({
        required this.nombre,
        required this.cliente,
        required this.contrato,
    });

    factory ModelBuscador.fromJson(String str) => ModelBuscador.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ModelBuscador.fromMap(Map<String, dynamic> json) => ModelBuscador(
        nombre: json["nombre"],
        cliente: json["cliente"],
        contrato: json["contrato"],
    );

    Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "cliente": cliente,
        "contrato": contrato,
    };
}
