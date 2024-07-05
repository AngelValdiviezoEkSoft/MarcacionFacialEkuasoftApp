import 'dart:convert';

class LocalidadType {
    LocalidadType({
      required this.id,
      required this.codigo,
      required this.idEmpresa,
      required this.latitud,
      required this.longitud,
      required this.radio,
      required this.descripcion,
      required this.estado,
      required this.usuarioCreacion,
      required this.fechaCreacion,
      required this.usuarioModificacion,
      this.fechaModificacion,
      required this.esPrincipal,
    });

    String id;
    String codigo;
    String idEmpresa;
    double latitud;
    double longitud;
    double radio;
    String descripcion;
    String estado;
    String usuarioCreacion;
    DateTime fechaCreacion;
    String usuarioModificacion;
    dynamic fechaModificacion;
    bool esPrincipal;

    factory LocalidadType.fromJson(String str) => LocalidadType.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory LocalidadType.fromMap(Map<String, dynamic> json) => LocalidadType(
        id: json["id"] ?? '',
        codigo: json["codigo"] ?? '',
        idEmpresa: json["idEmpresa"] ?? '',
        latitud: json["latitud"] != null ? json["latitud"].toDouble() : 0.0,
        longitud: json["longitud"] != null ? json["longitud"].toDouble() : 0.0,
        radio: json["radio"] != null ? json["radio"].toDouble() : 0.0,
        descripcion: json["descripcion"]  ?? '',
        estado: json["estado"] ?? '',
        usuarioCreacion: json["usuarioCreacion"] ?? '',
        fechaCreacion: json["fechaCreacion"] != null ? DateTime.parse(json["fechaCreacion"]) : DateTime.now(),
        usuarioModificacion: json["usuarioModificacion"] ?? '',
        fechaModificacion: json["fechaModificacion"] ?? '',
        esPrincipal: json["esPrincipal"] ?? false,
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "codigo": codigo,
        "idEmpresa": idEmpresa,
        "latitud": latitud,
        "longitud": longitud,
        "radio": radio,
        "descripcion": descripcion,
        "estado": estado,
        "usuarioCreacion": usuarioCreacion,
        "fechaCreacion": fechaCreacion.toIso8601String(),
        "usuarioModificacion": usuarioModificacion,
        "fechaModificacion": fechaModificacion,
        "esPrincipal": esPrincipal,
    };
}
