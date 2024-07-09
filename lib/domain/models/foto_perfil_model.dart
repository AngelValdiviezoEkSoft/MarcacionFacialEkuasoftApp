
import 'dart:convert';

class FotoPerfilModel {
    FotoPerfilModel({
        required this.base64,
        required this.nombre,
        required this.extension,
    });

    String base64;
    String nombre;
    String extension;

    factory FotoPerfilModel.fromJson(String str) => FotoPerfilModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory FotoPerfilModel.fromMap(Map<String, dynamic> json) => FotoPerfilModel(
        base64: json["base64"],
        nombre: json["nombre"],
        extension: json["extension"],
    );

    Map<String, dynamic> toMap() => {
        "base64": base64,
        "nombre": nombre,
        "extension": extension
    };
}
